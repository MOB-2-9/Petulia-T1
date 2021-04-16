//
//  OrganizationDetailView.swift
//  Petulia
//
//  Created by Henry Calderon on 4/15/21.
//  Copyright © 2021 Johandre Delgado . All rights reserved.
//

import SwiftUI
import Foundation

struct OrganizationDetailView: View {
//  var viewModel: PetDetailViewModel
  
  @EnvironmentObject var petDataController: PetDataController
  @EnvironmentObject var theme: ThemeManager
  
  @AppStorage(Keys.savedPostcode) var postcode = ""
  @AppStorage(Keys.isDark) var isDark = false
  
  @State private var typing = false
  @State private var showSettingsSheet = false
  @State private var zoomingImage = false
  
  private var filteredPets: [PetDetailViewModel] {
    return petDataController.allPets
  }
  
  //MARK: View Body
  var body: some View {
    NavigationView {
      ZStack (alignment: .bottom) {
        VStack {
          ScrollView(.vertical, showsIndicators: false) {
            VStack{
              //      heroExpandableImage()
              tempExpandableImage()
              Text("Organization Name")
              Text("City, State")
              Button("Go to website", action: {print("Website")})
            }
            .padding(.bottom)
            VStack {
              petTypeScrollView()
              recentPetSectionView()
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
      .navigationBarTitle("Organization Detail")
    }
    .accentColor(theme.accentColor)
    .preferredColorScheme(isDark ? .dark : .light)
  }
}

//MARK: Extension
private extension OrganizationDetailView {
  //MARK: - Methods
  func requestWebData() {
    print("Making Request")
    self.petDataController.requestPets(around: postcode.isEmpty ? nil : postcode)
  }
  
  //MARK: - Components
  
  func petTypeScrollView() -> some View {
    PetTypeScrollView(
      types: petDataController.petType.types,
      currentPetType: petDataController.petType.currentPetType) { (petType) in
      petDataController.petType.set(to: petType)
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
  
  func settingsControlView() -> some View {
    SettingsButton(presentation: $showSettingsSheet) {
      requestWebData()
    }
  }
  
  func tempExpandableImage() -> some View {
    Image("no-image")
      .resizable()
      .aspectRatio(contentMode: .fill)
      .edgesIgnoringSafeArea(.all)
      .scaledToFit()
      .clipShape(Circle())
      .onTapGesture {
        zoomingImage.toggle()
      }
      .frame(maxWidth: UIScreen.main.bounds.width/3)
  }
  
//  func heroExpandableImage() -> some View {
//    AsyncImageView(
//      urlString: viewModel.defaultImagePath(for: .medium),
//      placeholder: "no-image",
//      maxWidth: .infinity
//    )
//    .scaledToFit()
//    .clipShape(Circle())
//    .onTapGesture {
//      zoomingImage.toggle()
//    }
//    .sheet(isPresented: $zoomingImage) {
//      AsyncGalleryView(title: viewModel.name, imagePaths: viewModel.imagePaths, accentColor: theme.accentColor, showing: $zoomingImage)
//        .foregroundColor(.primary)
//        .preferredColorScheme(isDark ? .dark : .light)
//    }
//  }
}
