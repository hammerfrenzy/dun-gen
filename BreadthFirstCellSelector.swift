//
//  BreadthFirstCellSelector.swift
//  dun-gen
//
//  Created by Wyatt Beavers on 7/28/16.
//  Copyright © 2016 HCSS. All rights reserved.
//

import Foundation

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
    
    /*
     * 'Implementations' specific to this class
     */
    
    func specificEnqueue(_ cell: Cell) {
        addCell(cell)
    }
    
    func specificDequeue() -> Cell? {
        return getNextCell()
    }
    
    func specificHasAnotherCell() -> Bool {
        return hasAnotherCell()
    }
    
}
