//
//  Deneme.swift
//  CalculateHub
//
//  Created by Görkem Arpacı on 14.08.2025.
//

import SwiftUI

struct Deneme: View {
    @EnvironmentObject var themeManager : ThemeManager
    var body: some View {
        Text("Navigate")
            .preferredColorScheme(themeManager.isDarkMode ? .dark : .light)
    }
}

#Preview {
    Deneme()
        .environmentObject(ThemeManager())
}
