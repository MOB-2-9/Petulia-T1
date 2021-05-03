//
//  ActivityController.swift
//  Petulia
//
//  Created by Anika Morris on 5/3/21.
//  Copyright © 2021 Johandre Delgado . All rights reserved.
//

import SwiftUI
import UIKit

struct ActivityViewController: UIViewControllerRepresentable {

  var activityItems: [Any]
  var applicationActivities: [UIActivity]? = nil

  func makeUIViewController(context: UIViewControllerRepresentableContext<ActivityViewController>) -> UIActivityViewController {
    let controller = UIActivityViewController(activityItems: activityItems, applicationActivities:
      applicationActivities)
    return controller
  }

  func updateUIViewController(_ uiViewController: UIActivityViewController, context:
    UIViewControllerRepresentableContext<ActivityViewController>) {}

}
