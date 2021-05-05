//
//  DetailedFilterView.swift
//  Petulia
//
//  Created by Henry Calderon on 5/4/21.
//  Copyright © 2021 Johandre Delgado . All rights reserved.
//

import SwiftUI

struct DetailFilterView: View {
  var body: some View {
    ScrollView(.horizontal, showsIndicators: false) {
      HStack {
        DropDownMenu()
        
      }
      .padding()
//      .onAppear {
//        proxy.scrollTo(max(currentPetType.id - 1, 0))
//      }
    }
  }
}

//https://anthonycodesofficial.medium.com/swiftui-tutorial-how-to-create-a-floating-drop-down-menu-cc1562dbd48f
struct DropDownMenu: View{
  @State var expand = false
  var body: some View{
    VStack(){
      Spacer()
      VStack(spacing: 30){
        HStack(){
          Text("Breed")
            .fontWeight(.bold)
            .foregroundColor(.white)
          Image(systemName: expand ? "chevron.up":"chevron.down")
            .resizable()
            .frame(width: 13, height: 6)
            .foregroundColor(.white)
        }.onTapGesture {
          self.expand.toggle()
        }
        if expand{
          Button(action: {
            print("Hello")
            self.expand.toggle()
          }) {
            Text("Dog")
              .padding()
          }.foregroundColor(.white)
        }
      }
      .padding()
      .background(Color.blue)
      .cornerRadius(20)
//      .accentColor(.blue)
      .shadow(color:.gray,radius: 5)
      .animation(.spring())
    }
  }
}
