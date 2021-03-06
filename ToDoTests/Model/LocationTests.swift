//
//  LocationTests.swift
//  ToDo
//
//  Created by Moi's Mac on 17/9/17.
//  Copyright © 2017 Moi's Mac. All rights reserved.
//

import XCTest

@testable import ToDo
import CoreLocation
class LocationTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testInit_ShouldSetName(){
        let location = Location(name: "Test name")
        XCTAssertEqual(location.name, "Test name", "Initializer should set the name")
    }
    
    func testInit_ShoildSetNameAndCoordinate(){
        let testCoordinate = CLLocationCoordinate2D(latitude: 1, longitude: 2)
        let location = Location(name: "", coordinate: testCoordinate)
        
        XCTAssertEqual(location.coordinate?.latitude, testCoordinate.latitude,"Initializer should set latitude")
        
        XCTAssertEqual(location.coordinate?.longitude, testCoordinate.longitude, "Initializer should set longitude")
    }
    
    func testEqualLocations_ShouldBeEqual(){
        let firstLocation = Location(name: "Home")
        let secondLocation = Location(name: "Home")
        
        XCTAssertEqual(firstLocation, secondLocation)
    }
    
    func testWhenLatitudeDifferes_ShouldBeNotEqual(){
        performNotEqualTestWithLocationProperties(firstName: "Home", secondName: "Home", firstLongLat: (1.0,0.0), secondLongLat: (0.0,0.0))
    }
    
    func testWhenLogitudeDifferes_ShouldBeNotEqual(){
        performNotEqualTestWithLocationProperties(firstName: "Home", secondName: "Home", firstLongLat: (0.0,1.0), secondLongLat: (1.0,0.0))
    }
    
    func testWhenNameDifferes_ShouldBeNotEqual(){
        performNotEqualTestWithLocationProperties(firstName: "Home", secondName: "Office", firstLongLat: nil, secondLongLat: nil)
    }
    
}





fileprivate func performNotEqualTestWithLocationProperties(firstName: String, secondName:String, firstLongLat: (Double,Double)?, secondLongLat: (Double,Double)?, line: UInt = #line){
    
    let firstCoord: CLLocationCoordinate2D?
    
    if let firstLongLat = firstLongLat{
        firstCoord = CLLocationCoordinate2D(
            latitude: firstLongLat.0,
            longitude: firstLongLat.1
        )
    } else {
        firstCoord = nil
    }
    
    let firstLocation = Location(name: firstName, coordinate: firstCoord)
    
    let secondCoord: CLLocationCoordinate2D?
    
    if let secondLongLat = secondLongLat {
        secondCoord = CLLocationCoordinate2D(
            latitude: secondLongLat.0,
            longitude: secondLongLat.1
        )
    } else {
        secondCoord = nil
    }
    
    let secondLocation = Location(name: secondName, coordinate: secondCoord)
    
    XCTAssertNotEqual(firstLocation, secondLocation, line: line)
}












