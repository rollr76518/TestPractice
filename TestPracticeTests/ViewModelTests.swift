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
        XCTAssertEqual(spy.capturedAmount, 1)
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
        XCTAssertNotNil(spy.capturedError)
    }
}

final class SpyDelegate: ViewModelDelegate {
    private(set) var capturedAmount: Int = 0
    private(set) var capturedError: Error?

    func viewModel(_ vm: ViewModel, didReceiveMoneyAmount amount: Int) {
        capturedAmount = amount
    }
    
    func viewModel(_ vm: ViewModel, didReceiveError error: Error) {
        capturedError = error
    }
}
