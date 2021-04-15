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
  @EnvironmentObject var petDataController: PetDataController
  @EnvironmentObject var theme: ThemeManager
  
  @AppStorage(Keys.savedPostcode) var postcode = ""
  @AppStorage(Keys.isDark) var isDark = false
  
  @State private var typing = false
  @State private var showSettingsSheet = false
  
  private var filteredPets: [PetDetailViewModel] {
    return petDataController.allPets
  }
  
  var body: some View {
    VStack{
      Text("Organization Name")
      Text("City, State")
      Button("Go to website", action: {print("Website")})
    }
    ZStack (alignment: .bottom) {
      VStack {
        ScrollView(.vertical, showsIndicators: false) {
          VStack {
            filterView().padding(.top)
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
  }
}

//MARK: Extension
private extension OrganizationDetailView {
  //MARK: - Methods
  func requestWebData() {
    print("Making Request")
//    self.petDataController.requestPets(around: postcode.isEmpty ? nil : postcode)
  }
  
  //MARK: - Components
  
  func filterView() -> some View {
    FilterBarView(postcode: $postcode, typing: $typing) {
      requestWebData()
    }
  }
  
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
}
