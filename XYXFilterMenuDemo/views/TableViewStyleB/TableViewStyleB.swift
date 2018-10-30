//
//  TableViewStyleB.swift
//  XYXFilterMenuDemo
//
//  Created by Teresa on 2018/5/15.
//  Copyright © 2018年 Teresa. All rights reserved.
//

import UIKit

class TableViewStyleB: UIViewController, UITableViewDataSource, UITableViewDelegate {
    let source = ["不限","50万以内","50-70万","70-90万","90-110万"]
    var selectedRow = 0
    var callbackFinished:((String)->())?
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var leftTextField: UITextField!
    @IBOutlet weak var rightTextField: UITextField!
    @IBAction func confirmBtnClicked(_ sender: Any) {
        let leftValue = leftTextField.text ?? ""
        let rightValue = rightTextField.text ?? ""
        let isLeftEmpty = leftValue.isEmpty
        let isRightEmpty = rightValue.isEmpty
        guard (!isLeftEmpty || !isRightEmpty) && leftValue <= rightValue else {
            return
        }
        if let callback = callbackFinished {
            let value:String = {
                if isLeftEmpty == false && isRightEmpty == false{
                    return leftValue + "-" + rightValue + "万"
                }else if isLeftEmpty {
                    return rightValue + "万以内"
                }else {
                    return leftValue + "万以上"
                }
                }()
            callback(value)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.height, height: 400)
        tableView.register(TableViewStyleBCell.classForCoder(), forCellReuseIdentifier: TableViewStyleBCell.reuseIdentifier())
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        view.endEditing(true)
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
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewStyleBCell.reuseIdentifier()) as! TableViewStyleBCell
        cell.textLabel?.text = source[indexPath.item]
        if indexPath.row == selectedRow {
            cell.isSelected = true
        }else{
            cell.isSelected = false
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedRow = indexPath.row
        tableView.reloadData()
        leftTextField.text = nil
        rightTextField.text = nil
        if let callback = callbackFinished {
            callback(source[selectedRow])
        }
    }
}
