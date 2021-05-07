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
  var breeds = ["Breed1", "Breed2", "Breed3"]
  @State private var selectedBreed = 0
  var body: some View {
    Text("Breed")
      .font(.title2)
    DropDownPicker(title: "Select Breed", selection: $selectedBreed, options: breeds)
  }
}

struct FilterAge: View {
  @State var sliderValue: Double = 0
  var body: some View {
    Text("Age")
      .font(.title2)
    VStack{
      Slider(value: $sliderValue, in: 0...30, step: 1)
      Text("Age up to \(sliderValue, specifier: "%.1f")")
    }.padding()
  }
}

struct FilterSize: View {
  var sizes = ["small", "medium", "large"]
  @State private var selectedSize = 0
  var body: some View {
    Text("Some Size")
      .font(.title2)
    DropDownPicker(title: "Pet Size", selection: $selectedSize, options: sizes)
  }
}

struct FilterGender: View {
  @State private var selectedGender = 0
  var body: some View {
    Text("Gender")
      .font(.title2)
    DropDownPicker(title: "Gender", selection: $selectedGender, options: ["Male","Female"])
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
