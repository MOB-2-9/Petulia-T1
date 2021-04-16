//
//  OrganizationReponse.swift
//  Petulia
//
//  Created by Cao Mai on 4/14/21.
//  Copyright © 2021 Johandre Delgado . All rights reserved.
//

import Foundation

// MARK: - Organization Modeling API response
struct Organization: Codable, Identifiable {
  let id: String
  let name: String
  let email: String
  let phone: String?
  let links: OrganizationLinks
  let address: Address
  let socialMedia: SocialMedia?
  let photos: [Photo]

  
  enum CodingKeys: String, CodingKey {
    case id, name, email, phone
    case links = "_links"
    case address
//    case missionStatement = "mission_statement"
    case socialMedia = "social_media"
    case photos

  }
}

struct SocialMedia: Codable {
  let facebook: String?
  let twitter: String?
  let youtube: String?
  let instagram: String?
  let pinterest: String?
}

struct OrganizationLinks: Codable {
  let animals: LinkToAnimals
}

struct LinkToAnimals: Codable {
  let href: String
}

struct OrganizationList: Codable {
  let organizations: [Organization]
}
