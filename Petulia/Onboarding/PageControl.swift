//
//  PageControl.swift
//  Petulia
//
//  Created by Anika Morris on 5/13/21.
//  Copyright © 2021 Johandre Delgado . All rights reserved.
//
import Foundation
import UIKit
import SwiftUI

struct PageControl: UIViewRepresentable {
    
    var numPages: Int
    
    @Binding var currentPageIndex: Int
    
    func makeUIView(context: Context) -> UIPageControl {
        let control = UIPageControl()
        control.numberOfPages = numPages
        control.currentPageIndicatorTintColor = .systemPink
        control.pageIndicatorTintColor = .gray
        
        return control
    }
    
    func updateUIView(_ uiView: UIPageControl, context: Context) {
        uiView.currentPage = currentPageIndex
    }
}
