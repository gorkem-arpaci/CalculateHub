//
//  ContentView.swift
//  CalculateHub
//
//  Created by Görkem Arpacı on 2.08.2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            VStack {
                CustomToggle()
                MainPageView()
            }

        }
        
    }
}

#Preview {
    ContentView()
        .environmentObject(ThemeManager())
        
}
