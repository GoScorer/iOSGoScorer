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
    class Color{
        public var description: String { return "[R:\(Red) G:\(Green) B:\(Blue)]" }
        var Red: Float = 0
        var Green: Float = 0
        var Blue: Float = 0
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        photo.image=tempimage
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
