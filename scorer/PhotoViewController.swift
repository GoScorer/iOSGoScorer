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
   
    var intersectionPoints = [[CGPoint]]()
    var colorPoints = [[Color]]()
    var gameArray = [[Int]]()
    
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
    @IBAction func computer(_ sender: Any) {
        for view in self.view.subviews {
            if (view.tag == 75){
                view.removeFromSuperview()
            }
        }
        intersectionPoints = getArrayofPoints(topLeft: tlPoint.center, topRight: trPoint.center, bottomLeft: blPoint.center, bottomRight: brPoint.center)
        
        getColorPoints()
        getGameArray()
        
        for i in 0...18{
            for j in 0...18{
                let dot = #imageLiteral(resourceName: "Image")
                let dotImageView = UIImageView(image: dot)
                let point = intersectionPoints[i][j]
                dotImageView.frame = CGRect(x: point.x - 5, y: point.y - 5, width: 10, height: 10)
                dotImageView.tag = 75
                view.addSubview(dotImageView)
            }
        }
        
    }
    
    /*func getGameArray(){
        var variance = 20
        var typesOfPoints = [[Color]]()
        
        for column in colorPoints {
            for color in column {
                if (typesOfPoints.isEmpty){
                    print("FIRST")
                    var newArr: [Color] = [color]
                    typesOfPoints.append(newArr)
                }
                else {
                    var isInRange = false
                    for i in 0...typesOfPoints.count-1 {
                        if(isColorInRange(color1: color, color2: typesOfPoints[i][0], variance: variance)){
                            typesOfPoints[i].append(color)
                            isInRange = true
                            break
                        }
                    }
                    if(!isInRange){
                        var newArr: [Color] = [color]
                        typesOfPoints.append(newArr)
                    }
                }
            }
        }
        for column in typesOfPoints {
            print("TYPE START \n")
            for color in column {
                print ("Red: \(color.Red) Green: \(color.Green) Blue: \(color.Blue)")
            }
        }
    }*/
    
    
    
    //returns 19 x 19 array of 0, 1, 2 ; 0 - no piece, 1 - black piece, 2 - white piece
    func getGameArray(){
        //var variance = 20
        var gameArray = [[Int]]()
        
        for i in 0...18{
            gameArray.append([Int]())
            for _ in 0...18{
                gameArray[i].append(Int())
            }
        }
        
        for j in 0...18 {
            for k in 0...18 {
                var color = colorPoints[j][k]
                if(isColorWhiteOrBlack(color: color)){
                    if(color.Red < 125){
                        gameArray[j][k] = 1
                    }
                    else{
                        gameArray[j][k] = 2
                    }
                }
                else{
                    gameArray[j][k] = 0
                }
            }
        }
        /*for column in typesOfPoints {
            print("TYPE START \n")
            for color in column {
                print ("Red: \(color.Red) Green: \(color.Green) Blue: \(color.Blue)")
                //print(isColorWhiteOrBlack(color: color))
            }
        }*/
        print(gameArray)
    }
    
    
    func getTypesOfPieces(){
        //var variance = 20
        var typesOfPoints: [[Color]] = [[], [], []]
        
        for column in colorPoints {
            for color in column {
                if(isColorWhiteOrBlack(color: color)){
                    if(color.Red < 125){
                        typesOfPoints[1].append(color)
                    }
                    else{
                        typesOfPoints[2].append(color)
                    }
                }
                else{
                    typesOfPoints[0].append(color)
                }
            }
        }
        for column in typesOfPoints {
            print("TYPE START \n")
            for color in column {
                print ("Red: \(color.Red) Green: \(color.Green) Blue: \(color.Blue)")
                //print(isColorWhiteOrBlack(color: color))
            }
        }
    }
    
    func isColorWhiteOrBlack(color: Color) -> Bool {
        let tolerance = 10
        if(Int(color.Red) < min(Int(color.Green) + tolerance, 255) && Int(color.Red) > max(Int(color.Green) - tolerance, 0)){
            if(Int(color.Red) < min(Int(color.Blue) + tolerance, 255) && Int(color.Red) > max(Int(color.Blue) - tolerance, 0)){
                if(Int(color.Blue) < min(Int(color.Green) + tolerance, 255) && Int(color.Blue) > max(Int(color.Green) - tolerance, 0)){
                    return true
                }
            }
        }
        return false
    }
    
    func isColorInRange(color1: Color, color2: Color, variance: Int) -> Bool{
        if (!(Int(color1.Red) < min(Int(color2.Red) + variance, 255) && Int(color1.Red) > max(Int(color2.Red) - variance, 0))){
            return false
        }
        if (!(Int(color1.Green) < min(Int(color2.Green) + variance, 255) && Int(color1.Green) > max(Int(color2.Green) - variance, 0))){
            return false
        }
        if (!(Int(color1.Blue) < min(Int(color2.Blue) + variance, 255) && Int(color1.Blue) > max(Int(color2.Blue) - variance, 0))){
            return false
        }
        return true
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
        
        for i in 0...18{
            intersections.append([CGPoint]())
            for _ in 0...18{
                intersections[i].append(CGPoint())
            }
        }
        
        let xLeftOffset = (topLeft.x - bottomLeft.x)/18
        let yLeftOffset = (abs(topLeft.y - bottomLeft.y))/18
        let xRightOffset = (topRight.x - bottomRight.x)/18
        let yRightOffset = (abs(topRight.y - bottomRight.y))/18
        
        for i in 0...18 {
            intersections[i][0] = CGPoint(x: topLeft.x - xLeftOffset*CGFloat(i), y: topLeft.y + yLeftOffset*CGFloat(i))
        }
        for j in 0...18 {
            intersections[j][18] = CGPoint(x: topRight.x - xRightOffset*CGFloat(j), y: topRight.y + yRightOffset*CGFloat(j))
        }
        for k in 0...18 {
            let leftPoint = intersections[k][0]
            let rightPoint = intersections[k][18]
            let xAcrossOffset = (rightPoint.x - leftPoint.x)/18
            let yAcrossOffset = (rightPoint.y - leftPoint.y)/18
            for a in 1...17 {
                intersections[k][a] = CGPoint(x: leftPoint.x + xAcrossOffset*CGFloat(a), y: leftPoint.y + yAcrossOffset*CGFloat(a))
            }
        }
        return intersections
    }
    
    func getColorPoints(){
        let dim = 18
        let searchRadius = 3;
        
        for i in 0...dim{
            colorPoints.append([Color]())
            for _ in 0...dim{
                colorPoints[i].append(Color())
            }
        }
        
        // insert code to get x and y of angle placers
        for i in 0...dim{
            for j in 0...dim{
                var colorPoint = [Color]()
                var a = intersectionPoints[i]
                let xCoord = Int(a[j].x)
                let yCoord = Int(a[j].y)
                colorPoint.append(getColor(x:xCoord+searchRadius, y: yCoord+searchRadius))
                colorPoint.append(getColor(x:xCoord+searchRadius, y: yCoord-searchRadius))
                colorPoint.append(getColor(x:xCoord-searchRadius, y: yCoord+searchRadius))
                colorPoint.append(getColor(x:xCoord-searchRadius, y: yCoord-searchRadius))
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
