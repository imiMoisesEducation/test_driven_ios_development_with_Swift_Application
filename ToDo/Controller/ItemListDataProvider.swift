//
//  ItemListDataProvider.swift
//  ToDo
//
//  Created by Moi's Mac on 17/9/17.
//  Copyright © 2017 Moi's Mac. All rights reserved.
//

import UIKit

class ItemListDataProvider: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    
    var itemManager: ItemManager?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let itemManager = itemManager else{return 0}
        guard let itemSection = Section.init(rawValue: section) else{
            fatalError()
        }
        
        let numberOfRows: Int
        
        switch itemSection{
        case .ToDo:
            numberOfRows = itemManager.toDoCount
        case .Done:
            numberOfRows = itemManager.doneCount
        }
        
        return numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemCell
        
        guard let itemManager = itemManager else{
            fatalError()
        }
        guard let section = Section.init(rawValue: indexPath.section) else{
            fatalError()
        }
        
        let item: ToDoItem
        
        switch section{
        case .ToDo:
            item = itemManager.itemAt(index: indexPath.row)
        case .Done:
            item = itemManager.doneItemAt(index: indexPath.row)
        }
        
        cell.configCellWith(item: item)
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        
        guard let section = Section(rawValue: indexPath.section) else
        {
            fatalError()
        }
        
        
        let buttonTitle: String
        
        switch section{
        case .ToDo:
            buttonTitle = "Check"
        case .Done:
            buttonTitle = "Uncheck"
        }
        
        return buttonTitle
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        guard let itemManager = itemManager else
        {
            fatalError()
        }
        
        guard let section = Section(rawValue: indexPath.section) else
        {
            fatalError()
        }
        
        
        switch section{
        case .ToDo:
            itemManager.checkItemAt(index: indexPath.row)
        case .Done:
            itemManager.uncheckItemAt(index: indexPath.row)
        }
        
        tableView.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

}

enum Section: Int{
    case ToDo
    case Done
}
