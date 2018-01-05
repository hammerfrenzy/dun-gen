//
//  AppDelegate.swift
//  dun-gen
//
//  Created by Wyatt Beavers on 7/28/16.
//  Copyright (c) 2016 HCSS. All rights reserved.
//


import Cocoa
import SpriteKit

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    @IBOutlet weak var window: NSWindow!
    @IBOutlet weak var skView: SKView!
    func applicationDidFinishLaunching(_ notification: Notification) {
        /* Pick a size for the scene */
        if let scene = GameScene(fileNamed: "GameScene") {
            /* Set the scale mode to scale to fit the window */
            scene.scaleMode = .aspectFill
            
            self.skView!.presentScene(scene)
            
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            self.skView!.ignoresSiblingOrder = true
            
            self.skView!.showsFPS = true
            self.skView!.showsNodeCount = true
        }
    }
}
