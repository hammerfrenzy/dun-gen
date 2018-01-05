//
//  Stack.swift
//  dun-gen
//
//  Created by Wyatt Beavers on 7/29/16.
//  Copyright © 2016 HCSS. All rights reserved.
//

import Foundation

final class Stack<T> {
    private var stack: [T] = [T]()
    
    func push(_ newElement: T) {
        stack.append(newElement)
    }
    
    func pop() -> T? {
        guard let _ = stack.first else {
            return nil
        }
        
        return stack.removeFirst()
    }
    
    func hasNext() -> Bool {
        return stack.first != nil
    }
}

