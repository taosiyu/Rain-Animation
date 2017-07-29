//
//  3DBlockView.swift
//  RainAnimation
//
//  Created by apple on 2017/7/28.
//  Copyright © 2017年 apple. All rights reserved.
//

import UIKit

class _DBlockView: UIView {
    
    fileprivate var blocks:[UIView] = [UIView]()
    
    fileprivate var blockWidth:CGFloat = 0

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(frameWidth:CGFloat) {
        self.init(frame: CGRect())
        self.addViews(width: frameWidth)
        self.blockWidth = frameWidth/2.0
    }
    
    
    private func addViews(width:CGFloat){
        for i in 0...5 {
            let vc = UIView.init(frame: CGRect(x: 0, y: 0, width: width, height: width))
            vc.layer.isDoubleSided = false
            self.blocks.append(vc)
            vc.backgroundColor = UIColor.white
            let label = UILabel.init()
            label.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
            label.text = "\(i+1)"
            label.center = CGPoint(x: width/2.0, y: width/2.0)
            vc.addSubview(label)
        }
    
    }
    
    func show(){
        self.addAllBlocks()
    }
    
    private var beginPoint:CGPoint?
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            if touch.tapCount == 2{
                return
            }
            self.beginPoint = touch.location(in: self)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let beginP = self.beginPoint {
            for touch in touches {
                let endP = touch.location(in: self)
                let x = beginP.x - endP.x
                let y = beginP.y - endP.y
                self.changeTranforms3d(x: x, y: y)
                print("x = \(x),,,y = \(y)")
                self.beginPoint = endP
                
            }
        }
    }
    
    private func changeTranforms3d(x:CGFloat,y:CGFloat){
        var perspective = self.layer.sublayerTransform
        
        if abs(Int32(x)) >= 1{
            //左右移动
            perspective = CATransform3DRotate(perspective, -CGFloat(Double.pi/45)*x, 0, 1, 0)
        }
        
        if abs(Int32(y)) >= 1{
            //上下移动
            perspective = CATransform3DRotate(perspective, CGFloat(Double.pi/45)*y, 1, 0, 0)
            
        }
        
        
        
        self.layer.sublayerTransform = perspective
    }
    
}


extension _DBlockView{
    
    //主要的代码
    fileprivate func addAllBlocks(){
        //这里是为了设置相机视野镜头方法，这样设置可以使3d变幻能够有纵深感
        var perspective = CATransform3DIdentity
        perspective.m34 = -1.0/500.0
        self.layer.sublayerTransform = perspective
        
        //1
        var transform = CATransform3DMakeTranslation(0, 0, self.blockWidth)
        self.addBlock(index: 0, transform3d: transform)
        
        //2
        transform = CATransform3DMakeTranslation(self.blockWidth, 0, 0)
        transform = CATransform3DRotate(transform, CGFloat(Double.pi/2), 0, 1, 0)
        self.addBlock(index: 1, transform3d: transform)
        
        //3
        transform = CATransform3DMakeTranslation(0, -self.blockWidth, 0)
        transform = CATransform3DRotate(transform, CGFloat(Double.pi/2), 1, 0, 0)
        self.addBlock(index: 2, transform3d: transform)
        
        //4
        transform = CATransform3DMakeTranslation(0, self.blockWidth, 0)
        transform = CATransform3DRotate(transform, -CGFloat(Double.pi/2), 1, 0, 0)
        self.addBlock(index: 3, transform3d: transform)
        
        //5
        transform = CATransform3DMakeTranslation(-self.blockWidth, 0, 0)
        transform = CATransform3DRotate(transform, -CGFloat(Double.pi/2), 0, 1, 0)
        self.addBlock(index: 4, transform3d: transform)
        
        //6
        transform = CATransform3DMakeTranslation(0, 0, -self.blockWidth)
        transform = CATransform3DRotate(transform, CGFloat(Double.pi), 0, 1, 0)
        self.addBlock(index: 5, transform3d: transform)
        
    
    }
    
    fileprivate func addBlock(index:NSInteger,transform3d:CATransform3D){
        
        let block = self.blocks[index]
        
        self.addSubview(block)
        
        let containerSize = self.bounds.size
        
        block.center = CGPoint(x: containerSize.width/2.0, y: containerSize.height/2.0)

        block.layer.transform = transform3d
        
    }
    
}
