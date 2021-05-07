//
//  DropDownPicker.swift
//  Petulia
//
//  Created by Henry Calderon on 5/6/21.
//  Copyright © 2021 Johandre Delgado . All rights reserved.
//

import SwiftUI
//Used: https://levelup.gitconnected.com/creating-a-dropdown-picker-1067c509b327
struct DropDownPicker: View {
    
    var title: String
    @Binding var selection: Int
    var options: [String]
    
    @State private var showOptions: Bool = false
    
    var body: some View {
        ZStack {
            // Static row which shows user's current selection
            HStack {
                Text(title)
                Spacer()
                Text(options[selection])
                    .foregroundColor(Color.black.opacity(0.6))
                Image(systemName: "chevron.right")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 10, height: 10)
            }
            .font(Font.custom("Avenir Next", size: 16).weight(.medium))
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(Color.white)
            .onTapGesture {
                // show the dropdown options
                withAnimation(Animation.spring().speed(2)) {
                    showOptions = true
                }
            }
            
            // Drop down options
            if showOptions {
                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(Font.custom("Avenir Next", size: 16).weight(.semibold))
                        .foregroundColor(.black)
                    HStack {
                        Spacer()
                        ForEach(options.indices, id: \.self) { i in
                            if i == selection {
                                Text(options[i])
                                    .font(.system(size: 12))
                                    .padding(.vertical, 8)
                                    .padding(.horizontal, 12)
                                    .background(Color.gray.opacity(0.2))
                                    .cornerRadius(4)
                                    .onTapGesture {
                                        // hide dropdown options - user selection didn't change
                                        withAnimation(Animation.spring().speed(2)) {
                                            showOptions = false
                                        }
                                    }
                            } else {
                                Text(options[i])
                                    .font(.system(size: 12))
                                    .onTapGesture {
                                        // update user selection and close options dropdown
                                        withAnimation(Animation.spring().speed(2)) {
                                            selection = i
                                            showOptions = false
                                        }
                                    }
                            }
                            Spacer()
                        }
                    }
                    .padding(.vertical, 2)
                    .transition(AnyTransition.move(edge: .top).combined(with: .opacity))
                    
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(Color.white)
                .foregroundColor(.black)
                .transition(.opacity)
                
            }
            
        }
    }
}
