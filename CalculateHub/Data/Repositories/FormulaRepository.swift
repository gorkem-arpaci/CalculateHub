//
//  FormulaRepository.swift
//  CalculateHub
//
//  Created by Görkem Arpacı on 22.08.2025.
//

import Foundation


class FormulaRepository {
    private let apiClient : NetworkService = APIClient()
    
    func calculate<T: Decodable>(formula: FormulaType, requestBody: Encodable) async throws -> T {
        try await withCheckedThrowingContinuation{ continuation in
            apiClient.post(endpoint: formula.endpoint, body: requestBody) { (result: Result<T, Error>) in
                switch result {
                case .success(let dto):
                    continuation.resume(returning: dto)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}
