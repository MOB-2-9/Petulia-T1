//
//  PetDetailView.swift
//  Petulia
//
//  Created by Johandre Delgado on 20.11.2020.
//  Copyright © 2020 Johandre Delgado . All rights reserved.
//

import SwiftUI
import Foundation
import MessageUI

struct PetDetailView: View {
  
  var viewModel: PetDetailViewModel
  @EnvironmentObject var favorites: FavoriteController
  @EnvironmentObject var theme: ThemeManager // to pass to sheets.
  @AppStorage(Keys.isDark) var isDark = false
  
  @State private var showAdoptionForm: Bool = false
  @State private var zoomingImage = false
  
  @State var result: Result<MFMailComposeResult, Error>? = nil
  @State private var showingMailView = false
  
  var body: some View {
    ScrollView(.vertical, showsIndicators: false) {
      VStack {
        stretchingHeroView()
        
        VStack(alignment: .leading) {
          HStack {
            Text("Details")
              .font(.title2)
              .fontWeight(.light)
            Spacer()
          }
          .padding()
          
          characteristicScrollView()
          
          descriptionView()
            .padding()
          Spacer()
        }
      }
    }
    .navigationBarTitle("", displayMode: .inline)
  }
}

private extension PetDetailView {
  
  // MARK: - COMPONENTS
  func stretchingHeroView() -> some View {
    StretchingHeader {
      ZStack(alignment: .bottom) {
        LinearGradient(
          gradient: Gradient(colors: [Color.accentColor, Color.accentColor.opacity(0.8)]),
          startPoint: .bottom,
          endPoint: .top
        )
        
        favoriteBar()
          .offset(y: 40)
        
        VStack {
          Spacer(minLength: 100)
          heroExpandableImage()
          Spacer()
          
          Text(viewModel.name)
            .font(.title2)
            .fontWeight(.light)
            .lineLimit(2)
            .multilineTextAlignment(.center)
            .padding(.horizontal)
        }
        .padding(.bottom, 70)
        .foregroundColor(.white)
      }
    }
    .frame(height: 320)
  }
  
  func favoriteBar() -> some View {
    ZStack(alignment: .top) {
      Color(UIColor.systemBackground)
        .frame(height: 100)
        .cornerRadius(30)
      
      Color.accentColor
        .frame(width: 80, height: 5)
        .cornerRadius(2.5)
        .padding()
        .padding(.top, 20)
      
      HStack {
        if !viewModel.distance.isEmpty {
          Label(viewModel.distance, systemImage: "map.fill")
            .padding(.leading)
            .foregroundColor(.gray)
        }
        Spacer()
        Button(action: {
          favorites.swipeBookmark(for: viewModel)
        }) {
          Image(systemName: "heart.circle.fill")
            .font(.system(size: 30))
            .padding()
            .foregroundColor(favorites.isFavorite(pet: viewModel) ? .accentColor : .gray)
        }
      }
    }
  }
  
  func heroExpandableImage() -> some View {
    AsyncImageView(
      urlString: viewModel.defaultImagePath(for: .medium),
      placeholder: "no-image",
      maxWidth: .infinity
    )
    .scaledToFit()
    .clipShape(Circle())
    .onTapGesture {
      zoomingImage.toggle()
    }
    .sheet(isPresented: $zoomingImage) {
      AsyncGalleryView(title: viewModel.name, imagePaths: viewModel.imagePaths, accentColor: theme.accentColor, showing: $zoomingImage)
        .foregroundColor(.primary)
        .preferredColorScheme(isDark ? .dark : .light)
    }
  }
  
  func characteristicScrollView() -> some View {
    ScrollView(.horizontal, showsIndicators: false) {
      HStack {
        ForEach(viewModel.characteristics.filter { $0.title.lowercased() != "unknown"}, id: \.id) { info in
          Color.blue
            .frame(width: 100, height: 100)
            .cornerRadius(30)
            .overlay(
              VStack {
                Text(info.title.capitalized).fontWeight(.bold)
                  .minimumScaleFactor(0.9)
                  .lineLimit(1)
                  .padding(.horizontal, 5)
                Text(info.label.lowercased()).fontWeight(.light)
              }
              .foregroundColor(.white)
            )
        }
      }
      .padding(.horizontal)
    }
  }
  
  func descriptionView() -> some View {
    VStack(alignment: .leading) {
      Text(viewModel.description.tagsCleaned)
        .font(.body)
        .fontWeight(.light)
      
      VStack {
        Text("Reported breed: ")
          .font(.body)
          .fontWeight(.light)
          +
          Text("\(viewModel.breed)")
          .font(.body)
          .fontWeight(.bold)
      }
      .padding(.top)
      
      // tags + attributes
      VStack(alignment: .leading) {
        ForEach(viewModel.tags, id: \.self) { tag in
          HStack {
            Image(systemName: "checkmark.circle.fill")
              .foregroundColor(Color.green)
            Text(tag.lowercased())
          }
        }
        
        ForEach(viewModel.cleanedAttributes, id: \.self) { att in
          HStack {
            Image(systemName: "checkmark.circle.fill")
              .foregroundColor(Color.green)
            Text(att.lowercased())
          }
        }
      }
      .foregroundColor(.secondary)
      .padding(.vertical,8)
      
    }
  }
  
}

// MARK: - PREVIEWS
struct PetDetailView_Previews: PreviewProvider {
  
  static var previews: some View {
    PetDetailView(viewModel: PetDetailViewModel(model: Animal.getAnAnimal()))
      .environmentObject(FavoriteController())
      .environmentObject(ThemeManager())
  }
}
