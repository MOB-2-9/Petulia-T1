//
//  MainView.swift
//  Petulia
//
//  Created by Anika Morris on 4/15/21.
//  Copyright © 2021 Johandre Delgado . All rights reserved.
//

import SwiftUI

struct MainView: View {
    var body: some View {
      TabView {
          HomeView()
            .tabItem {
              Label(
                title: { Text("Home") },
                icon: { Image(systemName: "house.fill") }
              )
            }
          SettingsView()
            .tabItem {
              Label(
                title: { Text("Settings") },
                icon: { Image(systemName: "gear") }
              )
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
