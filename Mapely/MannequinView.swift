//
//  MannequinView.swift
//  Mapely
//
//  Created by 佐保楓 on 2025/06/19.
//

import SwiftUI

struct MannequinView: View {
    @EnvironmentObject var model: Model

        var body: some View {
            ZStack {

                if let dress = getItem("Dress") {
                    dress.image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 120)
                        .offset(y: 0)
                } else {
                    if let top = getItem("Tops") {
                        top.image
                            .resizable()
                            .scaledToFit()
                            .frame(width: 120)
                            .offset(y: -90)
                    }
                    if let bottom = getItem("Bottoms") {
                        bottom.image
                            .resizable()
                            .scaledToFit()
                            .frame(width: 90)
                            .offset(y: 0)
                    }
                }

                if let shoes = getItem("Shoes") {
                    shoes.image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80)
                        .offset(y: 130)
                }

                if let outerwear = getItem("Outerwear") {
                    outerwear.image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100)
                        .offset(x: -110, y: -110)
                }

                if let bag = getItem("Bags") {
                    bag.image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60)
                        .offset(x: 100, y: 20)
                }
                if let jew = getItem("Jewelry") {
                    jew.image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60)
                        .offset(x: 100, y: -90)
                }

                if let acc = getItem("Accessories") {
                    acc.image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60)
                        .offset(x: -110, y: 10)
                }
            }
            .frame(height: 400)
        }

        func getItem(_ category: String) -> ClothingItem? {
            model.selectedClothes.first(where: { $0.category == category })
        }
    }

#Preview {
    MannequinView()
        .environmentObject(Model())
        
}
