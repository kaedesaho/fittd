//
//  ClothingSelectorView.swift
//  Fittd
//
//  Created by 佐保楓 on 2025/06/19.
//

import SwiftUI



struct ClothingSelectorView: View {
    @EnvironmentObject var model: Model
    @State private var selectedSubCategory = ""
    @State private var selectedColorName = ""
    @State private var currentIndex = 0
    @Environment(\.dismiss) var dismiss
    
    let category: String
    
    var allItems: [ClothingItem] {
        model.allClothes.filter { $0.category == category }
    }
    
    
    var filteredItems: [ClothingItem] {
        allItems.filter {
            (selectedSubCategory.isEmpty || $0.subcategory == selectedSubCategory) &&
            (selectedColorName.isEmpty || $0.colorName == selectedColorName)
            &&
            !blacklist.contains($0.id)
        }
    }
    var currentItem: ClothingItem? {
        guard !filteredItems.isEmpty else { return nil }
        return filteredItems[currentIndex % filteredItems.count]
    }
    @State private var blacklist: Set<UUID> = []
    
    
    
    var body: some View {
       SelectedClothesView()
            .padding()
         
            VStack {
                HStack {
                    Menu {
                        ForEach(categoryData[category] ?? [], id: \.self) {sub in
                            Button(sub) { selectedSubCategory = sub }
                        }
                    } label: {
                        Label(selectedSubCategory.isEmpty ? "Choose Type" : selectedSubCategory, systemImage: "chevron.down")
                    }
                    Menu {
                        ForEach(colorOptions, id: \.self) { color in
                            Button(color) { selectedColorName = color }
                        }
                    } label: {
                        Label(selectedColorName.capitalized, systemImage: "paintpalette")
                            .frame(width: 120)
                    }
                } // HStack
                
                VStack (spacing: 20){
                    if let item = currentItem {
                        HStack {
                            Button("xmark") {
                                blacklist.insert(item.id)
                                moveToNext()
                            }
                            .disabled(filteredItems.isEmpty)
                            
                            Spacer()
                            
                            Button("checkmark") {
                                if let existingIndex = model.selectedClothes.firstIndex(where: { $0.category == item.category }) {
                                    let oldItem = model.selectedClothes[existingIndex]
                                            model.selectedClothes.remove(at: existingIndex)
                                            blacklist.remove(oldItem.id)
                                        } else {
                                            model.selectedClothes.append(item)
                                            blacklist.insert(item.id)
                                        }
                                moveToNext()
                            } // Button
                            .disabled(filteredItems.isEmpty)
                        } // HStack
                        .padding(.horizontal)
                        
                        HStack {
                            Button("arrowtriangle.left.fill") {
                                currentIndex = (currentIndex - 1 + filteredItems.count) % filteredItems.count
                            }

                            if let item = currentItem,
                                let uiImage = UIImage(data: item.imageData) {
                                    Image(uiImage: uiImage)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 250, height: 200)
                                        .clipShape(RoundedRectangle(cornerRadius: 8))
                                }

                            Spacer()
                            Button("arrowtriangle.right.fill") {
                                currentIndex = (currentIndex + 1) % filteredItems.count
                            }
                        } // HStack
                        .padding(.horizontal)
                    } // if
                    
                    else {Text("No matching items")
                    } // else
                } // VStack
                .frame(width: 350, height: 300)
                .background(RoundedRectangle(cornerRadius: 10).stroke(Color.gray))
            } //VStack
    } // bodyView
    
    func moveToNext() {
        if filteredItems.isEmpty {
            currentIndex = 0
        } else {
            currentIndex = (currentIndex + 1) % filteredItems.count
        } // else
    } // move Next
} // ClothingSelectorView


#Preview {
    ClothingSelectorView(category: "Tops")
        .environmentObject(Model())
}
