//
//  ViewController.swift
//  RainAnimation
//
//  Created by apple on 2017/7/28.
//  Copyright © 2017年 apple. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    fileprivate let titles = ["3DBlock","下拉刷新动画","比例图动画","柱状图","加载动画","水状动画","🌰特效"]
    
    private var myTableView:UITableView = {
        let vc = UITableView.init()
        return vc
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "RainAnimation"
        // Do any additional setup after loading the view, typically from a nib.
        
        self.myTableView.frame = self.view.bounds
        self.view.addSubview(self.myTableView)
        self.myTableView.tableFooterView = UIView.init()
        self.myTableView.delegate = self
        self.myTableView.dataSource = self
        self.myTableView.rowHeight = 50
        self.myTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        
        if cell == nil{
            cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        }
        
        cell?.textLabel?.text = self.titles[indexPath.row]
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0{
            //3d方块
            self.pushCtr(ctr: ThreeDBlockCtr())
        }else if indexPath.row == 1 {
            self.pushCtr(ctr: TableViewController())
        }else if indexPath.row == 2 {
            self.pushCtr(ctr: CirclePercentageCtr())
        }else if indexPath.row == 3 {
            self.pushCtr(ctr: SquarePercentageCtr())
        }else if indexPath.row == 4 {
            self.pushCtr(ctr: RainCircleLoadingCtr())
        }else if indexPath.row == 5 {
            self.pushCtr(ctr: WaterViewController())
        }else if indexPath.row == 6 {
            self.pushCtr(ctr: EmitterCtr())
        }
        
        
    }
    
    func pushCtr(ctr:UIViewController){
        self.navigationController?.pushViewController(ctr, animated: true)
    }
    
    
}

