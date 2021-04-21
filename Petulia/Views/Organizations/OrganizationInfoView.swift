//
//  OrganizationInfoView.swift
//  Petulia
//
//  Created by Anika Morris on 4/19/21.
//  Copyright © 2021 Johandre Delgado . All rights reserved.
//

import SwiftUI

struct OrganizationInfoView: View {
  @EnvironmentObject var petDataController: PetDataController
  @State private var collapsedAddress: Bool = true
  @State private var collapsedContact: Bool = true
  var organization: OrganizationDetailViewModel
  
  var body: some View {
    VStack {
      Text("\(organization.name)")
        .font(.title)
      Text("\(organization.addressCity), \(organization.addressState)")
        .font(.title2)
      HStack {
        VStack {
          Button(
            action: { self.collapsedAddress.toggle() },
            label: {
              HStack {
                Text("Address")
                Spacer()
                Image(systemName: self.collapsedAddress ? "chevron.right" : "chevron.up")
              }
              .padding(.bottom, 1)
              .background(Color.white.opacity(0.01))
            }
          )
          .buttonStyle(PlainButtonStyle())
          VStack {
            Text("\(organization.addressStreet)")
            Text("\(organization.addressCity), \(organization.addressState)")
          }
          .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: collapsedAddress ? 0 : .none)
          .clipped()
          .animation(.easeOut)
          .transition(.slide)
        }
        Spacer()
      }
      .padding()
      HStack {
        VStack {
          Button(
            action: { self.collapsedContact.toggle() },
            label: {
              HStack {
                Text("Contact Info")
                Spacer()
                Image(systemName: self.collapsedContact ? "chevron.right" : "chevron.up")
              }
              .padding(.bottom, 1)
              .background(Color.white.opacity(0.01))
            }
          )
          .buttonStyle(PlainButtonStyle())
          VStack {
            Text("Email: \(organization.email)")
            Text("Phone: \(organization.phone)")
          }
          .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: collapsedContact ? 0 : .none)
          .clipped()
          .animation(.easeOut)
          .transition(.slide)
        }
        Spacer()
      }
      .padding()
      NavigationLink(destination: OrganizationDetailView(petDataController: _petDataController)) {
        Text("View available animals")
      }
      .padding()
    }
  }
}

struct OrganizationInfoLoadingView: View {
  
  var body: some View {
    VStack {
      Text("Loading...")
        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
        .padding()
    }
  }
}

//struct OrganizationInfoView_Previews: PreviewProvider {
//    static var previews: some View {
//        OrganizationInfoView()
//    }
//}
