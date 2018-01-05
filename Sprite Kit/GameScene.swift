//
//  GameScene.swift
//  dun-gen
//
//  Created by Wyatt Beavers on 7/28/16.
//  Copyright (c) 2016 HCSS. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    override func keyDown(with event: NSEvent) {
        guard let chars = event.characters else {
            return
        }
        
        switch chars {
        case "n", "N":
            let generator = Generator()
            let dungeon = Dungeon(generator)
            drawDungeon(dungeon)
            
        case "b", "B":
            let selector = BreadthFirstCellSelector()
            let generator = InjectableGenerator(cellSelector: selector)
            let dungeon = Dungeon(generator)
            drawDungeon(dungeon)
            
        case "d", "D":
            let selector = DepthFirstCellSelector()
            let generator = InjectableGenerator(cellSelector: selector)
            let dungeon = Dungeon(generator)
            drawDungeon(dungeon)
            
        case "r", "R":
            let selector: CellSelectorProtocol = arc4random_uniform(2) == 0 ? BreadthFirstCellSelector() : DepthFirstCellSelector()
            let generator = InjectableGenerator(cellSelector: selector)
            let dungeon = Dungeon(generator)
            drawDungeon(dungeon)
            
        default: break
        }
    }
    
    func drawDungeon(_ dungeon: Dungeon) {
        wipeMaze()
        
        let cells = dungeon.generateDungeon()
    
        let size: CGFloat = 15
        let space: CGFloat = 5
        var delay: TimeInterval = 0
        
        let xOffset = ((self.scene?.size.width ?? 0) - size) / 2
        let yOffset = ((self.scene?.size.height ?? 0) - size) / 2
        
        for (i, cell) in cells.enumerated() {
            let x = CGFloat(cell.coord.x)
            let y = CGFloat(cell.coord.y)
            let finalX = CGFloat(x * size + x * space) + space + xOffset
            let finalY = CGFloat(y * size + y * space) + space + yOffset
            let rect = CGRect(x: finalX, y: finalY, width: size, height: size)
            
            let node = SKShapeNode(rect: rect)
            node.fillColor = NSColor(red: 0, green: 0, blue: 0, alpha: 0)
            
            let delayAction = SKAction.wait(forDuration: delay)
            let opacityAction = SKAction.customAction(withDuration: 0) { (node, _) in
                guard let node = node as? SKShapeNode else { return }
                
                let percent = CGFloat(i) / CGFloat(cells.count)
                let hsv = HSV(hue: percent, saturation: 0.5, brightness: 0.5, alpha: 1)
                let rgb = self.hsv2rgb(hsv)
                
                node.fillColor = NSColor(red: rgb.red, green: rgb.green, blue: rgb.blue, alpha: 1)
            }

            let actionList = SKAction.sequence([delayAction, opacityAction])
            
            self.scene?.addChild(node)
            node.run(actionList)
            
            delay += 0.025
        }
    }
    
    func wipeMaze() {
        self.scene?.removeAllChildren()
    }
    
    // Typealias for RGB color values
    typealias RGB = (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat)
    
    // Typealias for HSV color values
    typealias HSV = (hue: CGFloat, saturation: CGFloat, brightness: CGFloat, alpha: CGFloat)
    
    func hsv2rgb(_ hsv: HSV) -> RGB {
        // Converts HSV to a RGB color
        var rgb: RGB = (red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0)
        var r: CGFloat
        var g: CGFloat
        var b: CGFloat
        
        let i = Int(hsv.hue * 6)
        let f = hsv.hue * 6 - CGFloat(i)
        let p = hsv.brightness * (1 - hsv.saturation)
        let q = hsv.brightness * (1 - f * hsv.saturation)
        let t = hsv.brightness * (1 - (1 - f) * hsv.saturation)
        switch (i % 6) {
        case 0: r = hsv.brightness; g = t; b = p; break;
            
        case 1: r = q; g = hsv.brightness; b = p; break;
            
        case 2: r = p; g = hsv.brightness; b = t; break;
            
        case 3: r = p; g = q; b = hsv.brightness; break;
            
        case 4: r = t; g = p; b = hsv.brightness; break;
            
        case 5: r = hsv.brightness; g = p; b = q; break;
            
        default: r = hsv.brightness; g = t; b = p;
        }
        
        rgb.red = r
        rgb.green = g
        rgb.blue = b
        rgb.alpha = hsv.alpha
        return rgb
    }
}
