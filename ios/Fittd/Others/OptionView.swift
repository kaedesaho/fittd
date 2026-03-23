//
//  OptionView.swift
//  Fittd
//
//  Created by 佐保楓 on 2025/06/18.
//

import SwiftUI

struct OptionView: View {
    var body: some View {
        ScrollView {
            VStack{
                Text("Mood")
                    .font(.largeTitle)
                    .frame(maxWidth: 300, alignment: .leading)
                    .fontWeight(.bold)
                HStack{
                    Button("Cute", action: {})
                        .buttonStyle()
                    Button("Casual", action: {})
                        .buttonStyle()
                } // HStack
                
                HStack{
                    Button("Elegant", action: {})
                        .buttonStyle()
                    Button("Preppy", action: {})
                        .buttonStyle()
                } // HStacck
            } // VStack
            .padding()
            
            VStack{
                Text("Occasion")
                    .font(.largeTitle)
                    .frame(maxWidth: 300, alignment: .leading)
                    .fontWeight(.bold)
                HStack{
                    Button("School", action: {})
                        .buttonStyle()
                    Button("Work", action: {})
                        .buttonStyle()
                } // HStack
                HStack{
                    Button("Date", action: {})
                        .buttonStyle()
                    Button("Party", action: {})
                        .buttonStyle()
                    
                } // HStack
                HStack {
                    Button("Travel", action: {})
                        .buttonStyle()
                    Button("Work Out", action: {})
                        .buttonStyle()
                } // HStack
            } // VStack
        } // ScrollView
    } // BodyView
    
} // OptionView

extension View {
    func buttonStyle() -> some View {
        self
            .frame(maxWidth: 120)
            .bold()
            .padding()
            .foregroundColor(.white)
            .background(Color.gray)
            .cornerRadius(10)
    } // buttonStyle
} // extension

#Preview {
    OptionView()
}
