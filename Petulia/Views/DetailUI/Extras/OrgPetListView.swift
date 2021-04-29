//
//  OrgPetListView.swift
//  Petulia
//
//  Created by Henry Calderon on 4/27/21.
//  Copyright © 2021 Johandre Delgado . All rights reserved.
//

import SwiftUI

struct OrgPetListView: View {
  @EnvironmentObject var orgDataController: OrganizationDataController
  
  var petViewModel: [PetDetailViewModel]  = []
  var title = "All Animals"
  var showPagination = true

  var body: some View {
    VStack {
      ScrollView(.vertical, showsIndicators: true) {
        LazyVStack(spacing: 5) {
          ForEach(petViewModel, id: \.id) { pet in
            NavigationLink(destination: PetDetailView(viewModel: pet)) {
              PetRow(pet)
                .padding(.horizontal)
                .contentShape(Rectangle())
            }
            .buttonStyle(ClearButtonStyle())
            .animation(.default)
          }
        }
        .padding(.vertical)
        Spacer()

        if showPagination {
          paginationControl()
            .padding(.bottom)
        }
      }
    }
    .navigationBarTitle(showPagination ? title + " \(orgDataController.pagination.currentPage)" : title)
  }
}

//Pagination buttons
extension OrgPetListView {
  private func paginationControl() -> some View {
    HStack(spacing: 10) {
      Spacer()

      Button(action: {
        orgDataController.requestPage(direction: PageDirection.previous)
      }) {
        HStack {
          Image(systemName: "chevron.left.circle")
          Text("Previous")
        }
        .frame(width: 100, height: 44)
        .padding(.horizontal)
        .foregroundColor(orgDataController.pagination.links?.previous != nil ? .accentColor : .gray)
        .background(Color(UIColor.systemGray6))
        .cornerRadius(10)
      }
      .disabled(orgDataController.pagination.links?.previous == nil)

      Text("\(orgDataController.pagination.currentPage) / \(orgDataController.pagination.totalPages)")
        .frame(width: 60, height: 44)
        .foregroundColor(.white)
        .lineLimit(1)
        .minimumScaleFactor(0.6)
        .padding(.horizontal, 5)
        .background(Color.accentColor)
        .cornerRadius(10)
        .layoutPriority(1)
      
      Button(action: {
        orgDataController.requestPage(direction: PageDirection.next)
      }) {
        HStack {
          Text("Next")
          Image(systemName: "chevron.right.circle")
        }
        .frame(width: 100, height: 44)
        .padding(.horizontal)
        .foregroundColor(orgDataController.pagination.links?.next != nil ? .accentColor : .gray)
        .background(Color(UIColor.systemGray6))
        .cornerRadius(10)
      }
      .disabled(orgDataController.pagination.links?.next == nil)
      Spacer()
    }
  }
}


