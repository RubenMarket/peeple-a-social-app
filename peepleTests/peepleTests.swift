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
        // 20 + character to empty string
        let longSearch = main.filteredInputStrings(text: "abcdefghijklmnopqrstuvwrstuvxyz")
        XCTAssertEqual(longSearch, "")
        // good input
        let goodSearch = main.filteredInputStrings(text: "ruben-99-thgb")
        XCTAssertEqual(goodSearch, "ruben-99-thgb")
    }
    func databaseSearchTest(){
        // will empty string begin a search.
        
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
