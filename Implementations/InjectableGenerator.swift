//
//  InjectableGenerator.swift
//  dun-gen
//
//  Created by Wyatt Beavers on 7/29/16.
//  Copyright © 2016 HCSS. All rights reserved.
//

import Foundation

/**********************************************************
 * An implementation of GeneratorProtocol that receives its
 * dependency on CellSelectorProtocol via Constructor Injection.
 **********************************************************/

struct InjectableGenerator: GeneratorProtocol {
    
    let cellSelector: CellSelectorProtocol // Dependency Injected via constructor
    
    init(cellSelector: CellSelectorProtocol) {
        self.cellSelector = cellSelector
    }
    
    /**
     * Generates a connected list of `Cell`s by exploring
     * around a root. Unexplored cells are added to and
     * removed from the cellSelector based on the injected
     * behavior.
     */
    func generateLayout(cellCount: Int) -> [Cell] {
        let root = Cell(coord: (0, 0))
        
        var allCells = [Cell]()
        allCells.append(root)
        
        cellSelector.addCell(root)
        while cellSelector.hasAnotherCell() && allCells.count < cellCount {
            let parent = cellSelector.getNextCell()!
            
            let neighbors = parent.explore(allCells)
            allCells.append(contentsOf: neighbors)
            
            for cell in neighbors {
                cellSelector.addCell(cell)
            }
        }
        
        return allCells
    }
}
