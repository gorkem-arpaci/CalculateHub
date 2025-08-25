//
//  NewtonRaphsonMapper.swift
//  CalculateHub
//
//  Created by Görkem Arpacı on 22.08.2025.
//

import Foundation

extension NewtonRaphsonResponseDTO {
    func toDomain() -> RootFindingResult {
        return RootFindingResult(result: result)
    }
}

extension GradientDescentResponseDTO {
    func toDomain() -> RootFindingResult {
        return RootFindingResult(result: result)
    }
}
