//
//  DrawView.swift
//  TouchTracker
//
//  Created by Wyatt Drummond on 11/28/16.
//  Copyright © 2016 Wyatt Drummond. All rights reserved.
//

import UIKit

class DrawView: UIView {
    var currentLine: Line?
    var finishedLines = [Line]()
    
    func strokeLine(line: Line) {
        let path = UIBezierPath()
        path.lineWidth = 10
        path.lineCapStyle = CGLineCap.Round
        
        path.moveToPoint(line.begin)
        path.addLineToPoint(line.end)
        path.stroke()
    }
    
    override func drawRect(rect: CGRect) {
//        let colorArray = [UIColor.blueColor(), UIColor.greenColor(), UIColor.yellowColor(), UIColor.purpleColor(), UIColor.orangeColor()]
//        let randomIndex = Int(arc4random_uniform(UInt32(colorArray.count)))
//        let color = colorArray[randomIndex]
//        color.setStroke()
        UIColor.whiteColor().setStroke()
        for line in finishedLines {
            strokeLine(line)
        }
        
        if let line = currentLine {
            let colorArray = [UIColor.blueColor(), UIColor.greenColor(), UIColor.yellowColor(), UIColor.purpleColor(), UIColor.orangeColor()]
            let randomIndex = Int(arc4random_uniform(UInt32(colorArray.count)))
            let color = colorArray[randomIndex]
            color.setStroke()
            //UIColor.redColor().setStroke()
            strokeLine(line)
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch = touches.first!
        
        let location = touch.locationInView(self)
        currentLine = Line(begin: location, end: location)
        
        setNeedsDisplay()
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch = touches.first!
        let location = touch.locationInView(self)
        
        currentLine?.end = location
        
        setNeedsDisplay()
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if var line = currentLine {
            let touch = touches.first!
            let location = touch.locationInView(self)
            line.end = location
            
            finishedLines.append(line)
        }
        currentLine = nil
        
        setNeedsDisplay()
    }
    
//    override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
//        currentLine.removeAll()
//        
//        setNeedsDisplay()
//    }
//    
//End of Class
}
