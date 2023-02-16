;; =========================================================================    
;;  (C) Copyright 2006, 2008 
;;      Universidad Carlos III de Madrid
;;      Planning & Learning Group (PLG)
;; 
;; =========================================================================
;; 
;; This file is part of SAYPHI
;; 
;; 
;; SAYPHI is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.
;; 
;; SAYPHI is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;; 
;; You should have received a copy of the GNU General Public License
;; along with SAYPHI.  If not, see <http://www.gnu.org/licenses/>.
;; ========================================================================

;; Author: Tomas de la Rosa 
;; Description: Functions for output & printing
;; Date: 2006.01.04
;; 
;; ========================================================================

(defmacro say-indent (depth)
   `(let ((indent-len (if (> ,depth 20) 20 ,depth)))
      (make-sequence 'string indent-len :initial-element #\ )))

(defun binary-int (int)
  (setf *print-base* 2 
	*print-radix* t)
  (write int)
  (setf *print-base* 10 
	*print-radix* nil))
 

(defun pp-hash-table (htable)
  (maphash #'(lambda (key value)
	       (format t "~%~a :~a" key value)) htable))

(defun pp-predicate-pos (pred-pos)
  (let* ((predicates (dom-predicates *pspace*))
	 (objects (problem-inheritobjects *current-problem*))
	 (poslist (objpos-from-mappos (cdr pred-pos) 
				      (gethash (car pred-pos) predicates) objects))
	 (inst (cons (car pred-pos) (instances-from-poslist poslist objects))))
    (format t "~a"  inst)))



(defun pp-predicate-state (pred pred-bitmap args objects &optional (output 'printed))
  (let ((pred-inst (realinstances-from-bitmap pred-bitmap args objects))
	(result nil))
    (mapcar #'(lambda (inst)
		(if (eq output 'list)
		    (push (cons pred inst) result)
		    (format t "~%    ~a"  (cons pred inst))))
	    pred-inst)
    result))
  
(defun pp-functor-state (pred varsmap args objects &optional (output 'printed))
  (let ((result nil))
    (dotimes (i (length varsmap))
	(when (numberp (aref varsmap i))
	    (let ((var-inst (realinst-from-mappos i args objects)))
	      (if (eq output 'list)
		  (push (list '= (cons pred var-inst)  (aref varsmap i)) result)
		  (format t "~%    ~a = ~a "  (cons pred var-inst)  (aref varsmap i))))))
    result))

;; If output=printed, it will print the state
;; if output=list, it will return a list
(defun pp-state (state &optional (output 'printed))
  (let ((predicates (dom-predicates *pspace*))
	(functors (dom-functors *pspace*))
	(objects (problem-inheritobjects *current-problem*))
	(result nil))
    (maphash #'(lambda (pred bitmap)
		 (let ((state (if (simple-bit-vector-p bitmap)
				  (pp-predicate-state pred bitmap (gethash pred predicates) objects output)
				  (pp-functor-state pred bitmap (gethash pred functors) objects output))))
		   (if (eq output 'list)
		       (setq result (append state result)))))
	     state)
    (if (eq output 'list)
	result)))


;; The output standard for IPC
;; We set the action costs directly to [1]
(defun say-print-solution-ipc (solution &optional (stream t))
  (let ((planaction-counter 0))
    (when (solution-found solution)
      (dolist (i-node (solution-path solution))
	(cond ((lhnode-p i-node)
	       (dolist (i-lhaction (lhnode-lookahead-plan i-node))
		 (format stream "~d: " planaction-counter)
		 (say-print-oneline (gaction-planaction i-lhaction) stream)
		 (format stream " [1]~%")
		 (incf planaction-counter)))
	      (t
 	       (format stream "~d: " planaction-counter)
	       (say-print-oneline (snode-plan-action i-node) stream)
	       (format stream " [1]~%")
	       (incf planaction-counter)))
	     ))))


;; For those lists that must be printed in one line, and the lisp pretty-print
;; counts the stream width.
(defun say-print-oneline(list stream)
  (format stream "(")
  (dolist (element list)
    (cond ((listp element)
	   (say-print-oneline element stream))
	  (t (format stream "~a " element))))
  (format stream ")"))

;; DB: it allows printing the solution on any stream, and also allows checking whether we are in the format of the IPC
(defun say-pp-solution (solution &optional (evaltrace nil) (stream t) (ipc-p nil))
  (let ((planaction-counter 0) (out-trace "") (lh-start nil))
    (cond ((or ipc-p (> *say-output* 0))
	   (if (not ipc-p)
	       (if (solution-found solution)
		   (format stream "~% Solution: ")
		   (format stream "~% Path When Stopped: ")))
	   (dolist (i-node (solution-path solution) solution)
	     (if evaltrace
		 (setf out-trace (format nil "{g:~2$ , h:~2$ , f:~2$}" 
					 (snode-g-value i-node) (snode-h-value i-node) (snode-f-value i-node))) 
		 (setf out-trace ""))
	     (cond ((lhnode-p i-node)
		    (setf lh-start t)
		    (dolist (i-lhaction (mapcar #'cons (lhnode-lookahead-plan i-node)
						(lhnode-lookahead-costs i-node)))
		      (format stream "~%     ~d: ~a [~3$]~a" planaction-counter (gaction-planaction (car i-lhaction))
			      (cdr i-lhaction) (if lh-start "!" ""))
		      (setf lh-start nil)
		      (incf planaction-counter)))
		   (t
		    (format stream "~%     ~d: ~a [~3$]  ~a" planaction-counter (snode-plan-action i-node) 
			    (snode-cost i-node) out-trace)
		    (incf planaction-counter)))))
	  (t solution))))


(defun print-all-solutions ()
  (when (hash-table-p *say-hash-solutions*)
    (maphash #'(lambda (n sol)
	       (format t "~% Solution NO. ~a" n)
	       (say-pp-solution sol))
	     *say-hash-solutions*)))


(defun pp-relaxed-plan (relaxed-plan)
  (let ((action-counter 0))
    (dolist (i-rxstep relaxed-plan)
      (incf action-counter)
      (format t "~%     Rx~d: [~a]" 
 	      action-counter (gaction-planaction i-rxstep))
)))


(defun pp-achieved-graph (achiev-graph)
  (format t "~% >> -- Achieved Graph -- ")
  (maphash #'(lambda (layer ht-proplayer)
	       (format t "~% >>>> Layer ~a" layer)
	       (pp-hash-table ht-proplayer))
	   achiev-graph))


(defun pp-solution-gptrace (solution problem)
  (let ((objects (problem-inheritobjects problem))
	(planaction-counter 1))
    (dolist (i-node (solution-path solution) solution)
      (let ((plan-action (snode-applied-action i-node)))
	
	       (format t "~% ~d: ~a ~a" planaction-counter (car plan-action)
		       (instance-plan-action plan-action objects))
	       (incf planaction-counter)
	       (format t  "~%    Relaxed-plan:")
	       (pp-relaxed-plan (snode-relaxed-plan i-node))
	       (format t  "~%    G1 goals:~%")
;; 	       (pp-state (snode-focus-goals i-node))
;; 	       (format t "~%   _______________________________________________________")
	       )
      )))



(defun print-search-node (node open-list)
  (declare (ignore open-list))
  (cond ((= *say-output* 3)
	 (when (snode-p (snode-parent node))
	   (format t "~%~% EVALUATIONS:")
	   (dolist (i-sibling (snode-children (snode-parent node)))
	     (format t "~% ~a" i-sibling)))
	 (format t "~% ----------------------------------------------")
	 (format t "~% [~d  ~d h:~10,2f q:~d] ~a <~a>" 
		 (snode-number node) (snode-depth node) (snode-h-value node) 
		 (snode-f-value node)
		 (say-indent (snode-depth node)) (snode-applied-action node))
	 (format t "~% ----------------------------------------------"))
	((= *say-output* 2)
	 (format t "~% [~d ~t~d h:~3$  g:~d  f:~d]{~d}[~d] ~a [~a]" 
		 (snode-number node)
;; 		 (snode-hash-code node)
 		 (snode-depth node) 
		 (snode-h-value node) (snode-g-value node)
		 (snode-f-value node)
		 (if (snode-p (snode-parent node))
		   (length (snode-children (snode-parent node))) 0)
		 (getf (problem-plist *current-problem*) :node-evaluated)
;; 		 (say-indent (snode-depth node)) 
		 (cond ((lhnode-p node)
			(mapcar #'gaction-planaction (lhnode-lookahead-plan node)))
		       (t (snode-plan-action node)))
		 (snode-cost node)))
    ))



(defun sayout-initialize ()
  (declare (special *current-problem*))
  (when (> *say-output* 1)
    (format t "Instantiating Actions... ")))

(defun sayout-search (stream alg heuristic cost)
  (when (> *say-output* 1)
    (format stream "~%Planner Parameters")
    (format stream "~%   Algorithm: ~a" alg)
    (format stream "~%   Heuristic Function: ~a" heuristic)
    (unless (null cost)
      (format stream "~%   Cost Function: ~a" cost)) 
    (format stream "~%_____________________________________________________________")
    (format t "~%Planning...~%~%")))
 

(defun pp-welcome ()
  (format t "~%~%~%")
  (format t "~% _______________________________________________")
  (format t "~%                                                ")
  (format t "~%              SAYPHI PLANNER v 2.0              ")
  (format t "~%                                                ")
  (format t "~%        UNIVERSIDAD CARLOS III DE MADRID        ")
  (format t "~%         PLANNING & LEARNING GROUP (PLG)        ")
  (format t "~%                                                ")
  (format t "~% _______________________________________________~% "))  



(defun pp-depth-indent (depth)
  (let ((indent " "))
    (dotimes (i depth indent)
      (setf indent (concatenate 'string indent " ")))))


(defun pp-search-tree (stream node &optional (depth nil))
  (let ((max-depth (if depth depth 100)))
    (cond ((<= (snode-depth node) max-depth)
      (format stream "~%~a~a~d[~a] ~a [~a] {~2$,~2$,~2$} - [~a]"
	      (pp-depth-indent (snode-depth node))
	      (if (snode-closed node) "!" " ")
	      (snode-number node) (snode-depth node) (snode-plan-action node) (snode-cost node)
	      (snode-g-value node) (snode-h-value node) (snode-f-value node) (snode-h-plus node))
	   (dolist (i-child (snode-children node))
	     (pp-search-tree stream i-child max-depth)))
	  (t
	   (format t "--cut!"))
	  )))
  
;; For debuggin, only pass the list of nodes, like open-list
(defun pp-node-list (node-list &key (stream t))
  (format stream "~%>> Node List: ")
  (dolist (inode node-list)
    (format stream "~a " (snode-number inode))))

(defun plan-to-file ()
  (let ((solution *say-solution*)
        (planaction-counter 1) 
        (out-trace "")
        (output-file (open (format nil "~a.soln" *problem-file*) :direction 
			   :output :if-exists :supersede :if-does-not-exist :create)))
     (cond ((> *say-output* 0)
           (if (solution-found solution)
               (format t "~% Solution: ")
	       (format t "~% Path When Stopped: "))
           (dolist (i-node (solution-path solution) solution)
             (format output-file "~%     ~d: ~a [~a]  ~a" planaction-counter 
		     (snode-plan-action i-node) (snode-cost i-node) out-trace)
             (incf planaction-counter))))
    (format output-file "~%~a" solution)
    (close output-file)
    solution))


(defun pp-list-sayphi (list &optional (tab 1) (ostream t) lowercasep same-line-p)
  (dolist (literal list)
      (format ostream (format nil (concatenate 'string (if same-line-p " " "~~%")
                           (if lowercasep
                           "~~~dt~~(~~s~~)"
                           "~~~dt~~s"))
                  tab)
          literal)))


(defun action-to-xml (stream gaction index cost)
  (format stream "    <action name=\"~a\" " (car (gaction-planaction gaction)))
  (when index (format stream "index=\"~a\" " index)) 
  (when cost (format stream "cost=\"~a\" >~%" cost))			
  (dolist (i-parameter (cdr (gaction-planaction gaction)))
    (format stream "      <term name=\"~a\"/>~%" i-parameter))
  (format stream "    </action>~%")
  )


(defun solution-to-xml (stream id &optional (solution *say-solution*))
  (let ((planaction-counter 0))
    (format stream "  <plan ")
    (when id (format stream "id=\"~a\" " id))
    (format stream "domain=\"~a\" problem=\"~a\">~%" (car (dom-name *pspace*)) *problem-file*) 
    (format stream "    <complete/>~%")
    (format stream "    <property name=\"cost\" value=\"~3$\" />~%" (solution-total-cost solution))
    (format stream "    <property name=\"length\" value=\"~d\" />~%" (solution-length solution))
    (format stream "    <property name=\"computation_time\" value=\"~3$\" />~%" (solution-total-time solution))

    (dolist (i-node (solution-path solution))
      (cond ((lhnode-p i-node) ;; lookahead states
	     (dolist (i-lhaction (mapcar #'cons (lhnode-lookahead-plan i-node) (lhnode-lookahead-costs i-node)))
	       (action-to-xml stream (car i-lhaction) planaction-counter (cdr i-lhaction))
	       (incf planaction-counter)))
	    (t ;; Standard Actions
	     (action-to-xml stream (snode-applied-action i-node) planaction-counter (snode-cost i-node))
	     (incf planaction-counter))))			
      (format stream "  </plan>~%")))
	

(defun all-solutions-to-xml (stream &optional (all-solutions *say-hash-solutions*))
  (format stream "<?xml version=\"1.0\" encoding=\"UTF-8\"?>~%")
  (format stream "<plans domain=\"~a\" problem=\"~a\">~%" (car (dom-name *pspace*)) *problem-file*) 
  (cond ((hash-table-p *say-hash-solutions*)
	 (maphash #'(lambda (key solution)
		      (solution-to-xml stream key solution))
	   all-solutions))
	(t (solution-to-xml stream nil)))
  (format stream "</plans>~%"))

	       
(defun pp-solutions-costs (&optional (stream t))
  (when (hash-table-p *say-hash-solutions*)
    (maphash #'(lambda (num solution)
		 (format stream "~% Sol num:~a   Cost: ~4$" num (solution-total-cost solution)))
	     *say-hash-solutions*)))
