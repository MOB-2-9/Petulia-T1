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
          Image("cat2")
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
