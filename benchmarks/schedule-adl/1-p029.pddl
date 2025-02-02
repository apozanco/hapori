


(define (problem schedule-p5-s1-c2-w2-o2)
(:domain schedule)
(:objects 
    P0
    P1
    P2
    P3
    P4
 - part
    CIRCULAR
 - ashape
    BLUE
    YELLOW
 - colour
    ONE
    TWO
 - width
    FRONT
    BACK
 - anorient
)
(:init
(HAS-PAINT IMMERSION-PAINTER BLUE)
(HAS-PAINT SPRAY-PAINTER BLUE)
(HAS-PAINT IMMERSION-PAINTER YELLOW)
(HAS-PAINT SPRAY-PAINTER YELLOW)
(CAN-ORIENT DRILL-PRESS FRONT)
(CAN-ORIENT PUNCH FRONT)
(CAN-ORIENT DRILL-PRESS BACK)
(CAN-ORIENT PUNCH BACK)
(HAS-BIT DRILL-PRESS ONE)
(HAS-BIT PUNCH ONE)
(HAS-BIT DRILL-PRESS TWO)
(HAS-BIT PUNCH TWO)
(SHAPE P0 CYLINDRICAL)
(SURFACE-CONDITION P0 ROUGH)
(PAINTED P0 BLUE)
(TEMPERATURE P0 COLD)
(SHAPE P1 CYLINDRICAL)
(SURFACE-CONDITION P1 SMOOTH)
(PAINTED P1 BLUE)
(HAS-HOLE P1 ONE FRONT)
(TEMPERATURE P1 COLD)
(SHAPE P2 CIRCULAR)
(SURFACE-CONDITION P2 ROUGH)
(PAINTED P2 YELLOW)
(HAS-HOLE P2 TWO BACK)
(TEMPERATURE P2 COLD)
(SHAPE P3 CIRCULAR)
(SURFACE-CONDITION P3 ROUGH)
(PAINTED P3 YELLOW)
(TEMPERATURE P3 COLD)
(SHAPE P4 CYLINDRICAL)
(SURFACE-CONDITION P4 POLISHED)
(TEMPERATURE P4 COLD)
)
(:goal
(and
(SHAPE P0 CYLINDRICAL)
(HAS-HOLE P0 ONE FRONT)
(SHAPE P1 CYLINDRICAL)
(SURFACE-CONDITION P1 POLISHED)
(SHAPE P2 CYLINDRICAL)
(PAINTED P2 YELLOW)
(HAS-HOLE P2 TWO FRONT)
(SHAPE P3 CYLINDRICAL)
(SURFACE-CONDITION P3 SMOOTH)
(PAINTED P3 BLUE)
(SURFACE-CONDITION P4 SMOOTH)
)
)
)


