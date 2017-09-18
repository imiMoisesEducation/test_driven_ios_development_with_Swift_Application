//
//  ItemCellTests.swift
//  ToDo
//
//  Created by Moi's Mac on 18/9/17.
//  Copyright © 2017 Moi's Mac. All rights reserved.
//

import XCTest

@testable import ToDo

class ItemCellTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSUT_HasName(){
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "ItemListViewController") as! ItemListViewController
        
        _ = controller.view
    
        let tableView = controller.tableView
        tableView?.dataSource = FakeDataSource()
        
        
        // FIXME: This explodes
        let cell = tableView?.dequeueReusableCell(withIdentifier: "ItemCell", for: IndexPath.init(row: 0, section: 0)) as! ItemCell
        
        
        XCTAssertNotNil(cell.titleLabel)
        
    }
    
    func testSUT_HasLocationLabel(){
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "ItemListViewController") as! ItemListViewController
        
        _ = controller.view
        
        let tableView = controller.tableView
        tableView?.dataSource = FakeDataSource()
        
        // FIXME: This explodes
        let cell = tableView?.dequeueReusableCell(withIdentifier: "ItemCell", for: IndexPath.init(row: 0, section: 1)) as! ItemCell
        
        XCTAssertNotNil(cell.titleLabel)
        
        
    }
    
}

fileprivate class FakeDataSource: NSObject, UITableViewDataSource{

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
}
