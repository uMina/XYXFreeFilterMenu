//
//  File.swift
//  XYXFilterMenuDemo
//
//  Created by Teresa on 2018/5/7.
//  Copyright © 2018年 Teresa. All rights reserved.
//

import Foundation
import UIKit

class XYXFreeFilterView: UIView {
    var menu:XYXFreeFilterMenu?
    var contentView = UIView(){
        willSet{
            contentView.removeFromSuperview()
        }
        didSet{
            addSubview(contentView)
        }
    }
    
    // 带默认数据的设定值
    var preUnfoldHeight:CGFloat = 300
    var unfoldHeight:CGFloat = 300{
        didSet{
            preUnfoldHeight = oldValue
            contentView.frame = CGRect(origin: CGPoint.zero, size: CGSize(width: frame.width, height: unfoldHeight))
        }
    }
    
    var unfoldHeightChanged:Bool{
        get{
            return preUnfoldHeight == unfoldHeight ? false : true
        }
    }
    
    //MARK: - Life Cycle
    convenience init(menu:XYXFreeFilterMenu) {
        self.init()
        self.frame = CGRect(origin: menu.frame.origin, size: CGSize(width: menu.frame.width, height: 0))
        self.menu = menu
        configureBaseSetting()
    }
    
    private override init(frame: CGRect) {
        super.init(frame: frame)
        configureBaseSetting()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented. And 'self.menu' has to be assigned.")
    }
    
    func configureBaseSetting() {
        self.clipsToBounds = true
    }
}
