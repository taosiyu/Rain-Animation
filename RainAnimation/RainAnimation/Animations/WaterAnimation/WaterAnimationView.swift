//
//  WaterAnimationView.swift
//  RainAnimation
//
//  Created by apple on 2017/7/28.
//  Copyright © 2017年 apple. All rights reserved.
//

import UIKit

private let duration = 8    //时间

class WaterAnimationView: UIView {
    
    fileprivate var waterLayer:CAShapeLayer?
    
    fileprivate var sinLayer:CAShapeLayer?
    
    fileprivate var cosLayer:CAShapeLayer?
    
    fileprivate var displayLink:CADisplayLink?
    
    fileprivate var phase:CGFloat = 0
    
    convenience init(pre:NSInteger){
        self.init(frame: CGRect())
        setupSubViews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func start(){
        self.displayLink?.invalidate()
        
        self.displayLink = CADisplayLink(target: self, selector: #selector(update(displayLink:)))
        self.displayLink?.add(to: RunLoop.current, forMode: RunLoopMode.commonModes)
        //上升动画
        if let p = self.sinLayer?.position {
            var position = p
            position.y = position.y + self.bounds.size.height + 10
            let animation = CABasicAnimation(keyPath: "position")
            animation.fromValue = NSValue(cgPoint: position)
            animation.toValue = NSValue(cgPoint: p)
            animation.duration = CFTimeInterval(duration)
            animation.repeatCount = MAXFLOAT
            animation.isRemovedOnCompletion = false
            self.sinLayer?.add(animation, forKey: "positionWave")
        }
        
    }
    
    deinit {
        self.stop()
    }
    
    func stop(){
        self.displayLink?.invalidate()
        self.sinLayer?.removeAllAnimations()
        self.sinLayer?.path = nil
    }
    
    private func setupSubViews(){
        self.layer.masksToBounds = true
        self.layer.borderColor = UIColor.blue.cgColor
        self.layer.borderWidth = 3
        
        self.sinLayer = CAShapeLayer.init()
        self.sinLayer?.backgroundColor = UIColor.clear.cgColor
        self.sinLayer?.fillColor = UIColor.green.cgColor
        self.sinLayer?.frame = self.bounds
        self.layer.addSublayer(self.sinLayer!)
        
        self.cosLayer = CAShapeLayer.init()
        self.cosLayer?.backgroundColor = UIColor.clear.cgColor
        self.cosLayer?.fillColor = UIColor.green.cgColor
        self.cosLayer?.frame = self.bounds
        self.layer.addSublayer(self.cosLayer!)
        
    }
    
    func update(displayLink:CADisplayLink){
        self.phase += 1
        self.sinLayer?.path = self.createWavePathWithType().cgPath
        self.sinLayer?.fillColor = UIColor.black.cgColor
        self.sinLayer?.opacity = 0.7
        
//        self.cosLayer?.path = self.createWavePathWithTypeCos().cgPath
//        self.cosLayer?.fillColor = UIColor.black.cgColor
//        self.cosLayer?.opacity = 0.5
    }
    
    func createWavePathWithType()->UIBezierPath{
        let path = UIBezierPath.init()
        let startOffY = CGFloat(5.0 * sinf(Float(self.phase * CGFloat(Double.pi) * 2.0 / self.bounds.width)))
        var orignOffY:CGFloat = 0
        let w = self.bounds.width
        var x:CGFloat = 0
        path.move(to: CGPoint(x: 0, y: CGFloat(startOffY)))
        while x <= w+1 {
            orignOffY = CGFloat(5.0 * sinf(Float(2 * CGFloat(Double.pi) / self.bounds.width * x + self.phase * CGFloat(Double.pi) * 2 / self.bounds.width)))
            path.addLine(to: CGPoint(x: x, y: CGFloat(orignOffY)))
            x+=1
        }
        
        path.addLine(to: CGPoint(x: self.bounds.width, y: CGFloat(orignOffY)))
        path.addLine(to: CGPoint(x: self.bounds.width, y: self.bounds.height))
        path.addLine(to: CGPoint(x: 0, y: self.bounds.height))
        path.addLine(to: CGPoint(x: 0, y: CGFloat(startOffY)))
        path.close()
        
        return path
    }
    
    func createWavePathWithTypeCos()->UIBezierPath{
        let path = UIBezierPath.init()
        let startOffY = CGFloat(5.0 * sinf(Float(self.phase * CGFloat(Double.pi) * 2.0 / self.bounds.width)))
        var orignOffY:CGFloat = 0
        let w = self.bounds.width
        var x:CGFloat = 0
        path.move(to: CGPoint(x: 0, y: CGFloat(startOffY)))
        while x <= w+1 {
            orignOffY = CGFloat(5.0 * cosf(Float(2 * CGFloat(Double.pi) / self.bounds.width * x + self.phase * CGFloat(Double.pi) * 2 / self.bounds.width))) + self.bounds.height * 0.5
            path.addLine(to: CGPoint(x: x, y: CGFloat(orignOffY)))
            x+=1
        }
        
        path.addLine(to: CGPoint(x: self.bounds.width, y: CGFloat(orignOffY)))
        path.addLine(to: CGPoint(x: self.bounds.width, y: self.bounds.height))
        path.addLine(to: CGPoint(x: 0, y: self.bounds.height))
        path.addLine(to: CGPoint(x: 0, y: CGFloat(startOffY)))
        path.close()
        
        return path
    }

}
