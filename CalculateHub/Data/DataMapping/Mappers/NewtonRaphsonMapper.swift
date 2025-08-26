//
//  NewtonRaphsonMapper.swift
//  CalculateHub
//
//  Created by Görkem Arpacı on 22.08.2025.
//

import Foundation

extension IterationResponseDTO {
    func toDomain() -> RootFindingResult {
        return RootFindingResult(result: result)
    }
}

//extension NewtonRaphsonResponseDTO {
//    func toDomain() -> RootFindingResult {
//        return RootFindingResult(result: result)
//    }
//}
//
//extension GradientDescentResponseDTO {
//    func toDomain() -> RootFindingResult {
//        return RootFindingResult(result: result)
//    }
//}
//
//extension SafeGuardedResponseDTO {
//    func toDomain() -> RootFindingResult {
//        return RootFindingResult(result: result)
//    }
//}
//
//extension ConjugateResponseDTO {
//    func toDomain() -> RootFindingResult {
//        return RootFindingResult(result: result)
//    }
//}
