//
//  ViewModel.swift
//  TestPractice
//
//  Created by Ryan on 2022/7/9.
//

import Foundation

protocol ViewModelDelegate: AnyObject {
    func viewModel(_ vm: ViewModel, didReceiveMoneyAmount amount: Int)
    func viewModel(_ vm: ViewModel, didReceiveError error: Error)
}

final class ViewModel {
    typealias ViewModelDataProvider = (@escaping (Result<Int, Error>) -> Void) -> Void
    private let dataProvider: ViewModelDataProvider        
    weak var delegate: ViewModelDelegate?
    
    init(dataProvider: @escaping ViewModelDataProvider) {
        self.dataProvider = dataProvider
    }

    func fetchMyMoney() {
        dataProvider { [self] result in
            switch result {
            case let .success(myMoney):
                delegate?.viewModel(self, didReceiveMoneyAmount: myMoney)
            case let .failure(error):
                delegate?.viewModel(self, didReceiveError: error)
            }
        }
    }
}

