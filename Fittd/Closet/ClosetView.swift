//
//  ClosetView.swift
//  Fittd
//
//  Created by 佐保楓 on 2025/06/18.
//

import SwiftUI

struct ClosetView: View {
    @EnvironmentObject var model: Model
    let columns = [GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(model.allClothes, id: \.id) { item in
                        NavigationLink(destination: ClothView(item: item)) {
                            VStack {
                                item.image
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 150)
                                    .cornerRadius(10)
                                
                            }
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(10)
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("My Closet")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: UploadView()) {
                        Image(systemName: "plus")
                            .imageScale(.large)
                            .padding()
                    } // NavigationLink
                } // ToolBar
                
            }
        }
    } // body
} // ClosetView

#Preview {
    ClosetView()
        .environmentObject(Model())
        
}
