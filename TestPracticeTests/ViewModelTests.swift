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
        let dataProvider = FakeDataProvider(result: .success(0))
        let sut = ViewModel(dataProvider: dataProvider)
        
        // Action
        
        // Assertion
        XCTAssertNotNil(sut)
    }
    
    func testFetchSuccess() {
        // Arrange
        let dataProvider = FakeDataProvider(result: .success(1))
        let sut = ViewModel(dataProvider: dataProvider)
        let spy = SpyDelegate()
        sut.delegate = spy
        
        // Action
        sut.fetchMyMoney()
        
        // Assertion
        XCTAssertEqual(spy.capturedAmount, 1)
    }
    
    func testFetchFailure() {
        // Arrange
        let dataProvider = FakeDataProvider(result: .failure(NSError(domain: "", code: 0)))
        let sut = ViewModel(dataProvider: dataProvider)
        let spy = SpyDelegate()
        sut.delegate = spy
        
        // Action
        sut.fetchMyMoney()
        
        // Assertion
        XCTAssertNotNil(spy.capturedError)
    }
}

final class FakeDataProvider: ViewModelDataProvider {
    private let result: Result<Int, Error>
    
    init(result: Result<Int, Error>) {
        self.result = result
    }
    
    func fetchMyMoney(completion: @escaping (Result<Int, Error>) -> Void) {
        completion(result)
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
