//
//  CollegeFunctions.swift
//  CalculateHub
//
//  Created by Görkem Arpacı on 11.08.2025.
//

import SwiftUI

struct CollegeFunctionsPage: View {

    let functions = FormulaType.allCases
    @Binding var path: [String]
    @Binding var isDetailPage: Bool

    let columns = [
        GridItem(.flexible()),  // 1. sütun
        GridItem(.flexible()),  // 2. sütun
        GridItem(.flexible()),  // 3. sütun
    ]

    var body: some View {
         
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(functions, id: \.self) { function in
                        Button(action: {path.append(function.title)
                        }) {
                            Text(function.title)
                                .font(Font.custom("WorkSans", size: 16))
                                .fontWeight(.regular)
                                .foregroundColor(.primary)
                                .frame(width: 117, height: 117)
                                .background(
                                    .indigo,
                                    in: RoundedRectangle(cornerRadius: 24)
                                )
                        }

                    }
                }
            
        }

    }
}



#Preview {
    CollegeFunctionsPage(path: .constant([""]), isDetailPage: .constant(true))
}
