//
//  DemoTableViewMoreController.swift
//  XYXFilterMenuDemo
//
//  Created by Teresa on 2018/5/14.
//  Copyright © 2018年 Teresa. All rights reserved.
//

import UIKit


class TableViewStyleC: UIViewController {
    
    var defaultHeight:CGFloat = 400
    
    let sourceLine = ["第1行","第2行"]
    let sourceLine_1 = ["第1-1行","第1-2行"]
    let sourceLine_2 = ["次谨信","泛爱众","而亲仁","有余力","则学文"]
    let sourceLine_1_1 = ["不限","弟子规","圣人训","首孝悌"]
    let sourceLine_1_2 = ["不限","父母呼","应勿缓","父母命","行勿懒"]
    
    var currentLine1 = 0{
        didSet{
            currentLine2 = 0
        }
    }
    var currentLine2 = 0{
        didSet{
            currentLine3 = 0
        }
    }
    var currentLine3 = 0
    
    static let firstTabViewTag = 301
    static let secondTabViewTag = 302
    static let thirdTabViewTag = 303
    
    private let firstTableView:UITableView = {
        let tableView = UITableView()
        tableView.tag = firstTabViewTag
        tableView.tableFooterView = UIView()
        tableView.register(UINib(nibName: "TableViewArrowCell", bundle: nil), forCellReuseIdentifier: TableViewArrowCell.reuseIdentifier())
        return tableView
    }()
    private let secondTableView:UITableView = {
        let tableView = UITableView()
        tableView.tag = secondTabViewTag
        tableView.tableFooterView = UIView()
        tableView.register(UINib(nibName: "TableViewTailImageCell", bundle: nil), forCellReuseIdentifier: TableViewTailImageCell.reuseIdentifier())
        return tableView
    }()
    private let thirdTableView:UITableView = {
        let tableView = UITableView()
        tableView.tag = thirdTabViewTag
        tableView.tableFooterView = UIView()
        tableView.register(UINib(nibName: "TableViewTailImageCell", bundle: nil), forCellReuseIdentifier: TableViewTailImageCell.reuseIdentifier())
        return tableView
    }()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
        self.view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.height, height: 400)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureComposition()
    }

    func configureUI(){
        view.clipsToBounds = true
        view.backgroundColor = UIColor.cyan
        view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: defaultHeight)
        firstTableView.delegate = self
        firstTableView.dataSource = self
        secondTableView.delegate = self
        secondTableView.dataSource = self
        thirdTableView.delegate = self
        thirdTableView.dataSource = self
    }
    func configureComposition(showThirdLine:Bool = false){
        if showThirdLine {
            let width = ceil(UIScreen.main.bounds.width/2)
            firstTableView.frame = CGRect(x: 0, y: 0, width: width, height: defaultHeight)
            secondTableView.frame = CGRect(x: firstTableView.frame.maxX, y: 0, width: width, height: defaultHeight)
            view.addSubview(firstTableView)
            view.addSubview(secondTableView)
            thirdTableView.removeFromSuperview()
            
            secondTableView.reloadData()
            thirdTableView.reloadData()
        }else{
            let width = ceil(UIScreen.main.bounds.width/3)
            firstTableView.frame = CGRect(x: 0, y: 0, width: width, height: defaultHeight)
            secondTableView.frame = CGRect(x: firstTableView.frame.maxX, y: 0, width: width, height: defaultHeight)
            thirdTableView.frame = CGRect(x: secondTableView.frame.maxX, y: 0, width: width, height: defaultHeight)
            view.addSubview(firstTableView)
            view.addSubview(secondTableView)
            view.addSubview(thirdTableView)
            
            secondTableView.reloadData()
        }
    }
}
extension TableViewStyleC:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == firstTableView {
            currentLine1 = indexPath.row
            firstTableView.reloadData()
            if currentLine1 == 0 {
                configureComposition()
            }else{
                configureComposition(showThirdLine: true)
            }
            
        }else if tableView == secondTableView{
            currentLine2 = indexPath.row
            secondTableView.reloadData()
            thirdTableView.reloadData()
        }else if tableView == thirdTableView{
            currentLine3 = indexPath.row
            thirdTableView.reloadData()
            print("当前选择是:\(currentLine1):\(currentLine2):\(currentLine3)")
        }
    }
}

extension TableViewStyleC:UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == firstTableView{
            return sourceLine.count
        }else if tableView == secondTableView{
            switch currentLine1{
            case 0:
                return sourceLine_1.count
            case 1:
                return sourceLine_2.count
            default:
                return 0
            }
        }else{
            switch currentLine2{
            case 0:
                return sourceLine_1_1.count
            case 1:
                return sourceLine_1_2.count
            default:
                return 0
            }
            
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch tableView {
        case firstTableView:
            let cell = tableView.dequeueReusableCell(withIdentifier: TableViewArrowCell.reuseIdentifier()) as! TableViewArrowCell
            cell.isSelected = indexPath.row == currentLine1 ? true : false
            cell.nameLabel.text = sourceLine[indexPath.row]
            return cell
            
        case secondTableView:
            let cell = tableView.dequeueReusableCell(withIdentifier: TableViewTailImageCell.reuseIdentifier()) as! TableViewTailImageCell
            cell.isSelected = indexPath.row == currentLine2 ? true : false
            if currentLine1 == 0{
                cell.nameLabel.text = sourceLine_1[indexPath.row]
            }else if currentLine1 == 1{
                cell.nameLabel.text = sourceLine_2[indexPath.row]
            }
            cell.showIcon = false
            return cell
            
        case thirdTableView:
            let cell = tableView.dequeueReusableCell(withIdentifier: TableViewTailImageCell.reuseIdentifier()) as! TableViewTailImageCell
            cell.isSelected = indexPath.row == currentLine3 ? true : false
    
            if currentLine1 == 0 {
                if currentLine2 == 0{
                    cell.nameLabel.text = sourceLine_1_1[indexPath.row]
                }else if currentLine2 == 1{
                    cell.nameLabel.text = sourceLine_1_2[indexPath.row]
                }
            }
            return cell
            
        default:
            let cell = UITableViewCell.init()
            cell.textLabel?.text = "未定义"
            return cell
        }


    }
    
        
}

