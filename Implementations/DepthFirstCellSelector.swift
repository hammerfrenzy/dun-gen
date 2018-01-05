//
//  DepthFirstCellSelector.swift
//  dun-gen
//
//  Created by Wyatt Beavers on 7/29/16.
//  Copyright © 2016 HCSS. All rights reserved.
//

import Foundation

struct DepthFirstCellSelector: CellSelectorProtocol {
    
    var queue: Queue<Cell>
    
    init() {
        queue = Queue()
    }
    
    func addCell(_ cell: Cell) {
        queue.enqueue(cell)
    }
    
    func getNextCell() -> Cell? {
        return queue.dequeue()
    }
    
    func hasAnotherCell() -> Bool {
        return queue.hasNext()
    }
}
