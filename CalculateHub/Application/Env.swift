//
//  Env.swift
//  CalculateHub
//
//  Created by Görkem Arpacı on 2.09.2025.
//

import Foundation

enum Env {
    static var huggingFaceApiKey: String {
        return ProcessInfo.processInfo.environment["HUGGINGFACE_API_KEY"] ?? ""
    }
    
    static var openRouterApiKey: String {
        return ProcessInfo.processInfo.environment["OPENROUTER_API_KEY"] ?? ""
        
    }
}

