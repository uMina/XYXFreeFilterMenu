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
    var viewControllers:[UIViewController] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let menu = XYXFreeFilterMenu.init(frame: CGRect(x: 0, y: 100, width: XYX_SCREEN_WIDTH, height: 44))
        menu.dataSource = self
        menu.delegate = self
        self.view.addSubview(menu)
        
        let aa = TableViewStyleC(nibName: "TableViewStyleC", bundle: nil)
        let bb = TableViewStyleB(nibName: "TableViewStyleB", bundle: nil)
        let cc = TableViewStyleA(nibName: "TableViewStyleA", bundle: nil)
        let dd = DemoCollectionViewController(nibName: "DemoCollectionViewController", bundle: nil)
        viewControllers.append(contentsOf: [aa,bb,cc,dd])
        
        let tempValue:CGFloat = XYX_SCREEN_HEIGHT - menu.frame.maxY
        let aaHeight:CGFloat = tempValue - aa.view.frame.height
        let bbHeight:CGFloat = 216.0
        let ccHeight:CGFloat = tempValue - cc.view.frame.height
        grayspaceHeight = [aaHeight, bbHeight, ccHeight, 0.0]
        
        bb.callbackFinished = { title in
            menu.closeFilter(with: title, at: 1)
        }
        cc.callbackFinished = { title in
            menu.closeFilter(with: title, at: 2)
        }
        dd.callbackFinished = { title in
            menu.closeFilter(with: title, at: 3)
        }
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
        return viewControllers[index].view
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
