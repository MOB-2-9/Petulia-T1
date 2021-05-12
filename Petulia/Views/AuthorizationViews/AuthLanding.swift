//
//  AuthLanding.swift
//  Petulia
//
//  Created by Henry Calderon on 5/11/21.
//  Copyright © 2021 Johandre Delgado . All rights reserved.
//

import SwiftUI

struct AuthLandingView: View {
  
  var body: some View {
    
    NavigationView {
      VStack(spacing: 50){
        VStack{
          Image("paw")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(maxWidth: .infinity)
            .scaledToFit()
            .clipShape(Circle())
            .shadow(radius: 5)
          Text("Welcome!")
            .font(.title)
        }
        
        VStack(alignment: .center, spacing: 10){
          NavigationLink(destination: LoginView()) {
            Text("Login")
              .frame(width: 110, height: 50, alignment: .center)
              .foregroundColor(.white)
              .background(Color.blue)
              .cornerRadius(15)
          }
          NavigationLink(destination: SignUpView()) {
            Text("Sign Up")
              .frame(width: 110, height: 50, alignment: .center)
              .foregroundColor(.white)
              .background(Color.green)
              .cornerRadius(15)
          }
        }
      }
    }
  }
}
