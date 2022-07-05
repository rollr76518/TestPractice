//
//  APIClient.swift
//  TestPractice
//
//  Created by Ryan on 2022/7/5.
//

import Foundation

struct APIClient {
    func fetchMyMoney(completion: @escaping (Result<Int, Error>) -> Void) {
        completion(.success(Int.random(in: -100...100)))
    }
}
