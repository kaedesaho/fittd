//
//  Constants.swift
//  Fittd
//
//  Created by 佐保楓 on 2025/06/19.
//

import Foundation
import SwiftUI


let categoryData: [String: [String]] = [
    "Tops": ["T-Shirt", "Tank Top", "Blouse", "Sweater"],
    "Bottoms": ["Jeans", "Skirt", "Shorts"],
    "Dress": ["Mini Dress", "Maxi Dress"],
    "Outerwear": ["Jacket", "Coat", "Cardigan"],
    "Shoes": ["Sneakers", "Boots", "Sandals", "Heels"],
    "Bags": ["Handbag", "Backpack", "Wallet"],
    "Accessories": ["Hats", "Gloves", "Belt"],
    "Jewelry": ["Necklace", "Bracelet", "Earrings"]
]
let categoryOrder = ["Tops", "Bottoms", "Dress", "Outerwear", "Shoes", "Bags", "Accessories", "Jewelry"]


let colorOptions: [String] = ["blue", "red", "green", "yellow", "black", "white", "pink", "brown", "orange", "purple", "beige", "navy", "skyblue", "ivory"]
let moods: [String] = ["Cute", "Casual", "Elegant", "Preppy"]
let seasons: [String] = ["Spring", "Summer", "Fall", "Winter"]
let occasions: [String] = ["Daily", "School", "Work", "Date", "Party", "Travel"]

// Convert color name string to SwiftUI Color
func colorFromName(_ name: String) -> Color {
    switch name.lowercased() {
    case "blue": return .blue
    case "red": return .red
    case "green": return .green
    case "yellow": return .yellow
    case "black": return .black
    case "white": return .white
    case "pink": return .pink
    case "brown": return .brown
    case "orange": return .orange
    case "purple": return .purple
    case "beige": return Color(red: 245/255, green: 245/255, blue: 220/255) 
    case "navy": return Color(red: 0/255, green: 0/255, blue: 128/255)
    case "skyblue": return Color(red: 135/255, green: 206/255, blue: 235/255)
    case "ivory": return Color(red: 255/255, green: 255/255, blue: 240/255)
 
        
    default: return .gray
    }
}

struct ColorPalettes {
    static let navy = Color(red: 0.00, green: 0.12, blue: 0.33)
    static let ivory = Color(red: 1.00, green: 1.00, blue: 0.94)
    static let gold = Color(red: 0.83, green: 0.69, blue: 0.22)
    static let brown = Color(red: 0.36, green: 0.25, blue: 0.20)
    static let darkGray = Color(red: 0.29, green: 0.29, blue: 0.29)
}
