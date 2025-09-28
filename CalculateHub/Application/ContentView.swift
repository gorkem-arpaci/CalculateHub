//
//  ContentView.swift
//  CalculateHub
//
//  Created by Görkem Arpacı on 2.08.2025.
//

import SwiftUI

struct ContentView: View {
    @State private var number: Int = 0
    @State private var isDetailPage: Bool = false
    @State private var path: [String] = []

    var body: some View {
        NavigationStack(path: $path) {
            ZStack {
                VStack(spacing: 30) {
                    VStack {
                        if !isDetailPage {
                            TabViewPage(selectedIndex: $number)
                            CustomToggle()
                            
                        }
                        
                    }
                    switch number {
                    case 0:
                        MainPageView()
                    case 1:
                        CollegeFunctionsPage(
                            path: $path,
                            isDetailPage: $isDetailPage
                        )
                    case 2:
                        AIPage()
                    default:
                        MainPageView()
                    }
                    
                }
            }
            .onChange(of: path) { oldPath, newPath in
                isDetailPage = !newPath.isEmpty
            }
            .navigationDestination(for: String.self) { functionName in
                FunctionDetail(path: $path)
                
            }
            
        }
    }
}

#Preview {
    
        ContentView()
            .modelContainer(for: [ResponseData.self])
            .environmentObject(ThemeManager())
}
