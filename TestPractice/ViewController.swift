//
//  ViewController.swift
//  TestPractice
//
//  Created by Ryan on 2022/7/5.
//

import UIKit

class ViewController: UIViewController {
    private lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(label)
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        APIClient().fetchMyMoney { [self] result in
            switch result {
            case let .success(myMoney):
                label.textColor = MoneyJudge().moneyLevel(amount: myMoney).color
                label.text = "My money is \(myMoney)"
            case let .failure(error):
                label.textColor = .black
                label.text = "Error is \(error)"
            }
        }
    }
}

extension MoneyJudge.Level {
    var color: UIColor {
        switch self {
        case .rich: return .red
        case .normal: return .black
        case .poor: return .green
        }
    }
}
