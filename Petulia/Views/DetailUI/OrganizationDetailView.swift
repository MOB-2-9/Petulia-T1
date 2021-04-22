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
  @EnvironmentObject var orgDataController: OrganizationDataController
  @EnvironmentObject var theme: ThemeManager
  
  @AppStorage(Keys.savedPostcode) var postcode = ""
  @AppStorage(Keys.isDark) var isDark = false
  
  @State private var typing = false
  @State private var showSettingsSheet = false
  @State private var zoomingImage = false
  
  private var filteredPets: [PetDetailViewModel] {
    return petDataController.allPets
  }
  
  var organization: OrganizationDetailViewModel
  
  //MARK: View Body
  var body: some View {
    ZStack (alignment: .bottom) {
      VStack {
        ScrollView(.vertical, showsIndicators: false) {
          Text(organization.name)
            .font(.largeTitle)
            .bold()
            .frame(idealWidth: .infinity)
            .multilineTextAlignment(.center)
          VStack{
            if organization.photos.count != 0{
              heroExpandableImage()
              Text("\(organization.addressCity), \(organization.addressState)")
                .font(.title3)
                .fontWeight(.light)
              Button("Go to website", action: {
                UIApplication.shared.open(URL(string: organization.url)!)
              })
            }else{
              Text("\(organization.addressCity), \(organization.addressState)")
                .font(.title2)
              Button(action: {
                UIApplication.shared.open(URL(string: organization.url)!)
              }){
                ContactHStack(
                  label: "Website",
                  systemIcon: "link",
                  backgroundColor: theme.accentColor
                )
                .frame(maxWidth: .infinity)
              }
            }
          }
          .padding(.bottom)
          VStack {
//            petTypeScrollView()
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
    .accentColor(theme.accentColor)
    .preferredColorScheme(isDark ? .dark : .light)
  }
}

//MARK: Extension
private extension OrganizationDetailView {
  //MARK: - Methods
  func requestWebData() {
    print("Making Request")
    self.orgDataController.fetchOrgAnimals(link: organization.linkToAnimals)
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
//      totalPetCount: petDataController.allPets.count,
      totalPetCount: orgDataController.orgAllPets.count,
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
  
  func heroExpandableImage() -> some View {
    AsyncImageView(
      urlString: organization.defaultImagePath(for: .medium),
      placeholder: "no-image",
      maxWidth: .infinity
    )
    .scaledToFit()
    .clipShape(Circle())
    .onTapGesture {
      zoomingImage.toggle()
    }
    .frame(maxWidth: UIScreen.main.bounds.width/2)
    .sheet(isPresented: $zoomingImage) {
      AsyncGalleryView(title: organization.name, imagePaths: organization.imagePaths, accentColor: theme.accentColor, showing: $zoomingImage)
        .foregroundColor(.primary)
        .preferredColorScheme(isDark ? .dark : .light)
    }
  }
}
