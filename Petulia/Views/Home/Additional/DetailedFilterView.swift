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
//  var breeds: [PetBreed]
//  var currentPetType: PetType
  var action: (() -> Void)?
  
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

private extension DetailFilterView{
  //MARK: The Filters
  struct FilterBreed: View {
    var breeds = ["Breed1", "Breed2", "Breed3"]
    @State private var selectedBreed = 0
    @State private var toggleAdd = false
    var body: some View {
      VStack(alignment: .leading){
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
                .foregroundColor(.green)
            }
          }
        }
        DropDownPicker(title: "Select Breed", selection: $selectedBreed, options: breeds)
      }
    }
  }
  
  struct FilterAge: View {
    var ages = ["Baby","Young","Adult","Senior"]
    @State private var selectedAge = 0
    @State private var toggleAdd = false
    var body: some View {
      VStack(alignment: .leading){
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
                .foregroundColor(.green)
            }
          }
        }
        DropDownPicker(title: "Pet Ages", selection: $selectedAge, options: ages)
      }
    }
  }
  
  struct FilterSize: View {
    var sizes = ["small", "medium", "large","xlarge"]
    @State private var selectedSize = 0
    @State private var toggleAdd = false
    var body: some View {
      VStack(alignment: .leading){
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
                .foregroundColor(.green)
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
      VStack(alignment: .leading){
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
                .foregroundColor(.green)
            }
          }
        }
        DropDownPicker(title: "Gender", selection: $selectedGender, options: ["Male","Female","Unknown"])
      }
    }
  }
  
  struct FilterLocation: View {
    @State private var location: String = ""
    @State private var toggleAdd = false
    var body: some View {
      VStack(alignment: .leading){
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
                .foregroundColor(.green)
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
  
}
