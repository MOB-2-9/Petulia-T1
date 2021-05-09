//
//  DetailedFilterView.swift
//  Petulia
//
//  Created by Henry Calderon on 5/4/21.
//  Copyright © 2021 Johandre Delgado . All rights reserved.
//

import SwiftUI

//MARK: - The Filter View
struct DetailFilterView: View {
//  @AppStorage(Keys.age) public var age = ""
//  @State public var filters:[String:String] = [:]
//  var breeds: [PetBreed]
  var action: (() -> Void)?
  
  @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
  var body: some View {
    VStack(alignment: .leading) {
      FilterBreed()
      FilterAge()
      FilterSize()
      FilterGender()
      FilterLocation()
      Button("Apply",action: {
              action?()
              self.presentationMode.wrappedValue.dismiss()
      })
    }
    .navigationBarTitle("Filters")
    .lineSpacing(20)
    .frame(maxWidth: .infinity)
    .padding()
  }
}

//MARK: - The Filters
private extension DetailFilterView{
  
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
  
  //MARK: Age
  struct FilterAge: View {
    @AppStorage(Keys.age) public var age = ""
    @AppStorage(Keys.ageNum) public var ageNum = 0
    var ages = ["Baby","Young","Adult","Senior"]
    @State private var toggleAdd = false
    var body: some View {
      VStack(alignment: .leading){
        HStack{
          Text("Age")
            .font(.title2)
          Button(action: {
            toggleAdd.toggle()
            if toggleAdd == true{
              age = ages[ageNum]
            }else{
              age = ""
            }
          }){
            if toggleAdd{
              Image(systemName: "minus")
            }else{
              Image(systemName: "plus")
                .foregroundColor(.green)
            }
          }
        }
        DropDownPicker(title: "Pet Ages", selection: $ageNum, options: ages)
          .onChange(of: ageNum, perform: {_ in
            age = ages[ageNum]
          })
      }
      .onAppear(perform: {
        if age != ""{
          toggleAdd = true
        }
      })
    }
  }
  
  //MARK: Size
  struct FilterSize: View {
    var sizes = ["Small", "Medium", "Large","Xlarge"]
    @AppStorage(Keys.size) public var size = ""
    @AppStorage(Keys.sizeNum) public var sizeNum = 0
    @State private var toggleAdd = false
    var body: some View {
      VStack(alignment: .leading){
        HStack{
          Text("Animal Size")
            .font(.title2)
          Button(action: {
            toggleAdd.toggle()
            if toggleAdd == true{
              size = sizes[sizeNum]
            }else{
              size = ""
            }
          }){
            if toggleAdd{
              Image(systemName: "minus")
            }else{
              Image(systemName: "plus")
                .foregroundColor(.green)
            }
          }
        }
        DropDownPicker(title: "Pet Size", selection: $sizeNum, options: sizes)
          .onChange(of: sizeNum, perform: {_ in
            size = sizes[sizeNum]
          })
      }
      .onAppear(perform: {
        if size != ""{
          toggleAdd = true
        }
      })
    }
  }
  
  //MARK: Gender
  struct FilterGender: View {
    let genders = ["Male","Female","Unknown"]
    @AppStorage(Keys.gender) public var gender = ""
    @AppStorage(Keys.genNum) public var genNum = 0
    @State private var toggleAdd = false
    var body: some View {
      VStack(alignment: .leading){
        HStack{
          Text("Gender")
            .font(.title2)
          Button(action: {
            toggleAdd.toggle()
            if toggleAdd == true{
              gender = genders[genNum]
            }else{
              gender = ""
            }
          }){
            if toggleAdd{
              Image(systemName: "minus")
            }else{
              Image(systemName: "plus")
                .foregroundColor(.green)
            }
          }
        }
        DropDownPicker(title: "Gender", selection: $genNum, options: genders)
          .onChange(of: genNum, perform: {_ in
            gender = genders[genNum]
          })
      }
      .onAppear(perform: {
        if gender != ""{
          toggleAdd = true
        }
      })
    }
  }
  
  //MARK: Location
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
