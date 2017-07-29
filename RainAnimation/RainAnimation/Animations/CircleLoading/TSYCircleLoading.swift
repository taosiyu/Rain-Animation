//
//  TSYCircleLoading.swift
//  TSYCirclePercentageVIew
//
//  Created by ncm on 2016/12/28.
//  Copyright © 2016年 ncm. All rights reserved.
//

import UIKit

//MARK:******* 圆开始角度 *******
let TCircleStartAngle   = CGFloat.init(-M_PI - M_PI_2)
let TCircleEndAngle     = CGFloat.init(M_PI_2)

protocol myprocel {
    
}

class TSYCircleLoading: UIView {
    
    let circle = CAShapeLayer.init()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupVC()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupVC() {
        self.circle.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height)
        let path = UIBezierPath.init(ovalIn: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height)).cgPath
        self.circle.path               = path
        self.circle.position           = CGPoint(x:frame.width/2,y:frame.height/2)
        self.circle.fillColor          = UIColor.white.cgColor
        self.circle.strokeColor        = UIColor.red.cgColor
        self.circle.lineCap            = kCALineCapRound
        self.circle.lineWidth          = 2
        self.circle.shouldRasterize    = true
        self.circle.rasterizationScale = 2 * UIScreen.main.scale
        layer.addSublayer(circle)
        
        startAnimation()
        
    }
    
    func startAnimation() {
       
        self.circle.removeAllAnimations()
        let drawAnimation      = CABasicAnimation.init(keyPath: "strokeEnd")
//        drawAnimation.duration =  2.0
        drawAnimation.repeatCount = 1
        drawAnimation.fromValue = 0
        drawAnimation.toValue = 1
        drawAnimation.timingFunction = CAMediaTimingFunction.init(name: kCAMediaTimingFunctionEaseInEaseOut)
//        self.circle.add(drawAnimation, forKey: "draw1")

        let drawAnimation2      = CABasicAnimation.init(keyPath: "strokeStart")
//        drawAnimation2.duration =  1.0
        drawAnimation2.repeatCount = 1
        drawAnimation2.fromValue = -1
        drawAnimation2.toValue = 1
        drawAnimation2.timingFunction = CAMediaTimingFunction.init(name: kCAMediaTimingFunctionEaseOut)
//        self.circle.add(drawAnimation2, forKey: "draw2")
        
        
        let drawRotation = CABasicAnimation.init(keyPath: "transform.rotation.z")
        drawRotation.fromValue = 0-M_PI_4+(M_PI_4)*0.2
        drawRotation.repeatCount = 1
        drawRotation.toValue = M_PI_4-M_2_PI-M_PI_4
        drawRotation.timingFunction = CAMediaTimingFunction.init(name: kCAMediaTimingFunctionEaseInEaseOut)
//        drawRotation.duration = 1
        
//        let keyAni = CAKeyframeAnimation.init(keyPath: "path")
//        keyAni.autoreverses = true
//        keyAni.duration = 2.0
//        keyAni.repeatCount = HUGE
//        keyAni.keyTimes = [0.5,1]
//        keyAni.values = [0,1]
//        self.circle.add(keyAni, forKey: "key")
        
        
        let group = CAAnimationGroup()
        group.duration = 1.5
        group.repeatCount = 9999
        group.animations = [drawAnimation2,drawAnimation,drawRotation]
        group.isRemovedOnCompletion = false
        group.fillMode = kCAFillModeForwards
        self.circle.add(group, forKey: "group")
        
        

        
        
//        let colorsAnimation = CAKeyframeAnimation.init(keyPath: "strokeColor")
//        colorsAnimation.values = nil
//        colorsAnimation.calculationMode = kCAAnimationCubicPaced
//        colorsAnimation.fillMode = kCAFillModeForwards
//        colorsAnimation.isRemovedOnCompletion = false
//        colorsAnimation.duration = 1.0
//        self.circle.add(colorsAnimation, forKey: "strokeColor")
        
    }

}
