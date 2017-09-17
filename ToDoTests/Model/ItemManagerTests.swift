//
//  ItemManagerTests.swift
//  ToDo
//
//  Created by Moi's Mac on 17/9/17.
//  Copyright © 2017 Moi's Mac. All rights reserved.
//

import XCTest

@testable import ToDo

class ItemManagerTests: XCTestCase {
    
    var sut: ItemManager!
    
    override func setUp() {
        super.setUp()
        sut = ItemManager()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testToDoCount_Initially_ShouldBeZero(){
        XCTAssertEqual(sut.toDoCount, 0, "Initially toDo count should be 0")
    }
    
    func testDoneCount_Initially_ShouldBeZero(){
        XCTAssertEqual(sut.doneCount, 0,"Initially done count should be 0")
    }
    
    func testToDoCount_AfterAddingOneItem_IsOne(){
        sut.add(item: ToDoItem(title: "Test title"))
    }
    
    func testItemAtIndex_ShouldReturnPreviouslyAddItem(){
        let item = ToDoItem(title: "Item")
        sut.add(item: item)
        let returnedItem = sut.itemAt(index: 0)
        XCTAssertEqual(item.title, returnedItem.title, "Should be the same item")
    }
    
    func testCheckingItem_ChangesCountOfToDoAndOfDoneItems(){
        sut.add(item: ToDoItem(title: "First Item"))
        sut.checkItemAt(index: 0)
        
        XCTAssertEqual(sut.toDoCount, 0, "toDoCount should be 0")
        XCTAssertEqual(sut.doneCount, 1, "doneCount should be 1")
    }
    
    func testCheckingItem_RemovesItFromTheToDoItemList(){
        let firstItem = ToDoItem(title: "First")
        let secondItem = ToDoItem(title: "Second")
        
        
        sut.add(item: firstItem)
        sut.add(item: secondItem)
        
        sut.checkItemAt(index: 0)
        
        XCTAssertEqual(sut.itemAt(index: 0).title, secondItem.title)
        
        
    }
    
    func testDoneItemAtIndex_ShouldReturnPreviouslyChecketItem(){
        let item = ToDoItem(title: "Item")
        sut.add(item: item)
        sut.checkItemAt(index: 0)
        
        let returnedItem = sut.doneItemAt(index:0)
        
        XCTAssertEqual(item.title, returnedItem.title, "Should be the same item")
    }
    
    func testEqualItems_ShouldBeEqual(){
        let firstItem = ToDoItem(title: "First")
        let secondItem = ToDoItem(title: "First")
        
        XCTAssertEqual(firstItem, secondItem,"Items should be equal")
    }
    
    func testWhenLocationDifferes_ShouldBeNotEqual(){
        let firstItem = ToDoItem(
            title: "First title",
            itemDescription:"First description",
            timestamp: 0.0,
            location: Location(name:"Home")
        )
        
        let secondItem = ToDoItem(
            title: "First title",
            itemDescription: "First description",
            timestamp: 0.0,
            location: Location(name:"Office")
        )
        
        XCTAssertNotEqual(firstItem, secondItem,"Locations should not be equal")
    }
    
}
