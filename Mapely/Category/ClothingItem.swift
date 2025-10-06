//
//  ClothingItem.swift
//  Mapely
//
//  Created by 佐保楓 on 2025/06/19.
//

import Foundation
import SwiftUI

struct ClothingItem: Identifiable, Equatable {
    let id = UUID()
    let imageData: Data
    let category: String
    let subcategory: String
    let colorName: String
    let mood: String
    let season: String
    let occasion: String
    let brand: String
        
    var image: Image {
        if let uiImage = UIImage(data: imageData) {
            return Image(uiImage: uiImage)
        } else {
            return Image(systemName: "photo")
        }
    }
    static func == (lhs: ClothingItem, rhs: ClothingItem) -> Bool {
        lhs.id == rhs.id
    }
}
