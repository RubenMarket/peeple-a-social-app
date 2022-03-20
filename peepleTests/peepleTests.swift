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
        let invalidString = main.findGroups(text: "")
        let WontBeginAQuery:Bool = false
        XCTAssertEqual(invalidString, WontBeginAQuery)
    }
    
}
