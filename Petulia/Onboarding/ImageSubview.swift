//
//  ImageSubview.swift
//  Petulia
//
//  Created by Anika Morris on 5/13/21.
//  Copyright © 2021 Johandre Delgado . All rights reserved.
//

import SwiftUI

struct ImageSubview: View {
  var imageString: String
  var body: some View {
    Image(imageString)
      .resizable()
      .aspectRatio(contentMode: .fit)
      .clipped()
  }
}

