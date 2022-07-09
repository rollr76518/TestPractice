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

protocol ViewModelDataProvider {
    func fetchMyMoney(completion: @escaping (Result<Int, Error>) -> Void)
}

final class ViewModel {
    private let dataProvider: ViewModelDataProvider        
    weak var delegate: ViewModelDelegate?
    
    init(dataProvider: ViewModelDataProvider) {
        self.dataProvider = dataProvider
    }
    
    func fetchMyMoney() {
        dataProvider.fetchMyMoney { [self] result in
            switch result {
            case let .success(myMoney):
                delegate?.viewModel(self, didReceiveMoneyAmount: myMoney)
            case let .failure(error):
                delegate?.viewModel(self, didReceiveError: error)
            }
        }
    }
}
