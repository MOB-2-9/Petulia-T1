//
//  HomeView.swift
//  Petulia
//
//  Created by Johandre Delgado  on 15.08.2020.
//  Copyright © 2020 Johandre Delgado . All rights reserved.
//

import SwiftUI

struct HomeView: View {
  @EnvironmentObject var petDataController: PetDataController
  @EnvironmentObject var favorites: FavoriteController
  @EnvironmentObject var theme: ThemeManager
  
  @AppStorage(Keys.savedPostcode) var postcode = ""
  @AppStorage(Keys.isDark) var isDark = false
  
  @AppStorage(Keys.photoOnly) var photoOnly = false
  
  @State private var typing = false
  @State private var showSettingsSheet = false
  
  private var filteredPets: [PetDetailViewModel] {
    if photoOnly == true {
      return petDataController.allPets.filter { $0.photos.count != 0 }
    }
    return petDataController.allPets
  }
  
  var body: some View {
    NavigationView {
      ZStack (alignment: .bottom) {
        VStack {
          ScrollView(.vertical, showsIndicators: false) {
            VStack {
              filterView().padding(.top)
              NavigationLink(destination: filterDetailView()){ Text("+ filters") }
              petTypeScrollView()
              recentPetSectionView()
              favoritesSectionView()
            }
            .padding(.bottom)
          }
        }
        if typing {
          KeyboardToolBarView() {
            requestWebData()
          }
        }
      }
      .navigationBarTitle("Petulia")
      .navigationBarItems(trailing:
                            HStack { settingsControlView() })
      .navigationBarBackButtonHidden(true)
    }
    .onAppear { requestWebData() } // Assures data at startup
    .navigationViewStyle(StackNavigationViewStyle()) // Solves the double column bug
    .accentColor(theme.accentColor)
    .preferredColorScheme(isDark ? .dark : .light)
  }
}

private extension HomeView {
  //MARK: - Methods
    func requestWebData() {
    self.petDataController.requestPets(around: postcode.isEmpty ? nil : postcode)
  }
  
  func requestBreeds(){
    self.petDataController.fetchPetBreeds()
  }
  
  //MARK: - Components
  
  func filterView() -> some View {
    FilterBarView(postcode: $postcode, typing: $typing,action:{
      requestWebData()
      requestBreeds()
    })
  }
  
  func filterDetailView() -> some View{
    DetailFilterView(action: { 
      requestWebData()
    })
  }
  
    func petTypeScrollView() -> some View {
    PetTypeScrollView(
      types: petDataController.petType.types,
      currentPetType: petDataController.petType.currentPetType) { (petType) in
      petDataController.petType.set(to: petType)
      petDataController.BreedType = nil
      requestWebData()
    }
  }

    func recentPetSectionView() -> some View {
    SectionView(
      kind: .recent,
      petViewModel: filteredPets,
      totalPetCount: petDataController.allPets.count,
      title: "Recent \(petDataController.petType.currentPetType.name)".capitalized,
      isLoading: petDataController.isLoading,
      primaryAction: { requestWebData() },
      settingsAction: { }
    )
  }
  
    func favoritesSectionView() -> some View {
    SectionView(
      kind: .favorites,
      petViewModel: favorites.list,
      title: "Favorites"
    )
  }
  
    func settingsControlView() -> some View {
    SettingsButton(presentation: $showSettingsSheet) {
      requestWebData()
    }
  }
}
