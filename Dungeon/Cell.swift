//
//  Cell.swift
//  dun-gen
//
//  Created by Wyatt Beavers on 7/26/16.
//  Copyright © 2016 HCSS. All rights reserved.
//

import Foundation

typealias Coord = (x: Int, y: Int)
func +(left: Coord, right: Coord) -> Coord {
    return Coord(x: left.x + right.x, y: left.y + right.y)
}

class Cell {
    
    enum Direction {
        case North, South, East, West
    }
    
    static let northCoord: Coord = (0, 1)
    static let southCoord: Coord = (0, -1)
    static let eastCoord: Coord = (-1, 0)
    static let westCoord: Coord = (1, 0)
    var directions: [Direction] = [.North, .South, .East, .West]
    
    let coord: Coord
    var visited: Bool = false
    var parent: Cell?
    var distance = 0
    
    init(coord: Coord) {
        self.coord = coord
    }
    
    func visitFromCell(_ parent: Cell) {
        visited = true
        distance = parent.distance + 1
        self.parent = parent
    }
    
    /**
     * Rotates around the cell in a randomized order attempting
     * to 'discover' new cells to add to the layout.
     *
     * - Parameters:
     *    - existingCells: List of `Cell`s that have been previously discovered.
     *
     * - Returns: The `Cell`s that were discovered when exploring around this `Cell`.
     */
    func explore(_ existingCells: [Cell]) -> [Cell] {
        shuffleDirections()
        
        var foundCells = [Cell]()
        
        for direction in directions {
            let newCoord = coordInDirection(direction, fromCoord: coord)
            let shouldExplore = arc4random_uniform(2) == 0 // RNG so we don't always check each direction
            if shouldExplore && !cellExistsAtCoord(newCoord, existingCells: existingCells) {
                // If we decided to explore and there is not a cell already here,
                // connect to the new cell & add it to the cells we've discovered.
                let foundCell = Cell(coord: newCoord)
                foundCell.visitFromCell(self)
                foundCells.append(foundCell)
            }
        }
        
        return foundCells
    }
    
    private func coordInDirection(_ direction: Direction, fromCoord coord: Coord) -> Coord {
        switch direction {
        case .North:
            return coord + Cell.northCoord
            
        case .South:
            return coord + Cell.southCoord
            
        case .East:
            return coord + Cell.eastCoord
            
        case .West:
            return coord + Cell.westCoord
        }
    }
    
    private func cellExistsAtCoord(_ coord: Coord, existingCells: [Cell]) -> Bool {
        let index = existingCells.index {
            $0.coord == coord
        }
        
        return index != nil
    }
    
    private func shuffleDirections() {
        let count = directions.count
        for i in 0 ..< count - 2 {
            // i <= index < count is the desired result
            let index = arc4random_uniform(UInt32(count - i)) + UInt32(i)
            
            let temp = directions[i]
            directions[i] = directions[Int(index)]
            directions[Int(index)] = temp
        }
    }
}

