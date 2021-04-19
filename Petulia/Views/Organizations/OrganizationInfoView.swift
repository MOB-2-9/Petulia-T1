//
//  OrganizationInfoView.swift
//  Petulia
//
//  Created by Anika Morris on 4/19/21.
//  Copyright © 2021 Johandre Delgado . All rights reserved.
//

import SwiftUI

struct OrganizationInfoView: View {
    var body: some View {
      VStack(alignment: .leading) {
        HStack {
          Expandable(
            label: { Text("Address") },
            content: { Text("Content")}
          )
          Spacer()
        }
        .padding()
        HStack {
          Expandable(
            label: { Text("Contact Info") },
            content: { Text("Content")}
          )
          Spacer()
        }
        .padding()
        HStack {
          Expandable(
            label: { Text("Social Media") },
            content: { Text("Content")}
          )
          Spacer()
        }
        .padding()
      }
      .padding()
    }
}

struct OrganizationInfoView_Previews: PreviewProvider {
    static var previews: some View {
        OrganizationInfoView()
    }
}
