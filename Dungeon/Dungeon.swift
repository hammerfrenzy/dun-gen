//
//  Dungeon.swift
//  dun-gen
//
//  Created by Wyatt Beavers on 7/28/16.
//  Copyright © 2016 HCSS. All rights reserved.
//

import Foundation

class Dungeon {
    
    let generator: GeneratorProtocol
    
    init(_ generator: GeneratorProtocol) {
        self.generator = generator
    }
    
    func generateDungeon() -> [Cell] {
        var cells = [Cell]()
        repeat {
            cells = generator.generateLayout(cellCount: 500)
        }
        while cells.count <= 25
        
        return cells
    }
    
}
