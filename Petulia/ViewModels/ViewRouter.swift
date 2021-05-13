//
//  ViewRouter.swift
//  Petulia
//
//  Created by Anika Morris on 5/13/21.
//  Copyright © 2021 Johandre Delgado . All rights reserved.
//

import Foundation
import SwiftUI

class ViewRouter: ObservableObject {
    
    init() {
        if !UserDefaults.standard.bool(forKey: "didLaunchBefore") {
            UserDefaults.standard.set(true, forKey: "didLaunchBefore")
            currentPage = "onboardingView"
        } else {
            currentPage = "mainView"
        }
    }
    
    @Published var currentPage: String
    
}
