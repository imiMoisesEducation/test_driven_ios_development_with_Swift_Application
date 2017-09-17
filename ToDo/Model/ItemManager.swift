//
//  ItemManager.swift
//  ToDo
//
//  Created by Moi's Mac on 17/9/17.
//  Copyright © 2017 Moi's Mac. All rights reserved.
//

import Foundation

class ItemManager{
    var toDoCount: Int{ return toDoItems.count}
    var doneCount: Int{ return doneItems.count}
    private var toDoItems = [ToDoItem]()
    private var doneItems = [ToDoItem]()
    
    func add(item: ToDoItem)
    {
        if !toDoItems.contains(item){
            toDoItems.append(item)
        }
    }
    
    
    func checkItemAt(index: Int){
        let item = toDoItems.remove(at: index)
        doneItems.append(item)
    }
 
    func itemAt(index: Int) -> ToDoItem{
        return toDoItems[index]
    }
    
    func doneItemAt(index: Int) -> ToDoItem{
        return doneItems[index]
    }
    
    func removeAllItems(){
        toDoItems.removeAll()
        doneItems.removeAll()
    }


}
