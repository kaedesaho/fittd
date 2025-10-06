//
//  SelectedClothesView.swift
//  Mapely
//
//  Created by 佐保楓 on 2025/06/19.
//

import SwiftUI

struct SelectedClothesView: View {
    @EnvironmentObject var selectionModel: Model
    
    var body: some View {
        ZStack(alignment: .top) {
            VStack {
                MannequinView()
            } // VStack
            .frame(width: 350, height: 350)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.gray, lineWidth: 1))
        } //ZStack
    } // body
} // SelectedClothesView


#Preview {
    SelectedClothesView()
        .environmentObject(Model())
        
}
