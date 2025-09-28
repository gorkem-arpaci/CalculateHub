//
//  NewtonRaphsonMapper.swift
//  CalculateHub
//
//  Created by Görkem Arpacı on 22.08.2025.
//

import Foundation

extension IterationResponseDTO {
    func toDomain() -> RootFindingResult {
        return RootFindingResult(iteration: iteration, root: root)
    }
    
    
}

extension ToBinaryResponseDTO {
    func toBinaryDomain() -> BinaryFindindResult {
        return BinaryFindindResult(root: root)
    }
}
