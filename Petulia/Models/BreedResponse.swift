//
//  BreedResponse.swift
//  Petulia
//
//  Created by Henry Calderon on 5/10/21.
//  Copyright © 2021 Johandre Delgado . All rights reserved.
//

import Foundation

struct AllBreeds: Codable{
  let breeds: [TypeBreed]
}

struct TypeBreed: Codable {
  let name: String
}
