//
//  RainRefresher.swift
//  RainAnimation
//
//  Created by apple on 2017/7/28.
//  Copyright © 2017年 apple. All rights reserved.
//

import UIKit

protocol RefreshDelegate{
    func doPull()
    func doNormal()
    func WillRefresh()
    func doScroll(_ scroll:CGFloat)
}

/// 刷新状态
///
/// - Normal: 什么都不做
/// - Pulling: 超过零界点，如果放手刷新
/// - WillRefresh: 过零界点，手放开
enum TSYRefreshState{
    case Normal
    case Pulling
    case WillRefresh
}

class RainRefresher: UIControl {
    
    var refreshVcState:TSYRefreshState = TSYRefreshState.Normal
    ///刷新控件临界点
    fileprivate var TSYRefreshOffset:CGFloat = 80
    //MARK:父试图(tableview,collectionview)
    fileprivate weak var scrollView:UIScrollView?
    //刷新显示的视图
    fileprivate var refreshVc:RefreshDelegate?
    
    init(frame: CGRect,scrollView:UIScrollView,topView:RefreshDelegate) {
        super.init(frame: frame)
        self.scrollView = scrollView
        scrollView.delegate = self
        self.refreshVc = topView
        //设置约束
        setupUI()
    }
    
    convenience init(height: CGRect,scrollView:UIScrollView,topView:RefreshDelegate){
        self.init(frame: height, scrollView: scrollView, topView: topView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    ///开始刷新
    func startRefreshing() {
        
        //让试图停在当前位置
        guard let sv = scrollView else {
            return
        }
        
        if self.refreshVcState == .WillRefresh {
            return
        }
        
        self.refreshVcState = .WillRefresh
        
        UIView.animate(withDuration: 0.3, animations: {
            var it = sv.contentInset
            it.top += self.TSYRefreshOffset
            sv.contentInset = it
            self.frame = CGRect(x: 0, y: -self.TSYRefreshOffset, width: sv.bounds.width, height: self.TSYRefreshOffset)
        })
    
    }
    
    ///结束刷新
    func endRefreshing() {
        guard let sv = scrollView else {
            return
        }
        
        if self.refreshVcState != .WillRefresh {
            return
        }
        
        self.refreshVcState = .Normal
        
        UIView.animate(withDuration: 0.3, animations: {
            var it = sv.contentInset
            it.top -= self.TSYRefreshOffset
            sv.contentInset = it
        })
        
        
    }

}


extension RainRefresher:UIScrollViewDelegate{
    
    func setupUI() {
        
        backgroundColor = superview?.backgroundColor
        
        guard let refreshVc = self.refreshVc as? UIView else {
            return
        }

        addSubview(refreshVc)
        
        refreshVc.backgroundColor = backgroundColor
        
        refreshVc.translatesAutoresizingMaskIntoConstraints = false
        
        addConstraint(NSLayoutConstraint(item: refreshVc, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0))
        
        addConstraint(NSLayoutConstraint(item: refreshVc, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: 0))
        
        addConstraint(NSLayoutConstraint(item: refreshVc, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: 0))
        
        addConstraint(NSLayoutConstraint(item: refreshVc, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: refreshVc.bounds.width))
        
        addConstraint(NSLayoutConstraint(item: refreshVc, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: refreshVc.bounds.height))
        
    }
    
    //滚动的时候
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let sv = self.scrollView else {
            return
        }
        
        let height = -(sv.contentInset.top+sv.contentOffset.y)
        
        if height<0 {
            return
        }
        
        ///通过判断来改变手势
        if sv.isDragging {
            if self.refreshVcState == .WillRefresh {
                return
            }
            self.refreshVc?.doScroll(height)
            self.frame = CGRect(x: 0, y: -height, width: sv.bounds.width, height: height)
            if height > TSYRefreshOffset && self.refreshVcState == TSYRefreshState.Normal {
                print("放手刷新")
                self.refreshVcState = .Pulling
                self.refreshVc?.doPull()
            }else if height <= TSYRefreshOffset && self.refreshVcState == .Pulling {
                print("还要再拉才行啊")
                self.refreshVcState = .Normal
                self.refreshVc?.doNormal()
            }
            
        }else{
            if self.refreshVcState == .Pulling {
                self.frame = CGRect(x: 0, y: -height, width: sv.bounds.width, height: height)
                print("pull")
                startRefreshing()
                self.refreshVc?.WillRefresh()
                sendActions(for: UIControlEvents.valueChanged)
            }
            
        }
        
    }

}

