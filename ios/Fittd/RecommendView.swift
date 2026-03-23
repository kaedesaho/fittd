//
//  RecommendView.swift
//  Fittd
//
//  Created by 佐保楓 on 2025/10/17.
//

import SwiftUI
/*
struct RecommendView: View {
    @EnvironmentObject var model: Model
        
        let item: ClothingItem
        @State private var userMood: String = "Casual"
        @State private var userOccasion: String = "School"
        @State private var currentSeason: String = "Summer"
        
        @State private var blacklist: Set<UUID> = []
        @State private var currentIndex: Int = 0
        
        // Computed property for filtered items based on mood, occasion, season, and blacklist
        var filteredItems: [ClothingItem] {
            wardrobe.filter { item in
                item.mood == userMood &&
                item.season == currentSeason &&
                item.occasion.contains(userOccasion) &&
                !blacklist.contains(item.id)
            }
        }
        
        // Current recommended item
        var recommendedItem: ClothingItem? {
            guard !filteredItems.isEmpty else { return nil }
            return filteredItems[currentIndex % filteredItems.count]
        }
    var body: some View {
        VStack(spacing: 20) {
                    
                    if let item = recommendedItem {
                        
                        // ✅ Top HStack: Reject / Accept buttons
                        HStack {
                            Button(action: {
                                blacklist.insert(item.id)
                                moveToNext()
                            }) {
                                Image(systemName: "xmark")
                            }
                            .disabled(filteredItems.isEmpty)
                            
                            Spacer()
                            
                            Button(action: {
                                if let existingIndex = model.selectedClothes.firstIndex(where: { $0.category == item.category }) {
                                    let oldItem = model.selectedClothes[existingIndex]
                                    model.selectedClothes.remove(at: existingIndex)
                                    blacklist.remove(oldItem.id)
                                } else {
                                    model.selectedClothes.append(item)
                                    blacklist.insert(item.id)
                                }
                                moveToNext()
                            }) {
                                Image(systemName: "checkmark")
                            }
                            .disabled(filteredItems.isEmpty)
                        }
                        .padding(.horizontal)
                        
                        // ✅ Middle: Mannequin + navigation arrows
                        HStack {
                            Button(action: {
                                currentIndex = (currentIndex - 1 + filteredItems.count) % filteredItems.count
                            }) {
                                Image(systemName: "arrowtriangle.left.fill")
                            }
                            
                            Spacer()
                            
                            MannequinView() // pass current item to mannequin
                            
                            Spacer()
                            
                            Button(action: {
                                currentIndex = (currentIndex + 1) % filteredItems.count
                            }) {
                                Image(systemName: "arrowtriangle.right.fill")
                            }
                        }
                        .padding(.horizontal)
                        
                    } else {
                        Text("No matching items")
                            .foregroundColor(.gray)
                    }
                    
                }
                .frame(width: 350, height: 300)
                .background(RoundedRectangle(cornerRadius: 10).stroke(Color.gray))
            }
            
            // Move to next item safely
            func moveToNext() {
                if filteredItems.isEmpty {
                    currentIndex = 0
                } else {
                    currentIndex = (currentIndex + 1) % filteredItems.count
                }
            }
        }

#Preview {
    RecommendView(item: ClothingItem(
        imageData: Data(), // empty image
        category: "Outerwear",
        subcategory: "Coat",
        colorName: "Beige",
        mood: "Elegant",
        season: "Winter",
        occasion: "Formal",
        brand: "Burberry"
    ))
        .environmentObject(Model())
        
}
 */
