//
//  GeneratorProtocol.swift
//  dun-gen
//
//  Created by Wyatt Beavers on 7/28/16.
//  Copyright © 2016 HCSS. All rights reserved.
//

import Foundation

protocol GeneratorProtocol {
    
    func generateLayout(cellCount: Int) -> [Cell]
    
}