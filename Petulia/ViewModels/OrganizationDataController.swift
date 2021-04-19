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
        let first = organizations.organizations.first?.links.linkToSelf
        self.apiService.fetchTEST(at: EndPoint.organization(from: first!))
//        let rawOrganizations = organizations.organizations
//        self.allOrganizations = rawOrganizations.map { OrganizationDetailViewModel(model: $0)}
//        print(self.allOrganizations)
      }
    }
  }
  
}
