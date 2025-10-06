//
//  CategoryView.swift
//  Mapely
//
//  Created by 佐保楓 on 2025/06/12.
//

import SwiftUI


struct CategoryView: View {
    @EnvironmentObject var model: Model

    var body: some View {
        SelectedClothesView()
            .padding()
                        
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                    ForEach(categoryOrder, id: \.self) { category in
                        NavigationLink(destination: ClothingSelectorView(category:category)) {
                            Text(category)
                                .padding()
                                .frame(maxWidth: 300)
                                .bold()
                                .foregroundColor(.white)
                                .background(Color.gray)
                                .cornerRadius(10)
                        }
                    }
                }
                .frame(maxWidth: 300)
            } // ScrollView
                
        } // NavigationView
        .padding()
        
        
    } // BodyView
} // CategoryView

    

#Preview {
    CategoryView()
        .environmentObject(Model())
}
