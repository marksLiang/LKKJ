//
//  MyOderDetails.swift
//  LKKJ
//
//  Created by Jinjun liang on 2017/10/26.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class MyOderDetails: UITableViewController {

    fileprivate let normalCellIdentifier = "normalCellIdentifier"
    fileprivate let sectionTitles = ["", "收件人信息", "商品信息"]
    fileprivate let rowHeights: [CGFloat] = [44.0, 54.0, 120.0]
    fileprivate let oderTitles = ["订单号：", "下单账号：","订单状态："]
    fileprivate let oderContents = ["20171026", "1333338888888", "代发货"]
    fileprivate let receiverInfos = ["namge" : "王尼玛", "电话" : "17878787878", "地址" : "南宁市 青秀区 xxxxxxxxxxxxxxxxxxxxxxxxx", "买家备注" : "无"]
    fileprivate let rows = [3, 4, 1]
    fileprivate let titlFontSize: CGFloat = 14.0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "处理", style: .plain, target: self, action: #selector(rightBarButtonItemEvent))
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: normalCellIdentifier)
//        tableView.separatorInset = UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0)
    }
    
    @objc fileprivate func rightBarButtonItemEvent() {
        debugPrint(#function)
    }
}

// MARK: - Table view data source
extension MyOderDetails {
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rows[section]
    }
    
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var returnCell: UITableViewCell?
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MyOderDetailsCell", for: indexPath) as! MyOderDetailsCell
            cell.titleLabel?.font = UIFont.systemFont(ofSize: titlFontSize)
            cell.titleLabel.text = oderTitles[indexPath.row]
            cell.contentLabel.text = oderContents[indexPath.row]
            if indexPath.row == oderContents.count - 1 {
                cell.contentLabel.textColor = UIColor.red
            }
            returnCell = cell
        } else if indexPath.section == 1 {
            let titles = Array(receiverInfos.keys)
            let infos = Array(receiverInfos.values)
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: normalCellIdentifier, for: indexPath)
                cell.textLabel?.text = infos[indexPath.row]
                returnCell = cell
            } else {
                var cell = tableView.dequeueReusableCell(withIdentifier: "infoCellIdentifier")
                if cell == nil {
                    cell = UITableViewCell(style: .subtitle, reuseIdentifier: "infoCellIdentifier")
                    cell?.textLabel?.textColor = UIColor.gray
                }
                cell?.textLabel?.text = titles[indexPath.row]
                cell?.detailTextLabel?.text = infos[indexPath.row]
                returnCell = cell
            }
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MyOderGoodInfoCell", for: indexPath)
            returnCell = cell
        }
        returnCell?.textLabel?.font = UIFont.systemFont(ofSize: titlFontSize)
        returnCell?.selectionStyle = .none
        return returnCell ?? UITableViewCell()
     }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return rowHeights[indexPath.section]
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 10.0
        } else {
            return 34.0
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
}
