//
//  XYXFreeFilterMenu.swift
//  XYXFilterMenuDemo
//
//  Created by Teresa on 2018/5/7.
//  Copyright © 2018年 Teresa. All rights reserved.
//

import Foundation
import CoreGraphics
import UIKit

class XYXFreeFilterMenu: UIView {
    
    //MARK: - Member
    var delegate:XYXFreeFilterMenuDelegate?
    var dataSource:XYXFreeFilterMenuDataSource?{
        didSet{
            configureMenuBar()
        }
    }
    
    // UI
    lazy var filterView:XYXFreeFilterView = {
        let filter = XYXFreeFilterView(menu: self)
        filter.backgroundColor = UIColor(white: 1.0, alpha: 1)
        return filter
    }()
    
    lazy var backGroundView:UIView = {
        let view = UIView()
        view.isOpaque = false
        view.frame = CGRect(x: frame.minX, y: frame.minY, width: frame.width, height: XYX_SCREEN_HEIGHT - frame.minY)
        let gesture = UITapGestureRecognizer.init(target: self, action: #selector(backgroundTapped(tapGesture:)))
        view.addGestureRecognizer(gesture)
        return view
    }()
    
    var titleLayers:[CATextLayer] = []
    var indicatorLayers:[CAShapeLayer] = []
    var menuBgLayers:[CALayer] = []
    
    // 关于设定的各种参数
    var numOfMenu = 1
    var menuBarStyle = XYXFreeFilterMenuStyle()
    
    let animateDurationShort = 0.2
    let animateDuration = 0.25
    
    // 当前选中列
    var currentSelectedColumn:Int = -1
    
    // 关于动画展示的参数
    var isDisplayed = false
    
    //MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureBaseSetting()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureBaseSetting()
    }
    
    //MARK: - fileprivate Configuration
    
    fileprivate func configureBaseSetting() {
        let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(menuTapped(tapGesture:)))
        tapGesture.numberOfTapsRequired = 1
        tapGesture.numberOfTouchesRequired = 1
        self.addGestureRecognizer(tapGesture)
    }
    
    fileprivate func configureMenuBar() {
        //初始化菜单栏
        self.layer.backgroundColor = UIColor.darkGray.cgColor
        numOfMenu = (dataSource?.numberOfColumns(menu: self))!
        let textLayerInterval = self.frame.size.width / CGFloat(numOfMenu * 2)
        let bgLayerInterval = self.frame.size.width / CGFloat(numOfMenu)
        
        var tempBgLayers:[CALayer] = []
        var tempTitles:[CATextLayer] = []
        var tempIndicators:[CAShapeLayer] = []
        
        for idx in 0...(numOfMenu-1) {
            //bgLayer
            let bgLayerPosition = CGPoint(x:(CGFloat(idx)+0.5)*bgLayerInterval, y:self.frame.height/2)
            let bgLayer = createBgLayer(color: menuBarStyle.backgroundDefaultColor, position: bgLayerPosition)
            self.layer.addSublayer(bgLayer)
            tempBgLayers.append(bgLayer)
            
            //title
            let titlePosition = CGPoint(x: CGFloat(idx*2+1) * textLayerInterval-8.0, y: self.frame.height / 2)
            let titleString = dataSource?.menu(self, titleOfColumnAt: idx)
            let titleLayer = createTextLayer(string:titleString!, color: menuBarStyle.defaultColor, position: titlePosition)
            self.layer.addSublayer(titleLayer)
            tempTitles.append(titleLayer)
            
            //indicator
            let indicatorLayer = createIndicator(color: menuBarStyle.defaultColor, position: CGPoint(x: titleLayer.frame.maxX, y: self.frame.height/2))
            self.layer.addSublayer(indicatorLayer)
            tempIndicators.append(indicatorLayer)
        }
        
        self.titleLayers = tempTitles
        self.indicatorLayers = tempIndicators
        self.menuBgLayers = tempBgLayers
    }
  
    //MARK: - Reset
    func resetMenu() {
        resetMenuTitle()
    }
    
    func resetMenuTitle() {
        for idx in 0...(numOfMenu-1) {
            let text = self.titleLayers[idx]
            let indicator = self.indicatorLayers[idx]
            
            let titleString = dataSource?.menu(self, titleOfColumnAt: idx)
            let size = self.calculateTitleSizeWithString(string: titleString!)
            let sizewidth = (size.width < ((self.frame.size.width / CGFloat(numOfMenu)) - menuBarStyle.titleMargin)) ? size.width : (self.frame.size.width / CGFloat(numOfMenu) - menuBarStyle.titleMargin)
            text.bounds = CGRect(x: 0, y: 0, width: sizewidth, height: size.height)
            text.string = titleString
            indicator.position = CGPoint(x: text.frame.maxX + menuBarStyle.titleMargin/4, y: indicator.position.y)
        }
    }
    
    //MARK: - From ContentView
    
    func closeFilter(with menuTitle:String?, at columIndex:Int) {
        
        if let senderTitle = menuTitle{
            
            let titleLayer = titleLayers[columIndex]
            titleLayer.string = senderTitle
            let size = calculateTitleSizeWithString(string: senderTitle)
            
            let sizeWidth = (size.width < ((self.frame.size.width / CGFloat(numOfMenu)) - menuBarStyle.titleMargin)) ? size.width : (self.frame.size.width / CGFloat(numOfMenu) - menuBarStyle.titleMargin)
            titleLayer.bounds = CGRect(x: 0, y: 0, width: sizeWidth, height: size.height)
            
            let indicatorLayer = indicatorLayers[columIndex]
            let position = CGPoint(x: titleLayer.frame.maxX, y: self.frame.height/2)
            indicatorLayer.position = CGPoint(x:(position.x + menuBarStyle.titleMargin/4), y:(position.y + 2))
        }
        closeFilter(at: columIndex)
    }
    
    func closeFilter(at columIndex:Int?){
        let column = columIndex == nil ? currentSelectedColumn : columIndex!
        animate(unfold: false, filterView: filterView, indicator: indicatorLayers[column], title: titleLayers[column], backgroundView: backGroundView) {
            self.isDisplayed = false
            self.menuBgLayers[self.currentSelectedColumn].backgroundColor = self.menuBarStyle.backgroundDefaultColor.cgColor
        }
    }
}

// Animate
extension XYXFreeFilterMenu{
    
    func animate(unfold:Bool, filterView:XYXFreeFilterView, indicator:CAShapeLayer, title:CATextLayer, backgroundView:UIView, complete:(()->Void)?) {
        self.beginIgnoringInteractionEvents()
        self.animate(indicator: indicator, unfold: unfold) {
            self.animate(title: title, selected: unfold, complete: {
                self.animate(backgroundView: backgroundView, show: unfold, complete: {
                    self.animate(filterView: filterView, show: unfold, complete: {
                        self.endIgnoringInteractionEvents()
                    })
                })
            })
        }
        if let cp = complete {
            cp()
        }
    }
    
    fileprivate func animate(indicator:CAShapeLayer,unfold:Bool,complete:(()->Void)?) {
        let animate = CABasicAnimation.init(keyPath: "transform.rotation.z")
        animate.duration = animateDuration
        animate.isRemovedOnCompletion = false
        animate.fillMode = kCAFillModeForwards
        animate.toValue = unfold ? Double.pi : 0
        indicator.add(animate, forKey: animate.keyPath)
        
        if unfold {
            indicator.fillColor = menuBarStyle.selectedColor.cgColor
        }else{
            indicator.fillColor = menuBarStyle.defaultColor.cgColor
        }
        if let cp = complete {
            cp()
        }
    }
    
    fileprivate func animate(title:CATextLayer,selected:Bool,complete:(()->Void)?) {
        
        let size = calculateTitleSizeWithString(string: title.string as! String)
        let sizeWidth = (size.width < (frame.width / CGFloat(numOfMenu) - menuBarStyle.titleMargin)) ? size.width : frame.width / CGFloat(numOfMenu) - menuBarStyle.titleMargin
        title.bounds = CGRect(x: 0, y: 0, width: sizeWidth, height: size.height)
        
        if selected {
            title.foregroundColor = menuBarStyle.selectedColor.cgColor
        }else{
            title.foregroundColor = menuBarStyle.defaultColor.cgColor
        }
        
        if let cp = complete {
            cp()
        }
    }
    
    fileprivate func animate(backgroundView:UIView,show:Bool,complete:(()->Void)?) {
        if show {
            self.superview?.addSubview(backgroundView)
            backgroundView.superview?.addSubview(self)
            UIView.animate(withDuration: animateDuration, animations: {
                backgroundView.backgroundColor = UIColor(white: 0.0, alpha: 0.3)
            })
        } else {
            UIView.animate(withDuration: animateDuration, animations: {
                backgroundView.backgroundColor = UIColor(white: 0.0, alpha: 0.0)
            }, completion: { (finish) in
                backgroundView.removeFromSuperview()
            })
        }
        if let cp = complete {
            cp()
        }
    }
    
    fileprivate func animate(filterView:XYXFreeFilterView, show:Bool, complete:(()->Void)?){
        if show{
            superview?.addSubview(filterView)
            filterView.superview?.addSubview(self)
            
            if let ds = dataSource{
                
                let grayspaceHeight = ds.menu(self, grayspaceHeightOfColumnAt: currentSelectedColumn)
                filterView.contentView = ds.menu(self, viewOfColumnAt: currentSelectedColumn)
                
                
                filterView.unfoldHeight = XYX_SCREEN_HEIGHT - frame.maxY - grayspaceHeight
                
                let newFrame = CGRect(x: self.frame.minX, y: self.frame.maxY, width: self.frame.width, height: filterView.unfoldHeight)
                if filterView.unfoldHeightChanged {
                    UIView.animate(withDuration: self.animateDuration, animations: {
                        filterView.frame = newFrame
                        filterView.contentView.frame = CGRect(origin: CGPoint.zero, size: newFrame.size)
                    }, completion: { (isSucccess) in
                        if let cp = complete{
                            cp()
                        }
                    })
                }else{
                    filterView.frame = newFrame
                    filterView.contentView.frame = CGRect(origin: CGPoint.zero, size: newFrame.size)
                    if let cp = complete{
                        cp()
                    }
                }
            }
            
        }else{
            UIView.animate(withDuration: animateDuration, animations: {
                filterView.frame = CGRect(x: 0, y: filterView.frame.minY, width: filterView.frame.width, height: 0)
            }, completion: { (isFinished) in
                let _ = filterView.subviews.map({ (subView) in
                    subView.removeFromSuperview()
                })
                filterView.removeFromSuperview()
            })
            if let cp = complete{
                cp()
            }
        }
    }
    
}

// Create
extension XYXFreeFilterMenu{
    
    fileprivate func createBgLayer(color:UIColor,position:CGPoint) -> CALayer {
        let layer = CALayer.init()
        layer.position = position
        layer.bounds = CGRect(x: position.x, y: position.y, width: frame.width/CGFloat(numOfMenu), height: frame.height-1)
        layer.backgroundColor = color.cgColor
        return layer
    }
    
    fileprivate func createIndicator(color:UIColor,position:CGPoint) -> CAShapeLayer{
        let layer = CAShapeLayer()
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x:0, y:0))
        path.addLine(to: CGPoint(x:8, y:0))
        path.addLine(to: CGPoint(x:4, y:4))
        path.close()
        
        layer.path = path.cgPath
        layer.lineWidth = 0.8
        layer.fillColor = color.cgColor
        
        let tranform = CGAffineTransform.identity
        let bound = path.cgPath.copy(strokingWithWidth: layer.lineWidth, lineCap: CGLineCap.butt, lineJoin: CGLineJoin.miter, miterLimit: layer.miterLimit, transform: tranform)
        layer.bounds = bound.boundingBox
        
        layer.position = CGPoint(x:(position.x + menuBarStyle.titleMargin/4), y:(position.y + 2))
        
        return layer
    }
    
    fileprivate func createTextLayer(string:String,color:UIColor,position:CGPoint) -> CATextLayer {
        
        let size = calculateTitleSizeWithString(string: string)
        let layer = CATextLayer()
        let sizeWidth = (size.width < ((self.frame.size.width / CGFloat(numOfMenu)) - menuBarStyle.titleMargin)) ? size.width : (self.frame.size.width / CGFloat(numOfMenu) - menuBarStyle.titleMargin)
        layer.bounds = CGRect(x: 0, y: 0, width: sizeWidth, height: size.height)
        layer.string = string
        layer.fontSize = menuBarStyle.titleFontSize
        layer.alignmentMode = kCAAlignmentCenter
        layer.foregroundColor = color.cgColor
        layer.contentsScale = UIScreen.main.scale
        layer.position = position
        layer.truncationMode = menuBarStyle.titleTruncation
        
        return layer
    }
    
    private func calculateTitleSizeWithString(string:String) -> CGSize {
        let fontSize = menuBarStyle.titleFontSize
        
        let dic = [NSAttributedStringKey.font:UIFont.systemFont(ofSize: fontSize)]
        let theString = NSString.init(string: string)
        var size = theString.boundingRect(with: CGSize(width: 280, height: 0), options: NSStringDrawingOptions(rawValue: NSStringDrawingOptions.truncatesLastVisibleLine.rawValue | NSStringDrawingOptions.usesLineFragmentOrigin.rawValue | NSStringDrawingOptions.usesFontLeading.rawValue), attributes: dic, context: nil).size
        
        if string.contains("1") {
            size.width += 2
        }
        return size
    }
    
}

// TapGesture
extension XYXFreeFilterMenu{
    
    @objc private func backgroundTapped(tapGesture:UITapGestureRecognizer) {
        guard currentSelectedColumn >= 0 else{
            return
        }
        animate(unfold: false, filterView: filterView, indicator: indicatorLayers[currentSelectedColumn], title: titleLayers[currentSelectedColumn], backgroundView: backGroundView) {
            self.isDisplayed = false
            self.menuBgLayers[self.currentSelectedColumn].backgroundColor = self.menuBarStyle.backgroundDefaultColor.cgColor
            
            if let delegate = self.delegate {
                delegate.menu?(self, closedAt: self.currentSelectedColumn)
            }
        }
    }
    
    @objc private func menuTapped(tapGesture:UITapGestureRecognizer) {
        guard self.dataSource != nil else {
            return
        }
        
        if tapGesture.isEnabled == true{
            tapGesture.isEnabled = false
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+0.4, execute: {
                tapGesture.isEnabled = true
            })
        }else{
            return
        }
        
        let touchPoint = tapGesture.location(in: self)
        let tapIndex = Int(touchPoint.x / (self.frame.width / CGFloat(numOfMenu)))
        
        for idx in 0...numOfMenu-1{
            if idx != tapIndex{
                animate(indicator: indicatorLayers[idx], unfold: false, complete: {
                    self.animate(title: self.titleLayers[idx], selected: false, complete: {
                        self.menuBgLayers[idx].backgroundColor = self.menuBarStyle.backgroundDefaultColor.cgColor
                    })
                })
            }
        }
        
        if tapIndex == currentSelectedColumn && isDisplayed {
            //Dismiss filterView.
            animate(unfold: false, filterView: filterView, indicator: indicatorLayers[tapIndex], title: titleLayers[tapIndex], backgroundView: backGroundView, complete: {
                self.currentSelectedColumn = tapIndex
                self.isDisplayed = false
                self.menuBgLayers[tapIndex].backgroundColor = self.menuBarStyle.backgroundDefaultColor.cgColor
                
                if let delegate = self.delegate {
                    delegate.menu?(self, closedAt: self.currentSelectedColumn)
                }
            })
            
        } else {
            currentSelectedColumn = tapIndex
            animate(unfold: true, filterView: filterView, indicator: indicatorLayers[tapIndex], title: titleLayers[tapIndex], backgroundView: backGroundView, complete: {
                self.isDisplayed = true
                self.menuBgLayers[tapIndex].backgroundColor = self.menuBarStyle.backgroundSelectedColor.cgColor
                
                if let delegate = self.delegate {
                    delegate.menu?(self, openAt: self.currentSelectedColumn)
                }
            })
        }
        
        if let delegate = self.delegate {
            delegate.menu?(self, tapIndex: currentSelectedColumn)
        }
    }
    
}

// Extra Method
extension XYXFreeFilterMenu{
    fileprivate func beginIgnoringInteractionEvents() {
        if UIApplication.shared.isIgnoringInteractionEvents == false {
            UIApplication.shared.beginIgnoringInteractionEvents()
            perform(#selector(self.endIgnoringInteractionEvents), with: nil, afterDelay: animateDuration)
        }
    }
    
    @objc fileprivate func endIgnoringInteractionEvents() {
        if UIApplication.shared.isIgnoringInteractionEvents {
            UIApplication.shared.endIgnoringInteractionEvents()
        }
    }
    
}
