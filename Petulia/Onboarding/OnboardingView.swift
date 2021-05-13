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
        UIHostingController(rootView: ImageSubview(imageString: "cat2")),
        UIHostingController(rootView: ImageSubview(imageString: "duck")),
        UIHostingController(rootView: ImageSubview(imageString: "dog2"))
    ]
        
    var captions:[String] = ["Search lovable pets", "Find someone near you", "Adopt a lifelong friend!"]
    
    @State var currentPageIndex = 0
    var body: some View {
        NavigationView {
            VStack() {
                PageViewController(currentPageIndex: $currentPageIndex, viewControllers: subviews)
                    .frame(height: 500)
                Group {
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
                        NavigationLink(destination: MainView()) {
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
            .navigationBarTitle("Petulia")
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
