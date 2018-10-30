//
//  XYXFilterViewCell.swift
//  XYXFilterMenu_Swift
//
//  Created by Teresa on 2017/12/20.
//  Copyright © 2017年 Teresa. All rights reserved.
//

import Foundation
import UIKit
//--------------- 默认尺寸 ---------------//
let MENU_TABLEVIEW_CELL_TEXT_FONTSIZE:CGFloat = 14.0
let MENU_COLLECTION_CELL_TEXT_FONTSIZE:CGFloat = 14.0
let MENU_COLLECTION_HEADER_TEXT_FONTSIZE:CGFloat = 14.0
let COLLECTION_CELL_DEFAULT_SIZE = CGSize.init(width:floor((XYX_SCREEN_WIDTH-50)/4), height: 30)
//--------------- 默认颜色 ---------------//
let MENU_TABLEVIEW_CELL_BG_COLOR_WHITE = UIColor.white
let MENU_TABLEVIEW_CELL_TEXT_COLOR_DEFAULT = UIColor(red: 51.0/255, green: 51.0/255, blue: 51.0/255, alpha: 1)      //黑色
let MENU_TABLEVIEW_CELL_TEXT_COLOR_SELECTED = UIColor(red: 88.0/255, green: 149.0/255, blue: 248.0/255, alpha: 1)   //蓝色

let MENU_COLLECTION_CELL_BG_COLOR_DEFAULT = UIColor(red: 238.0/255, green: 238.0/255, blue: 238.0/255, alpha: 1)    //浅灰色
let MENU_COLLECTION_CELL_BG_COLOR_SELECTED = UIColor(red: 244.0/255, green: 248.0/255, blue: 255.0/255, alpha: 1)   //浅蓝灰色
let MENU_COLLECTION_CELL_TEXT_COLOR_DEFAULT = UIColor(red: 51.0/255, green: 51.0/255, blue: 51.0/255, alpha: 1)     //黑色
let MENU_COLLECTION_CELL_TEXT_COLOR_SELECTED = UIColor(red: 88.0/255, green: 149.0/255, blue: 248.0/255, alpha: 1)  //蓝色
let MENU_COLLECTION_CELL_BORDER_COLOR_DEFAULT = UIColor(red: 221.0/255, green: 221.0/255, blue: 221.0/255, alpha: 1)//深灰色
let MENU_COLLECTION_CELL_BORDER_COLOR_SELECTED = UIColor(red: 88.0/255, green: 149.0/255, blue: 248.0/255, alpha: 1)//蓝色

let MENU_COLLECTION_HEADER_TEXT_COLOR = UIColor(red: 51.0/255, green: 51.0/255, blue: 51.0/255, alpha: 1)           //黑色
let MENU_SEPARATOR_COLOR = UIColor(red: 227.0/255, green: 227.0/255, blue: 227.0/255, alpha: 1)
let MENU_ANNEX_BG_COLOR = UIColor(red: 250.0/255, green: 250.0/255, blue: 250.0/255, alpha: 1)

