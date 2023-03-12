/*
Lightweight Automated Planning Toolkit
Copyright (C) 2015

<contributors>
Miquel Ramirez <miquel.ramirez@rmit.edu.au>
</contributors>

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/

#pragma once

#include <vector>
#include <cassert>
#include <functional>
#include <queue>
#include <memory>

#include <lapkt/search/interfaces/open_list.hxx>
#include <lapkt/search/components/stl_unordered_map_closed_list.hxx>

namespace aptk {

//! An adapter to compare proper nodes in the open list, not pointers.
template <typename T>
struct StlNodePointerAdapter {
	bool operator()( const T& p1, const T& p2 ) const { return *p1 > *p2 ; }
};


template <typename NodeType,
          typename Heuristic,
          typename Container = std::vector< std::shared_ptr< NodeType > >,
          typename Comparer = StlNodePointerAdapter< std::shared_ptr< NodeType > > >

class StlSortedOpenList : public OpenList<NodeType, std::priority_queue<std::shared_ptr<NodeType>, Container, Comparer>>
{
public:
	typedef std::shared_ptr<NodeType> NodePtrType;

	//! The constructor of a sorted open list needs to specify the heuristic to sort the nodes with
	StlSortedOpenList(Heuristic&& heuristic, bool delayed = false)
		: _heuristic(std::move(heuristic)), _delayed(delayed)
	{}
	virtual ~StlSortedOpenList() = default;
	
	// Disallow copy, but allow move
	StlSortedOpenList(const StlSortedOpenList& other) = delete;
	StlSortedOpenList(StlSortedOpenList&& other) = default;
	StlSortedOpenList& operator=(const StlSortedOpenList& rhs) = delete;
	StlSortedOpenList& operator=(StlSortedOpenList&& rhs) = default;

	bool insert(const NodePtrType& node) override {
		// We deal here with the case where the state we want to insert in the open list was already
		// inserted there with a possibly different g cost value.
		if (update(node)) return false;

		// If using delayed evaluation, set the heuristic value to that of the parent; otherwise, compute it anew.
		if (_delayed) {
			node->inherit_heuristic_estimate();
		} else {
			node->evaluate_with(_heuristic);
		}
		
		if ( node->dead_end() ) return false;
		this->push( node );
		already_in_open_.put( node );
		return true;
	}

	virtual NodePtrType get_next() override {
		assert( !is_empty() );
		NodePtrType node = this->top();
		this->pop();
		already_in_open_.remove(node);
		
		if (_delayed) { // If using delayed evaluation, we update the heuristic value of the node before returning it.
			node->evaluate_with(_heuristic);
		}
		
		return node;
	}

	virtual bool is_empty() const override {
		return this->empty();
	}

	//! The heuristic we'll use to sort the nodes
	Heuristic _heuristic;
	
	//! Whether to use delayed evaluation or not
	bool _delayed;
	
	//! A list of nodes which are already in the open list
	StlUnorderedMapClosedList< NodeType > already_in_open_;
	
protected:
	//! Check if the open list already contains a node 'previous' referring to the same state.
	//! If that is the case, there'll be no need to reinsert the node, and we signal so returning true.
	//! If, in addition, 'previous' had a higher g-value, we do an in-place modification of it.
	bool update(NodePtrType node) {
		NodePtrType previous = already_in_open_.seek(node);
		if (previous == nullptr) return false; // No node with the same state is in the open list
		
		// Else the node was already in the open list and we might want to update it
		
		// @TODO: Very important: updating g is correct provided that
		// the order of the nodes in the open list is not changed by
		// updating it. This is an open problem with the design,
		// and a more definitive solution needs to be found (soon).
		if (node->g < previous->g) {
			previous->g = node->g;
			previous->action = node->action;
			previous->parent = node->parent;
		}
		
		return true;
	}
};

}
