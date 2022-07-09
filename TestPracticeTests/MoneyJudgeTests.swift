//
//  MoneyJudgeTests.swift
//  TestPracticeTests
//
//  Created by Ryan on 2022/7/9.
//

import XCTest
@testable import TestPractice

class MoneyJudgeTests: XCTestCase {

    func testInitAndSuccess() {
        // Arrange
        let sut = MoneyJudge()
        
        // Action
        
        // Assert
        XCTAssertNotNil(sut)
    }

    func test1AndGetRich() {
        // Arrange
        let sut = MoneyJudge()
        
        // Action
        let result = sut.moneyLevel(amount: 1)
        
        // Assert
        XCTAssertEqual(result, .rich)
    }
    
    func test0AndGetNormal() {
        // Arrange
        let sut = MoneyJudge()
        
        // Action
        let result = sut.moneyLevel(amount: 0)
        
        // Assert
        XCTAssertEqual(result, .normal)
    }
    
    func testminus1AndGetPoor() {
        // Arrange
        let sut = MoneyJudge()
        
        // Action
        let result = sut.moneyLevel(amount: -1)
        
        // Assert
        XCTAssertEqual(result, .poor)
    }
    
    func testInifiteNumberAndGetRich() {
        // Arrange
        let sut = MoneyJudge()
        
        // Action
        let result = sut.moneyLevel(amount: .max)
        
        // Assert
        XCTAssertEqual(result, .rich)
    }
}
