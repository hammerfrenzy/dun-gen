//
//  Generator.swift
//  dun-gen
//
//  Created by Wyatt Beavers on 7/28/16.
//  Copyright © 2016 HCSS. All rights reserved.
//

import Foundation

/**********************************************************
 * This implementation of GeneratorProtocol doesn't use
 * dependency injection.  Rather than relying on a protocol
 * definition of CellSelector, it always uses the concrete
 * BreadthFirstCellSelector.
 **********************************************************/

struct Generator: GeneratorProtocol {
   
    func generateLayout(cellCount: Int) -> [Cell] {
        let cellSelector = BreadthFirstCellSelector() // Dependency isn't injected!
        let root = Cell(coord: (0, 0))
        
        var allCells = [Cell]()
        allCells.append(root)
        
        cellSelector.specificEnqueue(root)
        while cellSelector.specificHasAnotherCell() && allCells.count < cellCount {
            let parent = cellSelector.specificDequeue()!
            
            let neighbors = parent.explore(allCells)
            allCells.append(contentsOf: neighbors)
            
            for cell in neighbors {
                cellSelector.addCell(cell)
            }
        }

        return allCells
    }
}

 //MARK: - Concrete BreadthFirstCellSelector implementations to use as examples in Generator.swift

extension BreadthFirstCellSelector {
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
