//
//  PageViewController.swift
//  Petulia
//
//  Created by Anika Morris on 5/13/21.
//  Copyright © 2021 Johandre Delgado . All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

struct PageViewController: UIViewControllerRepresentable {
    
    @Binding var currentPageIndex: Int
    var viewControllers: [UIViewController]
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIViewController(context: Context) -> UIPageViewController {
        let pageViewController = UIPageViewController(
            transitionStyle: .scroll, navigationOrientation: .horizontal)
        
        pageViewController.dataSource = context.coordinator
        pageViewController.delegate = context.coordinator
        
        return pageViewController
    }
    
    func updateUIViewController(_ pageViewController: UIPageViewController, context: Context) {
        pageViewController.setViewControllers([viewControllers[currentPageIndex]], direction: .forward, animated: true)
    }
    
    
    class Coordinator: NSObject, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
        
        var parent: PageViewController
        
        init(_ pageViewController: PageViewController) {
            self.parent = pageViewController
        }
        
        func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
            
            // retrieve the index of the current VC
            guard let index = parent.viewControllers.firstIndex(of: viewController) else {
                return nil
            }
            
            if index != parent.viewControllers.lastIndex(of: viewController) {
                return parent.viewControllers[index - 1]
            } else {
                return parent.viewControllers[index]
            }
        }
        
        func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
            
            // retrieve the index of the current VC
            guard let index = parent.viewControllers.firstIndex(of: viewController) else {
                return nil
            }
            
            // show the VC when the user swipes forward unless they're on the last VC
            if index != parent.viewControllers.lastIndex(of: viewController) {
                return parent.viewControllers[index + 1]
            } else {
                return parent.viewControllers[index]
            }
        }
        
        func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
            if completed,
                let visibleViewController = pageViewController.viewControllers?.first,
                let index = parent.viewControllers.firstIndex(of: visibleViewController)
            {
                parent.currentPageIndex = index
            }
        }
    }
    
}
