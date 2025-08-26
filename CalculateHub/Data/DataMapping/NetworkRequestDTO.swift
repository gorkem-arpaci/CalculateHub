//
//  NetworkResponseDTO.swift
//  CalculateHub
//
//  Created by Görkem Arpacı on 21.08.2025.
//

import Foundation


struct NewtonRapshonRequestDTO: Encodable {
    let x_0: String
    let func_input: String
}


struct GradientDescentRequestDTO: Encodable {
    let x_0: String
    let func_input: String
    let alpha: String
}

struct SafeGuardedRequestDTO: Encodable {
    let x_0: String
    let func_input: String
}

struct ConjugateRequestDTO: Encodable {
    let func_input: String
    let nums: String
}

struct SecantRequestDTO: Encodable {
    let x_0: String
    let x_1: String
    let func_input: String
}

struct BisectionRequestDTO: Encodable {
    let a: String
    let b: String
    let func_input: String
}
