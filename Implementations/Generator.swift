//
//  Generator.swift
//  dun-gen
//
//  Created by Wyatt Beavers on 7/28/16.
//  Copyright © 2016 HCSS. All rights reserved.
//

import Foundation

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
