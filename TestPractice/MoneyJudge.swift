//
//  MoneyJudge.swift
//  TestPractice
//
//  Created by Ryan on 2022/7/9.
//

import Foundation

struct MoneyJudge {
    enum Level {
        case rich
        case normal
        case poor
    }
    
    func moneyLevel(amount: Int) -> Level {
        switch amount {
        case let value where value > 0:
            return .rich
        case let value where value == 0:
            return .normal
        case let value where value < 0:
            return .poor
        default:
            fatalError("Should not be happened.")
        }
    }
}
