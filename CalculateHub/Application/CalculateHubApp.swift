//
//  CalculateHubApp.swift
//  CalculateHub
//
//  Created by Görkem Arpacı on 2.08.2025.
//

import SwiftUI

@main
struct CalculateHubApp: App {
    
    @StateObject private var themeManager = ThemeManager()

    init() {
        loadEnv()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(themeManager)
        }
        .modelContainer(for: ResponseData.self)
        
    }
    
    func loadEnv() {
            if let path = Bundle.main.path(forResource: ".env", ofType: nil) {
                let env = try? String(contentsOfFile: path, encoding: .utf8)
                env?.split(separator: "\n").forEach { line in
                    let parts = line.split(separator: "=", maxSplits: 1)
                    if parts.count == 2 {
                        let key = String(parts[0])
                        let value = String(parts[1])
                        setenv(key, value, 1)
                    }
                }
            }
        }
    
}
