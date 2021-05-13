//
//  OnboardingView.swift
//  Petulia
//
//  Created by Anika Morris on 5/13/21.
//  Copyright © 2021 Johandre Delgado . All rights reserved.
//

import SwiftUI

struct OnboardingView: View {
    
    var subviews = [
        UIHostingController(rootView: ImageSubview(imageString: "ordering")),
            UIHostingController(rootView: ImageSubview(imageString: "cooking")),
            UIHostingController(rootView: ImageSubview(imageString: "breakfast"))
        ]
        
    var captions:[String] = ["Search lovable pets", "Find someone near you", "Adopt a lifelong friend!"]
    var captios:[String] = []
    
    @State var currentPageIndex = 0
    var body: some View {
        NavigationView {
            VStack() {
                PageViewController(currentPageIndex: $currentPageIndex, viewControllers: subviews)
                    .frame(height: 500)
                Group {
    //                Text(titles[currentPageIndex])
    //                    .font(.title)
                    Text(captions[currentPageIndex])
                        .font(.system(.largeTitle, design: .rounded))
        //                .foregroundColor(.gray)
                        .frame(width: 300, height: 100, alignment: .leading)
                        .lineLimit(nil)
                }
                    .padding()
                HStack {
                    PageControl(numPages: subviews.count, currentPageIndex: $currentPageIndex)
                    Spacer()
                    if self.currentPageIndex+1 == self.subviews.count {
                        NavigationLink(destination: LoginView()) {
                            ButtonContent()
                        }
                    } else {
                        Button(action: {
                            self.currentPageIndex += 1
                        }) {
                            ButtonContent()
                        }
                    }
                    
                }
                    .padding()
            }
            .navigationBarTitle("Breakfast Box")
        }
    }
}

struct ButtonContent: View {
    var body: some View {
        Image(systemName: "arrow.right")
            .resizable()
            .foregroundColor(.white)
            .frame(width: 30, height: 30)
            .padding()
            .background(Color.orange)
            .cornerRadius(30)
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
