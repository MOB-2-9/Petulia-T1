//
//  OrganizationScrollView.swift
//  Petulia
//
//  Created by Anika Morris on 4/19/21.
//  Copyright © 2021 Johandre Delgado . All rights reserved.
//

import SwiftUI

struct OrganizationScrollView: View {
    var body: some View {
      ScrollView(.horizontal, showsIndicators: false) {
        HStack(spacing: 20) {
          ForEach(0..<10) {
            Text("Item \($0)")
              .foregroundColor(.white)
              .font(.largeTitle)
              .frame(width: 200, height: 200)
              .background(Color.blueLight)
          }
        }
      }
    }
}

struct OrganizationScrollView_Previews: PreviewProvider {
    static var previews: some View {
        OrganizationScrollView()
    }
}
