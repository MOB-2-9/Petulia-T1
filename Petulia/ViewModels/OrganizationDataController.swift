//
//  OrganizationsDataController.swift
//  Petulia
//
//  Created by Cao Mai on 4/15/21.
//  Copyright © 2021 Johandre Delgado . All rights reserved.
//

import Foundation

final class OrganizationDataController: ObservableObject {
  
  @Published private(set) var allPets: [PetDetailViewModel] = []
  private let apiService: NetworkService

  init(
    apiService: NetworkService = APIService()
  ) {
    self.apiService = apiService
  }
  
  private func fetchOrganizations() {
    //    apiService.fetchTEST(at: EndPoint.organizationsPath)
    apiService.fetch(at: EndPoint.organizationsPath) { (result: Result<OrganizationList, Error>) in
      switch result {
      case .failure(let error):
        print(error.localizedDescription)
      case .success(let organizations):
        print(organizations)
      }
    }
  }
  
}
