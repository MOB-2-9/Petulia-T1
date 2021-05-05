//
//  DetailedFilterView.swift
//  Petulia
//
//  Created by Henry Calderon on 5/4/21.
//  Copyright © 2021 Johandre Delgado . All rights reserved.
//

import SwiftUI

//MARK: The Filter View
struct DetailFilterView: View {
  var body: some View {
    ScrollView(.horizontal, showsIndicators: false) {
      VStack(alignment: .leading) {
        FilterBreed()
        FilterAge()
        FilterSize()
        FilterGender()
        FilterLocation()
      }
    }
  }
}

//MARK: The Filters
struct FilterBreed: View {
  var body: some View {
    Text("A ANimal Breed")
  }
}

struct FilterAge: View {
  var body: some View {
    Text("Some Number")
  }
}

struct FilterSize: View {
  var body: some View {
    Text("Some Size")
  }
}

struct FilterGender: View {
  var body: some View {
    Text("Gender")
  }
}

struct FilterLocation: View {
  var body: some View {
    Text("Location")
  }
}

//Below is potentiall deprecated content
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
