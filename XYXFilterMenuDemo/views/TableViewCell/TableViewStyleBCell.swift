//
//  TableViewStyleBCell.swift
//  XYXFilterMenuDemo
//
//  Created by Teresa on 2018/5/15.
//  Copyright © 2018年 Teresa. All rights reserved.
//

import UIKit
class TableViewStyleBCell: UITableViewCell {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.selectionStyle = .none
    }
    
    override var isSelected: Bool{
        didSet{
            if isSelected == true {
                self.textLabel?.textColor = MENU_TABLEVIEW_CELL_TEXT_COLOR_SELECTED
            } else {
                self.textLabel?.textColor = MENU_TABLEVIEW_CELL_TEXT_COLOR_DEFAULT
            }
        }
    }
    
    class func reuseIdentifier() -> String {
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }
}
