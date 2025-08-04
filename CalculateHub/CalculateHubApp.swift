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

    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(themeManager)
        }
        
    }
    
    }
