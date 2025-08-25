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
