//
//  XYXFreeFilterMenuProtocol.swift
//  XYXFilterMenuDemo
//
//  Created by Teresa on 2018/5/7.
//  Copyright © 2018年 Teresa. All rights reserved.
//

import Foundation
import UIKit

protocol XYXFreeFilterMenuDataSource : NSObjectProtocol {
    
    //关于MenuBar
    func numberOfColumns(menu:XYXFreeFilterMenu) -> Int
    func menu(_ menu:XYXFreeFilterMenu, titleOfColumnAt index:Int) -> String
    
    //关于FilterView
    func menu(_ menu:XYXFreeFilterMenu, grayspaceHeightOfColumnAt index:Int) -> CGFloat
    func menu(_ menu:XYXFreeFilterMenu, viewOfColumnAt index:Int) -> UIView
    
}

@objc protocol XYXFreeFilterMenuDelegate : NSObjectProtocol {
    
    @objc optional func menu(_ menu:XYXFreeFilterMenu,tapIndex:Int)
    @objc optional func menu(_ menu:XYXFreeFilterMenu, openAt column:Int)
    @objc optional func menu(_ menu:XYXFreeFilterMenu, closedAt column:Int)
    
}
