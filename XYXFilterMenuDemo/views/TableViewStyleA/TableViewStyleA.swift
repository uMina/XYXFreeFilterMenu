//
//  TableViewStyleA.swift
//  XYXFilterMenuDemo
//
//  Created by Teresa on 2018/5/15.
//  Copyright © 2018年 Teresa. All rights reserved.
//

import UIKit

class TableViewStyleA: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let source = ["不限","弟子规","圣人训","首孝悌","次谨信","泛爱众","而亲仁","有余力","则学文"]
    var selectedIndexPaths:[IndexPath] = []
    var callbackFinished:((String)->())?
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var confirmBtn: UIButton!
    @IBAction func confirmBtnClicked(_ sender: Any) {
        print(selectedIndexPaths)
        if let callback = callbackFinished {
            if selectedIndexPaths.contains(IndexPath(item: 0, section: 0)){
                callback("第四列")
            }else{
                callback("更多")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.height, height: 400)
        tableView.register(UINib.init(nibName: TableViewTailImageCell.reuseIdentifier(), bundle: nil), forCellReuseIdentifier: TableViewTailImageCell.reuseIdentifier())
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return source.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewTailImageCell.reuseIdentifier()) as! TableViewTailImageCell
        cell.nameLabel?.text = source[indexPath.item]
        if indexPath.row == 0 {
            cell.showIcon = false
        }
        if selectedIndexPaths.contains(indexPath) {
            cell.isSelected = true
        }else{
            cell.isSelected = false
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            selectedIndexPaths.removeAll()
            selectedIndexPaths.append(indexPath)
            
        }else{
            let specialIdx = IndexPath(item: 0, section: 0)
            if let sIdx = selectedIndexPaths.index(of: specialIdx){
                selectedIndexPaths.remove(at: sIdx)
            }
            
            if selectedIndexPaths.contains(indexPath) {
                selectedIndexPaths.remove(at: selectedIndexPaths.index(of: indexPath)!)
            }else{
                selectedIndexPaths.append(indexPath)
            }
        }
        
        tableView.reloadData()
    }
    
}
