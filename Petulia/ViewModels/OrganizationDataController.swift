//
//  OrganizationsDataController.swift
//  Petulia
//
//  Created by Cao Mai on 4/15/21.
//  Copyright © 2021 Johandre Delgado . All rights reserved.
//

import Foundation

final class OrganizationDataController: ObservableObject {
  
  @Published private(set) var allOrganizations: [OrganizationDetailViewModel] = []
  
  @Published private(set) var singleOrganization: OrganizationDetailViewModel? = nil
  
  private let apiService: NetworkService

  init(
    apiService: NetworkService = APIService()
  ) {
    self.apiService = apiService
  }
  
  func fetchOrganizations() {
    apiService.fetch(at: EndPoint.organizationsPath) { (result: Result<OrganizationList, Error>) in
      switch result {
      case .failure(let error):
        print(error.localizedDescription)
      case .success(let organizations):
//        let first = organizations.organizations.first?.links.linkToSelf
//
//        self.fetchOrganization(link: first!)
        
        let rawOrganizations = organizations.organizations
        self.allOrganizations = rawOrganizations.map { OrganizationDetailViewModel(model: $0)}
        print(self.allOrganizations)
      }
    }
  }
  
  func fetchOrganization(link: LinkToSelf) {
    apiService.fetch(at: EndPoint.organization(from: link)) { (result: Result<ResponseOrangization, Error>) in
      switch result {
      case .failure(let error):
        print(error.localizedDescription)
      case .success(let organization):

        let rawOrganization = organization.organization
        self.singleOrganization = OrganizationDetailViewModel(model: rawOrganization)
       
    }
  }
  
}
}
