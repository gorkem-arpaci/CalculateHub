//
//  NetworkResponseDTO.swift
//  CalculateHub
//
//  Created by Görkem Arpacı on 22.08.2025.
//

import Foundation


struct IterationResponseDTO: Decodable {
    let iteration: String
    let root: String
}

struct ToBinaryResponseDTO: Decodable {
    let root: String
}

