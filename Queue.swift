//
//  Queue.swift
//  dun-gen
//
//  Created by Wyatt Beavers on 7/26/16.
//  Copyright © 2016 HCSS. All rights reserved.
//

import Foundation

final class Queue<T> {
    private var queue: [T] = [T]()
    
    func enqueue(_ newElement: T) {
        queue.insert(newElement, at: 0)
    }
    
    func dequeue() -> T? {
        guard let _ = queue.first else {
            return nil
        }
        
        return queue.removeFirst()
    }
    
    func hasNext() -> Bool {
        return queue.first != nil
    }
}
