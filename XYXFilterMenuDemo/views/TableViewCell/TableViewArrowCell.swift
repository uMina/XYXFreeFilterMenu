//
//  TableViewArrowCell.swift
//  XYXFilterMenuDemo
//
//  Created by Teresa on 2018/5/15.
//  Copyright © 2018年 Teresa. All rights reserved.
//

import UIKit

class TableViewArrowCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    
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
                self.nameLabel?.textColor = MENU_TABLEVIEW_CELL_TEXT_COLOR_SELECTED
                iconImageView.image = UIImage(named: "icon_selected")
            } else {
                self.nameLabel?.textColor = MENU_TABLEVIEW_CELL_TEXT_COLOR_DEFAULT
                iconImageView.image = UIImage(named: "icon_default")
            }
        }
    }
    
    class func reuseIdentifier() -> String {
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }
}
