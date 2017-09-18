//
//  ItemListDataProviderTests.swift
//  ToDo
//
//  Created by Moi's Mac on 17/9/17.
//  Copyright © 2017 Moi's Mac. All rights reserved.
//

import XCTest

@testable import ToDo

class ItemListDataProviderTests: XCTestCase {
    
    var sut: ItemListDataProvider!
    var tableView: UITableView!
    var controller: ItemListViewController!
    
    override func setUp() {
        super.setUp()
        
        sut = ItemListDataProvider()
        sut.itemManager = ItemManager()
        
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        controller = storyboard.instantiateViewController(withIdentifier: "ItemListViewController") as! ItemListViewController
        
        _ = controller.view
        
        tableView = controller.tableView
        tableView.dataSource = sut
        tableView.delegate = sut
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testNumberOfSections_IsTwo(){
        let numberOfSections = tableView.numberOfSections
        XCTAssertEqual(numberOfSections, 2)
        
    }
    
    func testNumberOfRowsInFirstSection_IsToDoCount(){
        sut.itemManager?.add(item:ToDoItem(title: "First"))
        XCTAssertEqual(tableView.numberOfRows(inSection: 0), 1)
        
        sut.itemManager?.add(item: ToDoItem(title: "Second"))
        
        tableView.reloadData()
        
        XCTAssertEqual(tableView.numberOfRows(inSection: 0), 2)
    }
    
    func testNumberRowsinSecondSection_IsDoneCount(){
        sut.itemManager?.add(item: ToDoItem.init(title: "First"))
        sut.itemManager?.add(item: ToDoItem.init(title: "Second"))
        sut.itemManager?.checkItemAt(index: 0)
        XCTAssertEqual(tableView.numberOfRows(inSection: 1), 1)
        
        sut.itemManager?.checkItemAt(index: 0)
        
        tableView.reloadData()
        
        XCTAssertEqual(tableView.numberOfRows(inSection: 1), 2)
    }
    
    func testCellForRow_ReturnsItemCell(){
        sut.itemManager?.add(item: ToDoItem.init(title: "First"))
        tableView.reloadData()
        
        let cell = tableView.cellForRow(at: IndexPath.init(row: 0, section: 0))
        
        
        XCTAssertTrue(cell is ItemCell)
    }
    
    func testCellForRow_DequeuesCell()
    {
        let mockTableView = MockTableView.mockTableViewWithDataSource(dataSource: sut)
        
        sut.itemManager?.add(item: ToDoItem.init(title: ""))
        mockTableView.reloadData()
        
        _ = mockTableView.cellForRow(at: IndexPath.init(row: 0, section: 0))
        
        XCTAssertTrue(mockTableView.cellGotDequeued)
    }
    
    func testConfigCell_GetsCalledInCellForRow(){
        let mockTableView = MockTableView.mockTableViewWithDataSource(dataSource: sut)
        
        
        let toDoItem = ToDoItem.init(title: "First", itemDescription: "First description")
        sut.itemManager?.add(item: toDoItem)
        mockTableView.reloadData()
        
        let cell = mockTableView.cellForRow(at: IndexPath.init(row: 0, section: 0)) as! MockItemCell
        
        XCTAssertEqual(cell.toDoItem, toDoItem)
    }
    
    func testGetCellsInSectionTwo_GetsConfiguredWithDoneItem(){
        let mockTableView = MockTableView.mockTableViewWithDataSource(dataSource: sut)
        
        
        let firstItem = ToDoItem.init(title: "First", itemDescription: "First description", timestamp: nil, location: nil)
        sut.itemManager?.add(item: firstItem)
        
        
        let secondItem = ToDoItem.init(title: "Second", itemDescription: "Second description", timestamp: nil, location: nil)
        sut.itemManager?.add(item: secondItem)
        
        sut.itemManager?.checkItemAt(index: 1)
        mockTableView.reloadData()
        
        let cell = mockTableView.cellForRow(at: IndexPath.init(row: 0, section: 1)) as! MockItemCell
        
        XCTAssertEqual(cell.toDoItem, secondItem)
    
    }
    
    func testDeletionButtonInFirstSection_ShowsTitleCheck(){
        let deleteButtonTitle = tableView.delegate?.tableView?(tableView, titleForDeleteConfirmationButtonForRowAt: IndexPath.init(row: 0, section: 0))
        
        XCTAssertEqual(deleteButtonTitle, "Check")
    }
    
    func testDeletionButtonInSecondSection_ShowsTitleUncheck(){
        let deleteButtonTitle = tableView.delegate?.tableView?(tableView, titleForDeleteConfirmationButtonForRowAt: IndexPath.init(row: 0, section: 1))
        
        XCTAssertEqual(deleteButtonTitle, "Uncheck")
        
    }
    
    func testCheckingAnItem_ChecksItInTheItemManager(){
    
        sut.itemManager?.add(item: ToDoItem.init(title: "First"))
        
        tableView.dataSource?.tableView?(tableView, commit: .delete, forRowAt: IndexPath.init(row: 0, section: 0))
        
        XCTAssertEqual(sut.itemManager?.toDoCount, 0)
        XCTAssertEqual(sut.itemManager?.doneCount, 1)
        XCTAssertEqual(tableView.numberOfRows(inSection: 0), 0)
        XCTAssertEqual(tableView.numberOfRows(inSection: 1), 1)
    }
    
    func testUncheckingAnItem_UnchecksItInTheItemManager(){
        sut.itemManager?.add(item: ToDoItem.init(title: "First"))
        sut.itemManager?.checkItemAt(index: 0)
        
        tableView.reloadData()
        
        tableView.dataSource?.tableView?(tableView, commit: .delete, forRowAt: IndexPath.init(row: 0, section: 1))
        
        XCTAssertEqual(sut.itemManager?.toDoCount, 1)
        XCTAssertEqual(sut.itemManager?.doneCount, 0)
        XCTAssertEqual(tableView.numberOfRows(inSection: 0), 1)
        XCTAssertEqual(tableView.numberOfRows(inSection: 1), 0)
    }
    
    
    
}

fileprivate class MockTableView: UITableView{
    
    
    var cellGotDequeued = false
    
    override func dequeueReusableCell(withIdentifier identifier: String, for indexPath: IndexPath) -> UITableViewCell {
        
        cellGotDequeued = true
        
        return super.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
    }
    
    class func mockTableViewWithDataSource(dataSource: UITableViewDataSource) -> MockTableView{
        
        let mockTableView = MockTableView(frame: CGRect(x:0, y:0, width: 320, height: 480),style: .plain)
        
        mockTableView.dataSource = dataSource
        mockTableView.register(MockItemCell.self, forCellReuseIdentifier: "ItemCell")
        
        return mockTableView
    }
    
    
    
}

fileprivate class MockItemCell: ItemCell{
    
    var toDoItem: ToDoItem?
    
    override func configCellWith(item: ToDoItem){
        toDoItem = item
    }
}
