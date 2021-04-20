//
//  OrganizationsView.swift
//  Petulia
//
//  Created by Anika Morris on 4/15/21.
//  Copyright © 2021 Johandre Delgado . All rights reserved.
//

import SwiftUI

struct OrganizationsView: View {
  var UIState: UIStateModel = UIStateModel()
  @EnvironmentObject var organizationDataController: OrganizationDataController
  
    var body: some View {
      NavigationView {
        VStack {
          SnapCarousel()
            .environmentObject(UIState)
            .padding(.top, 15)
            .padding(.bottom)
          OrganizationInfoView()
        }
        .navigationBarTitle("Organizations")
      }
      .onAppear { requestWebData() }
    }
}

extension OrganizationsView {
  func requestWebData() {
    organizationDataController.fetchOrganizations()
    
  }
}

struct OrganizationsView_Previews: PreviewProvider {
    static var previews: some View {
        OrganizationsView()
    }
}
