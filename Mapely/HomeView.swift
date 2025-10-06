//
//  HomeView.swift
//  Mapely
//
//  Created by 佐保楓 on 2025/06/12.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var model: Model
    
    var body: some View {
        VStack{
            Text("Today's Outfit")
                .font(.title2)
                .bold()
                .padding(.top, 40)
            SelectedClothesView()
            
            NavigationView{
                VStack{
                    NavigationLink(destination: CategoryView()){
                        Text("Style by Myself")
                            .styledButton()
                    } // CategoryView
                    
                    NavigationLink(destination: OptionView()){
                        Text("Style for Me")
                            .styledButton()
                    } // OptionView
                    
                } // VStack Link
                .frame(height: 300)
            } // NavigationView
        } // Vstack
    } // body
} // HomeView

extension View {
    func styledButton() -> some View {
        self
            .padding()
            .frame(maxWidth: 200)
            .bold()
            .foregroundColor(.white)
            .background(.gray)
            .cornerRadius(10)
            .padding(.bottom, 20)
    }
}

#Preview {
    HomeView()
        .environmentObject(Model())
}
