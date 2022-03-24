//
//  peepleTests.swift
//  peepleTests
//
//  Created by admin on 3/15/22.
//  Copyright © 2022 A Sirius Company. All rights reserved.
//

import XCTest
@testable import People

class peepleTests: XCTestCase {

    var main:MainPage!
    
    
    //textField check comes first
    func textFieldInputConstraints(){
        let emptySearch = main.filteredInputStrings(text: "")
        XCTAssertEqual(emptySearch, "")
        // 20 - 43 character is good string
        let goodText:String = "abcdefghijklmnopqrstuvwrstuvxyz"
        XCTAssertEqual(goodText.count, 28)
        
        let goodSearch = main.filteredInputStrings(text: goodText )
        XCTAssertEqual(goodSearch, goodText)
        // good input
        let shortSearch = main.filteredInputStrings(text: "ruben-99-thgb")
        XCTAssertEqual(shortSearch, "")
        
        let longText:String = "abcdefghijklmnopqrstuvwrstuvxyzabcdefghijklmnopqrstuvwrstuvxyz"
        let longSearch = main.filteredInputStrings(text: longText)
        XCTAssertEqual(longSearch, "")
    }
    
    func databaseSearchTest(){
        // check if empty string begins a database query.
        
        //group query
        let invalidGString = main.findGroups(text: "")
        let WontBeginAGQuery:Bool = false
        XCTAssertEqual(invalidGString, WontBeginAGQuery)
        //people query
        let invalidPString = main.findPeople(text: "")
        let WontBeginAPQuery:Bool = false
        XCTAssertEqual(invalidPString, WontBeginAPQuery)
    }
    

}
