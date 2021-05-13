//
//  MotherView.swift
//  Petulia
//
//  Created by Anika Morris on 5/13/21.
//  Copyright © 2021 Johandre Delgado . All rights reserved.
//

import SwiftUI

struct MotherView: View {
    
  @EnvironmentObject var viewRouter: ViewRouter
  @EnvironmentObject var petDataController: PetDataController
  @EnvironmentObject var favoriteController: FavoriteController
  @EnvironmentObject var themeManager: ThemeManager
  @EnvironmentObject var organizationDataController: OrganizationDataController

  var body: some View {
    if viewRouter.currentPage == "onboardingView" {
      OnboardingView()
    } else if viewRouter.currentPage == "mainView" {
      MainView()
    }
  }
}
