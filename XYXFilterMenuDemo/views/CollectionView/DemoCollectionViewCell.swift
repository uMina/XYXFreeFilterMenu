//
//  DemoCollectionViewCell.swift
//  XYXFilterMenuDemo
//
//  Created by Teresa on 2018/5/15.
//  Copyright © 2018年 Teresa. All rights reserved.
//

import UIKit

class DemoCollectionViewCell: UICollectionViewCell {
    lazy var textLabel:UILabel = {
        let textLabel = UILabel.init(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
        textLabel.backgroundColor = MENU_COLLECTION_CELL_BG_COLOR_DEFAULT
        textLabel.layer.masksToBounds = true
        textLabel.layer.cornerRadius = 7
        textLabel.layer.borderWidth = 1
        textLabel.layer.borderColor = MENU_COLLECTION_CELL_BORDER_COLOR_DEFAULT.cgColor
        textLabel.text = "item"
        textLabel.textAlignment = NSTextAlignment.center
        textLabel.font = UIFont.systemFont(ofSize: MENU_COLLECTION_CELL_TEXT_FONTSIZE)
        return textLabel
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(textLabel)
        self.clipsToBounds = true
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    class func reuseIdentifier() -> String {
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }
    
    override func layoutSubviews() {
        contentView.frame = bounds
        textLabel.frame = bounds
    }
    
    override var isSelected: Bool{
        didSet{
            if isSelected{
                textLabel.textColor = MENU_COLLECTION_CELL_TEXT_COLOR_SELECTED
                textLabel.backgroundColor = MENU_COLLECTION_CELL_BG_COLOR_SELECTED
                textLabel.layer.borderColor = MENU_COLLECTION_CELL_BORDER_COLOR_SELECTED.cgColor
                
            }else{
                textLabel.textColor = MENU_COLLECTION_CELL_TEXT_COLOR_DEFAULT
                textLabel.backgroundColor = MENU_COLLECTION_CELL_BG_COLOR_DEFAULT
                textLabel.layer.borderColor = MENU_COLLECTION_CELL_BORDER_COLOR_DEFAULT.cgColor
                
            }
        }
    }
    
}
