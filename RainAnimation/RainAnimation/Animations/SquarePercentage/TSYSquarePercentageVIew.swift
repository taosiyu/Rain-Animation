//
//  TSYSquarePercentageVIew.swift
//  TSYCirclePercentageVIew
//
//  Created by ncm on 2016/12/19.
//  Copyright © 2016年 ncm. All rights reserved.
//

import UIKit

enum BarChartStyle {
    case BarChartStyle1 // 带有 底部 label
    case BarChartStyle2 // 带有 中间 top label 底部label
    
    func cornerRadius() -> CGFloat{
        if self == .BarChartStyle1 {
            return 2
        }else{
            return 4
        }
    }
    
    func backgroundImage() -> UIImage {
        if self == .BarChartStyle1{
            return UIImage.init(named: "yongjin_Graph")!
        }else{
             return UIImage.init(named: "yongjin_Graph")!
        }
    }
    
    func backgroundHeight() -> CGFloat {
        if self == .BarChartStyle1 {
            return 220
        }else{
            return 165
        }
    }
    
}


class TSYSquarePercentageVIew: UIView {
    
    let bgImageView = UIImageView.init(frame:  CGRect(x: 0, y: 0, width: 0, height: 0))
    let topImageView = UIImageView.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    
    let topLabel: UILabel = {
        let topLabel = UILabel()
        topLabel.textAlignment = .center
        topLabel.font = UIFont.systemFont(ofSize: 10)
        topLabel.textColor = UIColor.gray
        return topLabel
    }()
    
    let centerLabel: UILabel = {
        let centerLabel = UILabel()
        centerLabel.textAlignment = .center
        centerLabel.font = UIFont.systemFont(ofSize: 10)
        centerLabel.textColor = UIColor.gray
        return centerLabel
    }()
    
    let bottomLabel: UILabel = {
        let bottomLabel = UILabel()
        bottomLabel.textAlignment = .center
        bottomLabel.font = UIFont.systemFont(ofSize: 11)
        bottomLabel.textColor = UIColor.gray
        bottomLabel.numberOfLines = 0
        return bottomLabel
    }()
    
    var style: BarChartStyle = .BarChartStyle1
    var selfWidth: CGFloat = 0
    
    convenience init(frame: CGRect,style: BarChartStyle,width: CGFloat) {
        self.init(frame: frame)
        self.style = style
        self.bgImageView.image = self.style.backgroundImage()
        self.bgImageView.layer.masksToBounds = true
        self.bgImageView.layer.cornerRadius = self.style.cornerRadius()
        self.topImageView.layer.masksToBounds = true
        self.topImageView.layer.cornerRadius = self.style.cornerRadius()
        self.selfWidth = width
        self.setupSubviews()
    }
    
    func setupSubviews() -> Void {
        
        self.addSubview(self.bgImageView)
        self.addSubview(self.topImageView)
        self.addSubview(self.topLabel)
        self.addSubview(self.centerLabel)
        self.addSubview(self.bottomLabel)
        

        self.bgImageView.frame = CGRect(x: 0, y: 20, width: bounds.size.width, height: bounds.size.height-55)
        
        self.topImageView.frame = CGRect(x: 0, y: bounds.size.height-35, width: bounds.size.width, height: 0)
        
        self.topLabel.frame = CGRect(x: 0, y: 0, width: bounds.size.width, height: 20)
        
        
        self.centerLabel.frame = CGRect(x: 0, y: bounds.size.height-35, width: bounds.size.width, height: 0)
        
        self.bottomLabel.frame = CGRect(x: 0, y: bounds.size.height-30, width: bounds.size.width, height: 30)
    }
    
    
    /// 显示数据
    ///
    /// - Parameters:
    ///   - topString: 柱状图顶部的title
    ///   - centerString: 中间动画时候的title
    ///   - bottomString: 底部的title
    ///   - percent: 数量
    ///   - topColor: 顶部字体的颜色
    func showWithData(topString: String,centerString: String,bottomString: String,percent: Int64,topColor: UIColor) -> Void {
        
        self.topLabel.text = topString
        self.bottomLabel.text = bottomString
        self.centerLabel.text = centerString
        self.topImageView.image = imageWithColor(color: topColor)
        
        var p = percent
        if percent>=100 {
            p = 100
            self.topLabel.isHidden = true
        }
        
        self.showPercentWithPercent(percent: p)
    }
    
    
    /// 数据动画
    ///
    /// - Parameter percent: 数据
    func showPercentWithPercent(percent: Int64) -> Void {
        
        var tempPercent = percent
        if tempPercent == 0 {
            tempPercent = 2
        }
        
        let h = CGFloat(((bounds.size.height-55)/100.0)*CGFloat(tempPercent))
        
        let sh = bounds.size.height
        
        UIView.animate(withDuration: 2.0, animations: {[weak self] (_) in
            self?.topImageView.frame = CGRect(x: 0, y: sh-35-h, width: self?.bounds.size.width ?? 0, height: h)
            self?.topLabel.frame = CGRect(x: 0, y: 0, width: self?.bounds.size.width ?? 0, height: 20)
            self?.centerLabel.frame = CGRect(x: 0, y: (self?.topImageView.frame.origin.y ?? 0)-20, width:self?.bounds.size.width ?? 0, height: 20)
            
        }) { (flag) in
            if h >= sh{
               self.centerLabel.isHidden = true
            }
            self.topLabel.isHidden = false
        }
        
    }
    

}

extension TSYSquarePercentageVIew{
   
    func imageWithColor(color: UIColor) -> UIImage {
        let rect = CGRect(x:0,y:0,width:1, height:1);
        UIGraphicsBeginImageContext(rect.size);
        let context = UIGraphicsGetCurrentContext();
        
        context!.setFillColor(color.cgColor);
        context!.fill(rect);
        
        let image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return image!;
    }
    
}


