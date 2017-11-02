//
//  ChangeGender.swift
//  LKKJ
//
//  Created by Jinjun liang on 2017/10/26.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class ChangeGender: MyInfomationBase {
    var changeGenderCompletion:((_ result: String) -> Void)?
    var currentGender: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.separatorStyle = .singleLine
    }
    
    override func rightBarButtonItemEvent() {
        if changeGenderCompletion != nil {
            changeGenderCompletion!(currentGender ?? "")
        }
        super.rightBarButtonItemEvent()
    }
}

// MARK: - Table view data source & delegate
extension ChangeGender {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return LKGenders.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChangeGenderCell", for: indexPath)
        cell.textLabel?.text = LKGenders[indexPath.row]
        cell.accessoryType = .none
        if currentGender == cell.textLabel?.text {
            cell.accessoryType = .checkmark
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        currentGender = tableView.cellForRow(at: indexPath)?.textLabel?.text
        
        for (row, cell) in tableView.visibleCells.enumerated() {
            if row == indexPath.row {
                cell.accessoryType = .checkmark
            } else {
                cell.accessoryType = .none
            }
        }
    }
}
