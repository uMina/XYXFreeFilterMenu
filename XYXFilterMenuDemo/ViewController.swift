//
//  ViewController.swift
//  XYXFilterMenuDemo
//
//  Created by Teresa on 2018/5/7.
//  Copyright © 2018年 Teresa. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let titles = ["第1列","第2列","第3列","第4列"]
    
    var grayspaceHeight:[CGFloat]  = []
    var views:[UIView] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let menu = XYXFreeFilterMenu.init(frame: CGRect(x: 0, y: 100, width: XYX_SCREEN_WIDTH, height: 44))
        menu.dataSource = self
        menu.delegate = self
        self.view.addSubview(menu)
        
        let view1 = Bundle.main.loadNibNamed("View1", owner: nil, options: nil)?.first as! View1
        let view2 = Bundle.main.loadNibNamed("View2", owner: nil, options: nil)?.first as! View2
        let view3 = Bundle.main.loadNibNamed("View3", owner: nil, options: nil)?.first as! View3
        let view4 = Bundle.main.loadNibNamed("View4", owner: nil, options: nil)?.first as! View4
        views.append(contentsOf: [view1,view2,view3,view4])
        
        let tempValue = XYX_SCREEN_HEIGHT - menu.frame.maxY
        grayspaceHeight = [tempValue - view1.frame.height, tempValue - view2.frame.height, tempValue - view3.frame.height, tempValue - view4.frame.height]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController : XYXFreeFilterMenuDelegate{
    
    func menu(_ menu: XYXFreeFilterMenu, tapIndex: Int) {
        print("菜单\(tapIndex):\(titles[tapIndex])被点击了")
    }
    func menu(_ menu: XYXFreeFilterMenu, openAt column: Int) {
        print("页面\(column):被打开了")
    }
    func menu(_ menu: XYXFreeFilterMenu, closedAt column: Int) {
        print("页面\(column):被关闭了")
    }
}

extension ViewController : XYXFreeFilterMenuDataSource{
    func menu(_ menu: XYXFreeFilterMenu, viewOfColumnAt index: Int) -> UIView {
        return views[index]
    }
    
    func menu(_ menu: XYXFreeFilterMenu, grayspaceHeightOfColumnAt index: Int) -> CGFloat {
        return grayspaceHeight[index]
    }
    
    func menu(_ menu: XYXFreeFilterMenu, titleOfColumnAt index: Int) -> String {
        return titles[index]
    }
    func numberOfColumns(menu: XYXFreeFilterMenu) -> Int {
        return titles.count
    }
    
    
}
