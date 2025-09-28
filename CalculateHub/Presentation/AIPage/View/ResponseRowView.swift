//
//  ResponseRowView.swift
//  CalculateHub
//
//  Created by Görkem Arpacı on 25.09.2025.
//

import SwiftUI

struct ResponseRowView: View {
    let response: ResponseData
    
    var body: some View {
        HStack(spacing: 12) {
            // Thumbnail
            if let image = response.uiImage {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 60, height: 60)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            } else {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 60, height: 60)
                    .overlay {
                        Image(systemName: "photo")
                            .foregroundColor(.gray)
                    }
            }
            
            VStack(alignment: .leading, spacing: 4) {
                // Yanıtın başlangıcı
                Text(getResponseTitle(response.responseText))
                    .font(.headline)
                    .lineLimit(2)
                // Kaynak ve tarih
                HStack {
                    Label(response.imageSource.capitalized, systemImage: response.imageSource == "camera" ? "camera" : "photo")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    Spacer()
                    
                    Text(response.createdAt.formatted(.relative(presentation: .named)))
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                
                // Yanıt önizlemesi
                Text(response.responseText.prefix(100) + (response.responseText.count > 100 ? "..." : ""))
                    .font(.caption)
                    .foregroundStyle(.tertiary)
                    .lineLimit(2)
            }
            
            Spacer()
        }
        .padding(.vertical, 4)
    }
    
    private func getResponseTitle(_ text: String) -> String {
        let words = text.components(separatedBy: .whitespacesAndNewlines)
            .filter { !$0.isEmpty }
            .prefix(5)
        
        if words.isEmpty {
            return "Boş Yanıt"
        }
        
        return words.joined(separator: " ") + (words.count >= 5 ? "..." : "")
    }
}


