//
//  InjectableGenerator.swift
//  dun-gen
//
//  Created by Wyatt Beavers on 7/29/16.
//  Copyright © 2016 HCSS. All rights reserved.
//

import Foundation

struct InjectableGenerator: GeneratorProtocol {
    
    let cellSelector: CellSelectorProtocol // Dependency
    
    init(cellSelector: CellSelectorProtocol) {
        self.cellSelector = cellSelector
    }
    
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
