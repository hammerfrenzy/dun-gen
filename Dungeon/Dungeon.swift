//
//  Dungeon.swift
//  dun-gen
//
//  Created by Wyatt Beavers on 7/28/16.
//  Copyright © 2016 HCSS. All rights reserved.
//

import Foundation

/**********************************************************
 * Dungeon resolves a dependency on GeneratorProtocol via
 * constructor, and uses it to create a cell layout.
 **********************************************************/

class Dungeon {
    
    let generator: GeneratorProtocol
    let size: Int
    
    let minimumSizeThreshold = 100  // try to make the layout larger than this when generating dungeon
    let maximumRerollAttempts = 5   // number of times to retry if the dungeon is smaller than the minimum
    
    init(generator: GeneratorProtocol, size: Int) {
        self.generator = generator
        self.size = max(minimumSizeThreshold, size)
    }
    
    /**
     * Creates a random layout based on the supplied generator.
     * If the layout is smaller than the minimum size, we'll
     * try again to get a layout that fulfills the requirement,
     * up to the retry limit.
     */
    func generateDungeon() -> [Cell] {
        var layout = generator.generateLayout(cellCount: size)
        
        var attempts = 0
        while layout.count < minimumSizeThreshold, attempts < maximumRerollAttempts {
            attempts += 1
            let newAttempt = generator.generateLayout(cellCount: size)
            if newAttempt.count > layout.count {
                layout = newAttempt
            }
        }
        
        return layout
    }
}
