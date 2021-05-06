//
//  OrganizationsView.swift
//  Petulia
//
//  Created by Anika Morris on 4/15/21.
//  Copyright © 2021 Johandre Delgado . All rights reserved.
//

import SwiftUI

struct OrganizationsView: View {
  @EnvironmentObject var organizationDataController: OrganizationDataController
  @EnvironmentObject var petDataController: PetDataController
  @EnvironmentObject var theme: ThemeManager
  
  @ObservedObject var UIState: UIStateModel = UIStateModel()
  
  @AppStorage(Keys.savedPostcode) var postcode = ""
  
  @State private var typing = false

  private var filteredOrgs: [OrganizationDetailViewModel] {
    return organizationDataController.allOrganizations
  }
  
  /// used to display organization images in SnapCarousel
  private var orgsAsCards: [Card] {
    var cards: [Card] = []
    for (i, org) in filteredOrgs.enumerated() {
      let card = Card(id: i, imageURL: org.defaultImagePath(for: .medium))
      cards.append(card)
    }
    return cards
  }
  
  var body: some View {
    NavigationView {
      VStack {
        filterView()
        if filteredOrgs.count > 0 {
          SnapCarousel(items: orgsAsCards)
            .environmentObject(UIState)
            .padding(.top, 15)
            .padding(.bottom)
          organizationInfoView()
        } else {
          SnapCarousel(items: [Card(id: 0, imageURL: "loading")])
            .environmentObject(UIState)
            .padding(.top, 15)
            .padding(.bottom)
          organizationInfoLoadingView()
        }
        Spacer()
        if typing {
          KeyboardToolBarView() {
            requestOrgs(around: postcode)
          }
        }
      }
      .navigationBarTitle("Organizations")
    }
    .onAppear { requestWebData() } 
    .accentColor(theme.accentColor)
  }
}

extension OrganizationsView {
  func requestWebData() {
    if postcode != "" {
      requestOrgs(around: postcode)
    } else {
      organizationDataController.fetchOrganizations()
    }
  }
  
  func filterView() -> some View {
    FilterBarView(postcode: $postcode, typing: $typing) {
      requestOrgs(around: postcode)
    }
  }
  
  func organizationInfoView() -> some View {
    if UIState.activeCard < 0 {
      UIState.activeCard = 0
    } else if UIState.activeCard == filteredOrgs.count {
      organizationDataController.requestPage(direction: .next) /// ideally this line would append the new orgs to the current orgs so that filteredOrgs gets updated
      UIState.activeCard = UIState.activeCard - 1
    }
    return OrganizationInfoView(organization: filteredOrgs[UIState.activeCard])
  }
  
  func organizationInfoLoadingView() -> some View {
    return OrganizationInfoLoadingView()
  }
  
  func requestOrgs(around postcode: String? = nil) {
    organizationDataController.requestOrgs(around: postcode)
  }
  
  // not sure where to call this function
  func requestNextOrgs() {
    if UIState.activeCard == filteredOrgs.count - 1 {
      organizationDataController.requestPage(direction: .next) /// ideally this line would append the new orgs to the current orgs so that filteredOrgs gets updated
    }
  }
}
