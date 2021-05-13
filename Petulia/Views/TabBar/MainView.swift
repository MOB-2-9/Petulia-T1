//
//  MainView.swift
//  Petulia
//
//  Created by Anika Morris on 4/15/21.
//  Copyright © 2021 Johandre Delgado . All rights reserved.
//

import SwiftUI

struct MainView: View {
  @EnvironmentObject var petDataController: PetDataController
  @EnvironmentObject var favoriteController: FavoriteController
  @EnvironmentObject var theme: ThemeManager
  @EnvironmentObject var organizationDataController: OrganizationDataController
    var body: some View {
      TabView {
        HomeView()
          .tabItem {
            Label(
              title: { Text("Home") },
              icon: { Image(systemName: "house.fill")
              }
            )
          }
        OrganizationsView()
          .tabItem {
            Label(
              title: { Text("Organizations") },
              icon: { Image(systemName: "person.3.fill") }
            )
          }
        }
      .accentColor(theme.accentColor)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
