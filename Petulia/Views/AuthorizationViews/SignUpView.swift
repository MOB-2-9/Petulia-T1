//
//  SignUpView.swift
//  Petulia
//
//  Created by Henry Calderon on 5/11/21.
//  Copyright © 2021 Johandre Delgado . All rights reserved.
//

import SwiftUI

struct SignUpView: View {
  @State private var username: String = ""
  @State private var password: String = ""
  var body: some View {
    HStack{
      Text("Username")
        .font(.title2)
      TextField("Username", text: $username)
      
      Text("Password")
        .font(.title2)
      TextField("Password", text: $username)
//        .textFieldStyle(Pass)
      
      Button(action: {
        print("Logged in")
      }){
        Text("Login")
      }
    }
  }
}
