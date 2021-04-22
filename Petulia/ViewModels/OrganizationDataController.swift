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
  @Published private(set) var singleOrganization: OrganizationDetailViewModel!
  
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
        let rawOrganizations = organizations.organizations
        self.allOrganizations = rawOrganizations.map { OrganizationDetailViewModel(model: $0)}
        
        /// TESTING OUT FETCHING TO GET ANIMALS FROM ORG
        let linkToAnimal = self.allOrganizations.first?.linkToAnimals
        self.fetchOrgAnimals(link: linkToAnimal!)
      // Print out all organizations
      //        print(self.allOrganizations)
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
  
  func fetchOrgAnimals(link: LinkToAnimals) {
    apiService.fetch(at: EndPoint.animalsFromOrg(from: link)) { (result: Result<AllAnimals, Error>) in
      switch result {
      case.failure(let error):
        print(error.localizedDescription)
      case.success(let petResponse):
        let rawPets = petResponse.animals ?? []
        // Still need to store this in variable
        let allPets = rawPets.map { PetDetailViewModel(model: $0)}
      }
    }

  }
}
