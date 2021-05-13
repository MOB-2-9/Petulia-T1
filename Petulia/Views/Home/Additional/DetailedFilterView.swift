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
  @EnvironmentObject var petDataController: PetDataController
  private var breeds: [String] {
    return petDataController.allBreeds
  }
  var action: (() -> Void)?
  
  @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
  var body: some View {
    ScrollView(.vertical, showsIndicators: false) {
      VStack(alignment: .leading) {
        filterBreedView()
        FilterAge()
        FilterSize()
        FilterGender()
        Button("Apply",action: {
                action?()
                self.presentationMode.wrappedValue.dismiss()
        })
        .frame(height: 50)
        .frame(maxWidth: .infinity)
        .foregroundColor(.white)
        .background(Color.green)
        .cornerRadius(15)
      }
      .lineSpacing(20)
      
    }
    .onAppear{ requestBreeds() }
    .navigationBarTitle("Filters")
    .frame(maxWidth: .infinity)
    .padding()
    
  }
}

//MARK: - The Filters
extension DetailFilterView{
  func requestBreeds(){
    self.petDataController.fetchPetBreeds()
  }
  
  func filterBreedView() -> some View {
    FilterBreed(breeds: breeds, action: { requestBreeds() })
  }
  
  //MARK: Age
  struct FilterAge: View {
    @EnvironmentObject var petDataController: PetDataController
    @AppStorage(Keys.ageNum) public var ageNum = 0
    var ages = ["Baby","Young","Adult","Senior"]
    @State private var toggleAdd = false
    var body: some View {
      VStack(alignment: .leading){
        HStack{
          Text("Age")
            .font(.title2)
            .fontWeight(.bold)
          Button(action: {
            toggleAdd.toggle()
            if toggleAdd == true{
              petDataController.AgeFilter = ages[ageNum]
            }else{
              petDataController.AgeFilter = nil
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
        .padding(7)
        .background(Color("lightGray"))
        .cornerRadius(5)
        DropDownPicker(title: "Pet Ages", selection: $ageNum, options: ages)
          .onChange(of: ageNum, perform: {_ in
            if toggleAdd == true{
              petDataController.AgeFilter = ages[ageNum]
            }
          })
      }
      .onAppear(perform: {
        if petDataController.AgeFilter != nil{
          toggleAdd = true
        }
      })
    }
  }
  
  //MARK: Size
  struct FilterSize: View {
    var sizes = ["Small", "Medium", "Large","Xlarge"]
    @EnvironmentObject var petDataController: PetDataController
    @AppStorage(Keys.sizeNum) public var sizeNum = 0
    @State private var toggleAdd = false
    var body: some View {
      VStack(alignment: .leading){
        HStack{
          Text("Animal Size")
            .font(.title2)
            .fontWeight(.bold)
          Button(action: {
            toggleAdd.toggle()
            if toggleAdd == true{
              petDataController.SizeFilter = sizes[sizeNum]
            }else{
              petDataController.SizeFilter = nil
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
        .padding(7)
        .background(Color("lightGray"))
        .cornerRadius(5)
        DropDownPicker(title: "Pet Size", selection: $sizeNum, options: sizes)
          .onChange(of: sizeNum, perform: {_ in
            if toggleAdd == true{
              petDataController.SizeFilter = sizes[sizeNum]
            }
          })
      }
      .onAppear(perform: {
        if petDataController.SizeFilter != nil{
          toggleAdd = true
        }
      })
    }
  }
  
  //MARK: Gender
  struct FilterGender: View {
    @EnvironmentObject var petDataController: PetDataController
    let genders = ["Male","Female","Unknown"]
    @AppStorage(Keys.genNum) public var genNum = 0
    @State private var toggleAdd = false
    var body: some View {
      VStack(alignment: .leading){
        HStack{
          Text("Gender")
            .font(.title2)
            .fontWeight(.bold)
          Button(action: {
            toggleAdd.toggle()
            if toggleAdd == true{
              petDataController.GenderFilter = genders[genNum]
            }else{
              petDataController.GenderFilter = nil
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
        .padding(7)
        .background(Color("lightGray"))
        .cornerRadius(5)
        DropDownPicker(title: "Gender", selection: $genNum, options: genders)
          .onChange(of: genNum, perform: {_ in
            if toggleAdd == true{
              petDataController.GenderFilter = genders[genNum]
            }
          })
      }
      .onAppear(perform: {
        if petDataController.GenderFilter != nil{
          toggleAdd = true
        }
      })
    }
  }
}

//MARK: Breeds
struct FilterBreed: View {
  @EnvironmentObject var petDataController: PetDataController
  @AppStorage(Keys.breedNum) public var breedNum = 0
  var breeds: [String] = []
  @State private var toggleAdd = false
  var action: (() -> Void)?
  var body: some View {
    VStack(alignment: .leading){
      HStack{
        Text("Breed")
          .font(.title2)
          .fontWeight(.bold)
        Button(action: {
          toggleAdd.toggle()
          if toggleAdd{
            petDataController.BreedType = breeds[breedNum]
          }else{
            petDataController.BreedType = nil
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
      .padding(7)
      .background(Color("lightGray"))
      .cornerRadius(5)
      
      if !breeds.isEmpty{
        DropDownPicker(title: "Select Breed", selection: $breedNum, options: breeds)
      }
    }
    .onAppear(perform: {
      if petDataController.BreedType != nil{
        toggleAdd = true
      }
      if petDataController.BreedType == nil{
        breedNum = 0
      }
    })
  }
}
