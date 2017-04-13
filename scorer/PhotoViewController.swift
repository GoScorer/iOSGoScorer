//
//  PhotoViewController.swift
//  scorer
//
//  Created by David Yuan on 3/30/17.
//  Copyright © 2017 David Yuan. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController {
    
    @IBOutlet weak var photo: UIImageView!
    var tempimage: UIImage?
    var topLeft: CGPoint = CGPoint(x: 0, y: 0)
    var topRight: CGPoint = CGPoint(x: 375, y: 0)
    var bottomLeft: CGPoint = CGPoint(x: 0, y: 375)
    var bottomRight: CGPoint = CGPoint(x: 375, y: 375)
    var intersectionPoints = [[CGPoint]]()
    var colorPoints = [[Color]]()
    
    var tloc: CGPoint!
    var troc: CGPoint!
    var bloc: CGPoint!
    var broc: CGPoint!
    @IBOutlet weak var tlPoint: UIImageView!
    @IBOutlet weak var trPoint: UIImageView!
    @IBOutlet weak var blPoint: UIImageView!
    @IBOutlet weak var brPoint: UIImageView!
    
    class Color{
        public var description: String { return "[R:\(Red) G:\(Green) B:\(Blue)]" }
        var Red: Float = 0
        var Green: Float = 0
        var Blue: Float = 0
    }
    
    @IBAction func didPanTopLeft(_ sender: UIPanGestureRecognizer) {
        
        let translation = sender.translation(in: view)
        if sender.state == .began{
            tloc = tlPoint.center
            
        }
        else if(sender.state == .changed){
            tlPoint.center = CGPoint(x: tloc.x + translation.x,y: tloc.y + translation.y)
            
        }
        else if(sender.state == .ended){
                    }
    }
    
  
    @IBAction func bottomRightDidPan(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        if sender.state == .began{
            broc = brPoint.center
            
        }
        else if(sender.state == .changed){
            brPoint.center = CGPoint(x: broc.x + translation.x,y: broc.y + translation.y)
            
        }
        else if(sender.state == .ended){
        }

        
    }
    @IBAction func didPanBottomLeft(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        if sender.state == .began{
            bloc = blPoint.center
            
        }
        else if(sender.state == .changed){
            blPoint.center = CGPoint(x: bloc.x + translation.x,y: bloc.y + translation.y)
            
        }
        else if(sender.state == .ended){
        }
    }
    
    @IBAction func didPanTopRight(_ sender: UIPanGestureRecognizer) {
        
        let translation = sender.translation(in: view)
        if sender.state == .began{
            troc = trPoint.center
            
        }
        else if(sender.state == .changed){
            trPoint.center = CGPoint(x: troc.x + translation.x,y: troc.y + translation.y)
            
        }
        else if(sender.state == .ended){
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        photo.image=tempimage
        // intersectionPoints = getArrayofPoints(topLeft: topLeft, topRight: topRight, bottomLeft: bottomLeft, bottomRight: bottomRight)
        /* let lightBulb = UIImageView(frame: CGRect(x: 100, y: 100, width: 20, height: 20))
         
         lightBulb.image = UIImage(named: "lightBulb")
         lightBulb.contentMode = .scaleToFill
         lightBulb.isUserInteractionEnabled = true
         
         lightBulb.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: "handlePan"))
         
         self.view.addSubview(lightBulb)*/
        print(getColor(x: 100, y: 100).description)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func getColor(x: Int,y: Int) -> Color{
        var pixel : [UInt8] = [0, 0, 0, 0]
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
        let context = CGContext(data: UnsafeMutablePointer(mutating: pixel), width: 1, height: 1, bitsPerComponent: 8, bytesPerRow: 4, space: colorSpace, bitmapInfo: bitmapInfo.rawValue)
        
        // Translate the context your required point(x,y)
        context!.translateBy(x: -(CGFloat)(x), y: -(CGFloat)(y));
        photo.layer.render(in: context!)
        
        NSLog("pixel: %d %d %d %d", pixel[0], pixel[1], pixel[2], pixel[3]);
        
        let redColor : Float = Float(pixel[0])
        let greenColor : Float = Float(pixel[1])
        let blueColor: Float = Float(pixel[2])
        let colorAlpha: Float = Float(pixel[3])
        
        // Create UIColor Object
        let color : Color! = Color()
        color.Red=redColor
        color.Green=greenColor
        color.Blue=blueColor
        return color
    }
    
    //returns a 20 x 20 2D Array of CGPoints, where each CGPoint is an intersection on the board
    func getArrayofPoints(topLeft: CGPoint, topRight: CGPoint, bottomLeft: CGPoint, bottomRight: CGPoint) -> [[CGPoint]]{
        var intersections = [[CGPoint]]()
        
        for i in 0...19{
            intersections.append([CGPoint]())
            for _ in 0...19{
                intersections[i].append(CGPoint())
            }
        }
        
        let xLeftOffset = (topLeft.x - bottomLeft.x)/19
        let yLeftOffset = (topLeft.y - bottomLeft.y)/19
        let xRightOffset = (topRight.x - bottomRight.x)/19
        let yRightOffset = (topRight.y - bottomRight.y)/19
        
        for i in 0...19 {
            intersections[i][0] = CGPoint(x: topLeft.x + xLeftOffset*CGFloat(i), y: topLeft.y + yLeftOffset*CGFloat(i))
        }
        for j in 0...19 {
            intersections[j][19] = CGPoint(x: topRight.x + xRightOffset*CGFloat(j), y: topRight.y + yRightOffset*CGFloat(j))
        }
        for k in 1...18 {
            let leftPoint = intersections[k][0]
            let rightPoint = intersections[k][19]
            let xAcrossOffset = (rightPoint.x - leftPoint.x)/19
            let yAcrossOffset = (rightPoint.y - leftPoint.y)/19
            for a in 1...18 {
                intersections[k][a] = CGPoint(x: leftPoint.x + xAcrossOffset*CGFloat(a), y: leftPoint.y + yAcrossOffset*CGFloat(a))
            }
        }
        return intersections
    }
    
    func getColorPoints(){
        let dim = 19
        let searchRadius = 5;
        // insert code to get x and y of angle placers
        for i in 0...dim{
            for j in 0...dim{
                var colorPoint = [Color]()
                var a = intersectionPoints[i]
                let xCoord = Int(a[j].x)
                let yCoord = Int(a[j].y)
                colorPoint[0] = getColor(x:xCoord+searchRadius, y: yCoord+searchRadius)
                colorPoint[1] = getColor(x:xCoord+searchRadius, y: yCoord-searchRadius)
                colorPoint[2] = getColor(x:xCoord-searchRadius, y: yCoord+searchRadius)
                colorPoint[3] = getColor(x:xCoord-searchRadius, y: yCoord-searchRadius)
                let color = Color()
                for k in 0...3{
                    color.Red += colorPoint[k].Red
                    color.Green += colorPoint[k].Green
                    color.Blue += colorPoint[k].Blue
                }
                color.Red /= 4
                color.Green /= 4
                color.Blue /= 4
                colorPoints[i][j] = color
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
