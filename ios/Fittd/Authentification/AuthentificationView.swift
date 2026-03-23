//
//  AuthentificationView.swift
//  Fittd
//
//  Created by 佐保楓 on 2025/10/18.
//

import SwiftUI

struct AuthentificationView: View {
    @Binding var showSignInView: Bool
    var body: some View {
        VStack {
            
            NavigationLink {
                SignInEmailView(showSignInView: $showSignInView)
            } label: {
                Text("Sign in with Email")
                    .font(.headline)
                    .foregroundStyle(.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
                

                
            }
                
        }
        .padding()
        .navigationBarTitle("Sign In")
    }
}
        

#Preview {
    NavigationStack{
        AuthentificationView(showSignInView: .constant(false))
    }
}
