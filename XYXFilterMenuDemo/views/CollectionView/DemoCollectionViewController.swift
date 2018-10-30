//
//  DemoCollectionViewController.swift
//  XYXFilterMenuDemo
//
//  Created by Teresa on 2018/5/9.
//  Copyright © 2018年 Teresa. All rights reserved.
//

import UIKit

class DemoCollectionViewController: UIViewController {
    let source3_0 = ["苟擅为","子道亏"]
    let source3_1 = ["物虽小","勿私藏","苟私藏","亲心伤"]
    let source3_2 = ["亲所好","力为具","亲所恶"]
    let source3 = ["第一行","第二行","第三行"]
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var layout: UICollectionViewFlowLayout!
    
    var callbackFinished:((String)->())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.showsVerticalScrollIndicator = false
        collectionView.allowsSelection = false
        collectionView.allowsMultipleSelection = true
        collectionView.dataSource = self
        
        layout.scrollDirection = UICollectionViewScrollDirection.vertical
        layout.headerReferenceSize = CGSize(width: XYX_SCREEN_WIDTH, height: 40.0)
        layout.footerReferenceSize = CGSize(width: XYX_SCREEN_WIDTH, height: 1)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10)
        
        collectionView.register(DemoCollectionViewCell.classForCoder(), forCellWithReuseIdentifier: DemoCollectionViewCell.reuseIdentifier())
        collectionView.register(DemoCollectionHeaderView.classForCoder(), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: DemoCollectionHeaderView.reuseIdentifier())
        collectionView.register(DemoCollectionFooterView.classForCoder(), forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: DemoCollectionFooterView.reuseIdentifier())
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func clearBtnClicked(_ sender: UIButton) {
        print("清空按钮被点击")
        collectionView.reloadData()
    }
    
    @IBAction func confirmBtnClicked(_ sender: UIButton) {
        
        var title = "第三列"
        
        if let arr = collectionView.indexPathsForSelectedItems{        
            print("被选中的IndexItems: \(arr)")
            title = arr.count > 0 ? "更多" : "第三列"
        }
        
        if let callback = callbackFinished {
            callback(title)
        }
    }
}
extension DemoCollectionViewController:UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int{
        return source3.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return source3_0.count
        case 1:
            return source3_1.count
        case 2:
            return source3_2.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DemoCollectionViewCell.reuseIdentifier(), for: indexPath) as! DemoCollectionViewCell
        switch indexPath.section {
        case 0:
            cell.textLabel.text = source3_0[indexPath.item]
        case 1:
            cell.textLabel.text = source3_1[indexPath.item]
        case 2:
            cell.textLabel.text = source3_2[indexPath.item]
        default:
            cell.textLabel.text = "未定义"
        }
        
        cell.isSelected = false
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionElementKindSectionHeader:
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind:UICollectionElementKindSectionHeader,  withReuseIdentifier: DemoCollectionHeaderView.reuseIdentifier(), for: indexPath) as! DemoCollectionHeaderView
            headerView.titleLabel.text = source3[indexPath.section]
            headerView.layoutIfNeeded()
            return headerView
            
        case UICollectionElementKindSectionFooter:
            let footerView = collectionView.dequeueReusableSupplementaryView(ofKind:UICollectionElementKindSectionFooter,  withReuseIdentifier: DemoCollectionFooterView
                .reuseIdentifier(), for: indexPath)
            return footerView
            
        default:
            return UICollectionReusableView.init(frame: CGRect.zero)
        }
    }
    
}

// MARK:-UICollectionViewDelegate
extension DemoCollectionViewController:UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width:floor((XYX_SCREEN_WIDTH-50)/4), height: 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
}

