//
//  OrganizationsView.swift
//  Petulia
//
//  Created by Anika Morris on 4/15/21.
//  Copyright © 2021 Johandre Delgado . All rights reserved.
//

import SwiftUI

struct OrganizationsView: View {
    var body: some View {
      NavigationView {
        VStack {
          OrganizationScrollView()
            .padding(.top, 15)
            .padding(.bottom)
          OrganizationInfoView()
          Spacer()
        }
        .navigationBarTitle("Organizations")
      }
    }
}

struct OrganizationsView_Previews: PreviewProvider {
    static var previews: some View {
        OrganizationsView()
    }
}
