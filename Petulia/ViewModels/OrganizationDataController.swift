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
  @Published private(set) var orgAllPets: [PetDetailViewModel] = []
  
  private let apiService: NetworkService
  private(set) var pagination: PaginationDTO
  init(
    apiService: NetworkService = APIService(),
    pagination: PaginationDTO = PaginationDTO.new
  ) {
    self.apiService = apiService
    self.pagination = pagination
  }
  
  func requestOrgs(around postcode: String? = nil) {
    allOrganizations = []

    let filters = ["location": postcode]
    let filtered = filters.compactMapValues { $0 }
    print("filtered: \(filtered)")

    let queryItems = filtered.map { URLQueryItem(name: $0.key, value: $0.value) }
    let endPoint2 = EndPoint.organizations(queryItems: queryItems)

    print("url: \(String(describing: endPoint2.url))")
    fetchOrganizations(at: endPoint2)
  }
  
  func fetchOrganizations(at endpoint: EndPoint = EndPoint.organizationsPath) {
    apiService.fetch(at: endpoint) { (result: Result<OrganizationList, Error>) in
      switch result {
      case .failure(let error):
        print(error.localizedDescription)
      case .success(let organizations):
        let rawOrganizations = organizations.organizations
        self.pagination = organizations.pagination
        self.allOrganizations = rawOrganizations.map { OrganizationDetailViewModel(model: $0)}    
        
        /// TESTING OUT FETCHING TO GET ANIMALS FROM ORG
        let linkToAnimal = self.allOrganizations.first?.linkToAnimals
        self.fetchOrgAnimals(link: linkToAnimal!)
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
        self.orgAllPets = rawPets.map { PetDetailViewModel(model: $0)}
      }
    }
  }
}
