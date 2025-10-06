//
//  ClothView.swift
//  Mapely
//
//  Created by 佐保楓 on 2025/06/23.
//

import SwiftUI

struct ClothView: View {
    let item: ClothingItem
    @EnvironmentObject var model: Model
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationView{
        ScrollView {
            VStack(spacing: 20) {
                item.image
                    .resizable()
                    .scaledToFit()
                    .frame(height: 300)
                    .cornerRadius(12)

                detailRow("Brand", item.brand)
                detailRow("Category", item.category)
                detailRow("Subcategory", item.subcategory)
                detailRow("Color", item.colorName)
                detailRow("Mood", item.mood)
                detailRow("Season", item.season)
                detailRow("Occasion", item.occasion)
            
                Button(role: .destructive) {
                    model.allClothes.removeAll{$0 == item}
                    dismiss()
                } label: {
                    Text("Delete Cloth")
                                    }
            } // VStack
            .padding()
        } // ScrollView
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink(destination: UploadView(itemToEdit: item)) {
                    Image(systemName: "pencil")
                        .padding()
                }
            }
            }
        }
    } // body

    func detailRow(_ title: String, _ value: String) -> some View {
            HStack {
                Text("\(title):")
                    .bold()
                Spacer()
                Text(value)
                    .bold()
            }
            .padding(.horizontal)
        }
}

#Preview {
    ClothView(item: ClothingItem(
            imageData: Data(), // empty image
            category: "Outerwear",
            subcategory: "Coat",
            colorName: "Beige",
            mood: "Elegant",
            season: "Winter",
            occasion: "Formal",
            brand: "Burberry"
        ))
}
