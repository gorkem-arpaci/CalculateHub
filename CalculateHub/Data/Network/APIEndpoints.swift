//
//  APIEndpoints.swift
//  CalculateHub
//
//  Created by Görkem Arpacı on 22.08.2025.
//

import Foundation


enum APIEndpoint: String {
    case newtonRaphson = "newton-raphson"
    case safeguarded = "safeguarded"
    case bisection = "bisection"
    case conjugate = "conjugate"
    case gradientDecent = "gradient-decent"
    case secant = "secant"
    case toBinary = "to-binary"
    
    static let baseURL = "http://127.0.0.1:5000/"
    
    var url: String {
        return APIEndpoint.baseURL + self.rawValue
    }
}
