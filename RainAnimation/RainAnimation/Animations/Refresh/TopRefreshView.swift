//
//  TopRefreshView.swift
//  RainAnimation
//
//  Created by apple on 2017/7/28.
//  Copyright © 2017年 apple. All rights reserved.
//

import UIKit

class TopRefreshView: UIView {
    
    let gradientLayer: CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
        
        //配置gradientLayer
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        let colors = [UIColor.purple.cgColor , UIColor.green.cgColor , UIColor.black.cgColor,UIColor.red.cgColor,UIColor.yellow.cgColor]
        gradientLayer.colors = colors
        
        let locations = [
            0.25,
            0.5,
            0.75
        ]
        gradientLayer.locations = locations as [NSNumber]
        
        return gradientLayer
    }()
    
    let textAttr:[String:AnyObject]? = {
        let style = NSMutableParagraphStyle()
        style.alignment = .center
        return [
            NSFontAttributeName:UIFont(name: "HelveticaNeue-Thin",
                                       size: 25.0)!,
            NSParagraphStyleAttributeName: style
        ]
    }()
    
    var text: String! {
        didSet {
            setNeedsDisplay()
            UIGraphicsBeginImageContextWithOptions(frame.size, false, 0)
            text.draw(in: bounds, withAttributes: textAttr)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            let maskLayer = CALayer()
            maskLayer.backgroundColor = UIColor.clear.cgColor
            maskLayer.frame = bounds.offsetBy(dx: bounds.size.width, dy: 0)
            maskLayer.contents = image?.cgImage
            gradientLayer.mask = maskLayer
        }
    }

    convenience init() {
        self.init(frame: CGRect())
        layer.addSublayer(gradientLayer)
    }
    
    override func layoutSubviews() {
        gradientLayer.frame = CGRect(
            x: -bounds.size.width,
            y: bounds.origin.y,
            width: 3 * bounds.size.width,
            height: bounds.size.height)
    }
    
    func begin(){
        //添加动画
        let gradientAnimate = CABasicAnimation(keyPath: "locations")
        gradientAnimate.fromValue = [0.2, 0.3,0.4,0.5,0.6]
        gradientAnimate.toValue = [0.5, 0.6, 0.7,0.8,0.9,1.0]
        gradientAnimate.duration = 3.0
        gradientAnimate.repeatCount = Float.infinity
        
        gradientLayer.add(gradientAnimate, forKey: nil)
    }
    
    func end(){
        gradientLayer.removeAllAnimations()
    }
    
}

extension TopRefreshView:RefreshDelegate{
    func doScroll(_ scroll: CGFloat) {
        print("scroll=\(scroll)")
    }
    
    func WillRefresh(){
        text = "哈哈哈哈，正在刷新哦！"
        begin()
    }
    
    func doNormal() {
         text = "下啦刷新哦！"
        end()
        print("doNormal")
    }
    
    func doPull() {
        text = "松手就刷新"
        print("doPull")
    }
}
