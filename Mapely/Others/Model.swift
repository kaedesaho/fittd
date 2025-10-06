//
//  Model.swift
//  Mapely
//
//  Created by 佐保楓 on 2025/06/19.
//

import Foundation
import SwiftUI

class Model: ObservableObject {
    @Published var allClothes: [ClothingItem] = []
    @Published var selectedClothes: [ClothingItem] = []
}
