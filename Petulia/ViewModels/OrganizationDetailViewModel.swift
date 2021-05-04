//
//  OrganizationDetailViewModel.swift
//  Petulia
//
//  Created by Cao Mai on 4/15/21.
//  Copyright © 2021 Johandre Delgado . All rights reserved.
//

import Foundation


class OrganizationDetailViewModel: Identifiable, Hashable, Codable {
 
  var id: String
  var name: String
  var email: String
  var phone: String
  var linkToAnimals: LinkToAnimals
  var url: String
  var linkToSelf: LinkString
  var addressStreet: String
  var addressCity: String
  var addressState: String
  var facebook: String
  var twitter: String
  var youtube: String
  var instagram: String
  var pinterest: String
  var photos: [Photo]
  
  init(model: Organization) {
    self.id = model.id
    self.name = model.name
    self.email = model.email
    self.phone = model.phone ?? "Does not exist"
    self.linkToAnimals = model.links.animals
    self.url = model.url
    self.linkToSelf = model.links.linkToSelf
    self.addressStreet = model.address.address1 ?? "Does not exist"
    self.addressCity = model.address.city ?? "Does not exist"
    self.addressState = model.address.state ?? "Does not exist"
    self.facebook = model.socialMedia?.facebook ?? "Does not exist"
    self.youtube  = model.socialMedia?.youtube ?? "Does not exist"
    self.twitter = model.socialMedia?.twitter ?? "Does not exist"
    self.instagram  = model.socialMedia?.instagram ?? "Does not exist"
    self.pinterest  = model.socialMedia?.pinterest ?? "Does not exist"
    self.photos = model.photos
  
  }
  
}

extension OrganizationDetailViewModel {
  
  func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }
  
  static func == (lhs: OrganizationDetailViewModel, rhs: OrganizationDetailViewModel) -> Bool {
    lhs.id == rhs.id
  }
  
  

  func defaultImagePath(for size: Size) -> String {
    if let first = photos.first {
      return first.imagePath(for: size)
    }
    return ""
  }
  
  var imagePaths: [String] {
    return photos.map { $0.imagePath(for: .medium)}
  }
}
