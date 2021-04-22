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
  let url: String
  let links: OrganizationLinks
  let address: Address
  let socialMedia: SocialMedia?
  let photos: [Photo]

  
  enum CodingKeys: String, CodingKey {
    case id, name, email, phone, url
    case links = "_links"
    case address
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
  let linkToSelf: LinkToSelf
  let animals: LinkToAnimals
  
  enum CodingKeys: String, CodingKey {
    case linkToSelf = "self"
    case animals
  }
}

struct LinkToSelf: Codable {
  let href: String
}

struct LinkToAnimals: Codable {
  let href: String
}

struct OrganizationList: Codable {
  let organizations: [Organization]
}

struct ResponseOrangization: Codable {
  let organization: Organization
}
