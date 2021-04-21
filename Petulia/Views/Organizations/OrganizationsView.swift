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
  @ObservedObject var UIState: UIStateModel = UIStateModel()

  private var filteredOrgs: [OrganizationDetailViewModel] {
    return organizationDataController.allOrganizations
  }
  
  var body: some View {
    NavigationView {
      VStack {
        SnapCarousel()
          .environmentObject(UIState)
          .padding(.top, 15)
          .padding(.bottom)
        if filteredOrgs.count > 0 {
          organizationInfoView()
        } else {
          organizationInfoLoadingView()
        }
        Spacer()
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
  
  func organizationInfoView() -> some View {
    return OrganizationInfoView(organization: filteredOrgs[UIState.activeCard])
  }
  
  func organizationInfoLoadingView() -> some View {
    return OrganizationInfoLoadingView()
  }
}

//struct OrganizationsView_Previews: PreviewProvider {
//    static var previews: some View {
////        OrganizationsView()
//    }
//}
