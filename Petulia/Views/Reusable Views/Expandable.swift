//
//  Expandable.swift
//  Petulia
//
//  Created by Anika Morris on 4/19/21.
//  Copyright © 2021 Johandre Delgado . All rights reserved.
//  Thanks to this article in Better Programming: https://betterprogramming.pub/how-to-write-a-collapsible-expandable-view-for-your-swiftui-app-d4a47fe8cb52
//

import SwiftUI

struct Expandable<Content: View>: View {
    @State var label: () -> Text
    @State var content: () -> Content
    
    @State private var collapsed: Bool = true
    
    var body: some View {
        VStack {
            Button(
                action: { self.collapsed.toggle() },
                label: {
                    HStack {
                        self.label()
                        Spacer()
                        Image(systemName: self.collapsed ? "chevron.right" : "chevron.up")
                    }
                    .padding(.bottom, 1)
                    .background(Color.white.opacity(0.01))
                }
            )
            .buttonStyle(PlainButtonStyle())
            
            VStack {
                self.content()
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: collapsed ? 0 : .none)
            .clipped()
            .animation(.easeOut)
            .transition(.slide)
        }
    }
}

struct Expandable_Previews: PreviewProvider {
    static var previews: some View {
      Expandable(label: { Text("Expandable") }, content: { Text("Content")})
    }
}
