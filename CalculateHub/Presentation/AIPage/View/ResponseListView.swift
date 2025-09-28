//
//  ResponseListView.swift
//  CalculateHub
//
//  Created by Görkem Arpacı on 25.09.2025.
//

import SwiftUI
import SwiftData

struct ResponseListView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \ResponseData.createdAt, order: .reverse) private var responses: [ResponseData]
    @State private var searchText = ""
    
    var filteredResponses: [ResponseData] {
        if searchText.isEmpty {
            return responses
        } else {
            return responses.filter {
                $0.responseText.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    var body: some View {
        VStack {
            // Search bar
            SearchBar(text: $searchText)
                .padding(.horizontal)
            
            // Liste
            List(filteredResponses, id: \.id) { response in
                NavigationLink(destination: ResponseDetailView(response: response)) {
                    ResponseRowView(response: response)
                }
            }
        }
        .navigationTitle("Geçmiş Yanıtlar")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Menu {
                    Button("Tümünü Sil", role: .destructive) {
                        deleteAllResponses()
                    }
                } label: {
                    Image(systemName: "ellipsis.circle")
                }
            }
        }
    }
    
    private func deleteAllResponses() {
        for response in responses {
            modelContext.delete(response)
        }
        do {
            try modelContext.save()
            print("✅ Tüm yanıtlar silindi.")
        } catch {
            print("❌ Silme hatası: \(error.localizedDescription)")
        }
    }
}

