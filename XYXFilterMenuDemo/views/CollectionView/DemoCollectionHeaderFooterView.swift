//
//  DemoCollectionHeaderFooterView.swift
//  XYXFilterMenuDemo
//
//  Created by Teresa on 2018/5/15.
//  Copyright © 2018年 Teresa. All rights reserved.
//

import UIKit

class DemoCollectionHeaderView: UICollectionReusableView {
    
    lazy var titleLabel:UILabel = {
        let textLabel = UILabel.init(frame: CGRect.zero)
        textLabel.font = UIFont.systemFont(ofSize: MENU_COLLECTION_HEADER_TEXT_FONTSIZE)
        textLabel.textColor = MENU_COLLECTION_HEADER_TEXT_COLOR
        textLabel.text = "Title"
        return textLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(titleLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    class func reuseIdentifier() -> String {
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }
    
    override func layoutSubviews() {
        titleLabel.sizeToFit()
        titleLabel.frame = CGRect(x: 10, y: frame.height-titleLabel.frame.height-6, width: titleLabel.frame.width+6, height:titleLabel.frame.height)
    }
}

class DemoCollectionFooterView: UICollectionReusableView {
    
    lazy var lineView:UIView = {
        let line = UIView.init(frame: CGRect(x: 10.0, y: 0.5, width: XYX_SCREEN_WIDTH-10.0, height: 0.5))
        line.backgroundColor = MENU_SEPARATOR_COLOR
        return line
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(lineView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    class func reuseIdentifier() -> String {
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }
}
