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
    VStack(alignment: .leading) {
      FilterBreed()
      FilterAge()
      FilterSize()
      FilterGender()
      FilterLocation()
      Button("Done",action: {self.presentationMode.wrappedValue.dismiss()})
    }
    .navigationBarTitle("Filters")
    .lineSpacing(20)
    .frame(maxWidth: .infinity)
    .padding()
  }
}

//MARK: The Filters
struct FilterBreed: View {
  var breeds = ["Breed1", "Breed2", "Breed3"]
  @State private var selectedBreed = 0
  @State private var toggleAdd = false
  var body: some View {
    VStack{
      HStack{
        Text("Breed")
          .font(.title2)
        Button(action: {
          toggleAdd.toggle()
        }){
          if toggleAdd{
            Image(systemName: "minus")
          }else{
            Image(systemName: "plus")
          }
        }
      }
      DropDownPicker(title: "Select Breed", selection: $selectedBreed, options: breeds)
    }
  }
}

struct FilterAge: View {
  @State var sliderValue: Double = 0
  @State private var toggleAdd = false
  var body: some View {
    VStack{
      HStack{
        Text("Age")
          .font(.title2)
        Button(action: {
          toggleAdd.toggle()
        }){
          if toggleAdd{
            Image(systemName: "minus")
          }else{
            Image(systemName: "plus")
          }
        }
      }
      VStack{
        Slider(value: $sliderValue, in: 0...30, step: 1)
        Text("Age up to \(sliderValue, specifier: "%.1f")")
      }.padding()
      
    }
  }
}

struct FilterSize: View {
  var sizes = ["small", "medium", "large"]
  @State private var selectedSize = 0
  @State private var toggleAdd = false
  var body: some View {
    VStack{
      HStack{
        Text("Animal Size")
          .font(.title2)
        Button(action: {
          toggleAdd.toggle()
        }){
          if toggleAdd{
            Image(systemName: "minus")
          }else{
            Image(systemName: "plus")
          }
        }
      }
      DropDownPicker(title: "Pet Size", selection: $selectedSize, options: sizes)
    }
  }
}

struct FilterGender: View {
  @State private var selectedGender = 0
  @State private var toggleAdd = false
  var body: some View {
    VStack{
      HStack{
        Text("Gender")
          .font(.title2)
        Button(action: {
          toggleAdd.toggle()
        }){
          if toggleAdd{
            Image(systemName: "minus")
          }else{
            Image(systemName: "plus")
          }
        }
      }
      DropDownPicker(title: "Gender", selection: $selectedGender, options: ["Male","Female"])
    }
  }
}

struct FilterLocation: View {
  @State private var location: String = ""
  @State private var toggleAdd = false
  var body: some View {
    VStack{
      HStack(){
        Text("Location")
          .font(.title2)
        Button(action: {
          toggleAdd.toggle()
        }){
          if toggleAdd{
            Image(systemName: "minus")
          }else{
            Image(systemName: "plus")
          }
        }
      }
      TextField("Location",
                text: $location)
        .multilineTextAlignment(.center)
        .frame(maxWidth: 100)
        .padding(.vertical, 8)
    }
  }
}
