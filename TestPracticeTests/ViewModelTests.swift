//
//  ViewModelTests.swift
//  TestPracticeTests
//
//  Created by Ryan on 2022/7/9.
//

import XCTest
@testable import TestPractice

class ViewModelTests: XCTestCase {

    func testInitAndNotNil() {
        // Arrange
        let sut = ViewModel(dataProvider: { provider in
            provider(.success(0))
        })
        
        // Action
        
        // Assertion
        XCTAssertNotNil(sut)
    }
    
    func testFetchSuccess() {
        // Arrange
        let sut = ViewModel(dataProvider: { provider in
            provider(.success(1))
        })

        let spy = SpyDelegate()
        sut.delegate = spy
        
        // Action
        sut.fetchMyMoney()
        
        // Assertion
        XCTAssertEqual(spy.capturedAmounts, [1])
        XCTAssertTrue(spy.capturedErrors.isEmpty)
    }
    
    func testFetchFailure() {
        // Arrange
        let sut = ViewModel(dataProvider: { provider in
            provider(.failure(NSError(domain: "", code: 0)))
        })

        let spy = SpyDelegate()
        sut.delegate = spy
        
        // Action
        sut.fetchMyMoney()
        
        // Assertion
        XCTAssertEqual(spy.capturedAmounts, [])
        XCTAssertNotNil(spy.capturedErrors.first)
    }
}

final class SpyDelegate: ViewModelDelegate {
    private(set) var capturedAmounts: [Int] = []
    private(set) var capturedErrors: [Error] = []

    func viewModel(_ vm: ViewModel, didReceiveMoneyAmount amount: Int) {
        capturedAmounts.append(amount)
    }
    
    func viewModel(_ vm: ViewModel, didReceiveError error: Error) {
        capturedErrors.append(error)
    }
}
