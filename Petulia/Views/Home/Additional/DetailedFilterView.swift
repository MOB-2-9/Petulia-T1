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
//  var primaryAction: (() -> Void)?
//  var settingsAction: (() -> Void)?
  
  @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
  var body: some View {
//    ScrollView(.horizontal, showsIndicators: false) {
      VStack(alignment: .leading) {
        FilterBreed()
        FilterAge()
        FilterSize()
        FilterGender()
        FilterLocation()
        Button("Done",action: {self.presentationMode.wrappedValue.dismiss()})
      }
      .lineSpacing(20)
      .frame(maxWidth: .infinity)
      .padding()
//    }
  }
}

//MARK: The Filters
struct FilterBreed: View {
  var body: some View {
    Text("Breed")
      .font(.title2)
  }
}

struct FilterAge: View {
  @State var sliderValue: Double = 0
  var body: some View {
    Text("Age")
      .font(.title2)
    Slider(value: $sliderValue, in: 0...30)
  }
}

struct FilterSize: View {
  var sizes = ["small", "medium", "large"]
  @State private var selectedSize = "small"
  var body: some View {
    Text("Some Size")
      .font(.title2)
    Picker("Select a Size", selection: $selectedSize) {
      ForEach(sizes, id: \.self) {
        Text($0)
      }
    }
    Text("You selected: \(selectedSize)")
  }
}

struct FilterGender: View {
  var body: some View {
    Text("Gender")
      .font(.title2)
  }
}

struct FilterLocation: View {
  @State private var location: String = ""
  var body: some View {
    Text("Location")
      .font(.title2)
    TextField("Location",
              text: $location)
      .font(.headline)
      .multilineTextAlignment(.center)
      .frame(maxWidth: 100)
      .padding(.vertical, 8)
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
