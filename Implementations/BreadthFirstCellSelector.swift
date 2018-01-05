//
//  BreadthFirstCellSelector.swift
//  dun-gen
//
//  Created by Wyatt Beavers on 7/28/16.
//  Copyright © 2016 HCSS. All rights reserved.
//

import Foundation

/**********************************************************
 * Implementation of CellSelectorProtocol
 * that creates a dungeon in a breadth first order,
 * resulting in a more 'blob-like' shape.
 **********************************************************/

struct BreadthFirstCellSelector: CellSelectorProtocol {
    
    var stack: Stack<Cell>
    
    init() {
        stack = Stack()
    }
    
    func addCell(_ cell: Cell) {
        stack.push(cell)
    }
    
    func getNextCell() -> Cell? {
        return stack.pop()
    }
    
    func hasAnotherCell() -> Bool {
        return stack.hasNext()
    }
}
