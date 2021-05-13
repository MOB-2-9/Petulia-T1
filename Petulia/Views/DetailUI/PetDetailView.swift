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
import MapKit

struct PetDetailView: View{
  
  var viewModel: PetDetailViewModel
  @EnvironmentObject var favorites: FavoriteController
  @EnvironmentObject var theme: ThemeManager // to pass to sheets.
  @AppStorage(Keys.isDark) var isDark = false
  
  @State private var showAdoptionForm: Bool = false
  @State private var zoomingImage = false
  @State private var isSharePresented: Bool = false
  
  @State var result: Result<MFMailComposeResult, Error>? = nil
  @State private var showingMailView = false
  
  /// The delegate required by `MFMailComposeViewController`
  private let mailComposeDelegate = MailDelegate()
  
  /// The delegate required by `MFMessageComposeViewController`
  private let messageComposeDelegate = MessageDelegate()
  
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
            Menu {
              if let unwrappedPhone = viewModel.contact.phone {
                Button(unwrappedPhone, action: callPhone)
              } else {
                Text("No Number")
              }
              
              if let unwrappedEmail = viewModel.contact.email {
                Button(unwrappedEmail, action: presentMailCompose)
              } else {
                Text("No Email")
              }
            } label: {
              Label("Contact", systemImage: "paperplane")
            }
            .padding(.trailing, 10)
            shareResult()
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
        if let code = viewModel.contact.address?.postcode{
          MapView(address: code)
        }else{
          LinearGradient(
            gradient: Gradient(colors: [Color.accentColor, Color.accentColor.opacity(0.8)]),
            startPoint: .bottom,
            endPoint: .top
          )
        }
        
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
        if viewModel.isMixed == true{
          Text("Secondary breed: ")
            .font(.body)
            .fontWeight(.light)
            +
            Text("\(viewModel.breedSecond)")
            .font(.body)
            .fontWeight(.bold)
        }
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
  
  func shareResult() -> some View {
    Button(action: {
      self.isSharePresented = true
    }) {
      Label("Share", systemImage: "arrow.up.square")
    }
    .sheet(isPresented: $isSharePresented, onDismiss: {
      print("Dismiss")
    }, content: {
      let items: [Any] = [petInfoToString(), viewModel.url]
      ActivityViewController(activityItems: items)
    })
  }
  
  //MARK: Helper for share result
  func petInfoToString() -> String {
    var items: String = "Help them find a home 💚\n\(viewModel.name) is a \(viewModel.breed) \(viewModel.species)\n"
    guard let phone = viewModel.contact.phone else { return items }
    items.append("Phone: \(phone)\n")
    return items
  }
  
}

extension PetDetailView{
  //MARK: - Contact
  
  /// Delegate for view controller as `MFMailComposeViewControllerDelegate`
  private class MailDelegate: NSObject, MFMailComposeViewControllerDelegate {
    
    func mailComposeController(_ controller: MFMailComposeViewController,
                               didFinishWith result: MFMailComposeResult,
                               error: Error?) {
//      Customize Here
      controller.dismiss(animated: true)
    }
    
  }
  
  /// Present an mail compose view controller modally in UIKit environment
  private func presentMailCompose() {
    guard MFMailComposeViewController.canSendMail() else {
      return
    }
    let vc = UIApplication.shared.keyWindow?.rootViewController
    
    let composeVC = MFMailComposeViewController()
    composeVC.mailComposeDelegate = mailComposeDelegate
    
    composeVC.setToRecipients([viewModel.contact.email!])
    
    vc?.present(composeVC, animated: true)
  }
  
  
  /// Phone Call
  func callPhone(){
    let telephone = "tel://"
    let formattedString = telephone + viewModel.contact.phone!
    guard let url = URL(string: formattedString) else { return }
    print(url)
    UIApplication.shared.open(url)
  }
}

extension PetDetailView {
  
  /// Delegate for view controller as `MFMessageComposeViewControllerDelegate`
  private class MessageDelegate: NSObject, MFMessageComposeViewControllerDelegate {
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
      // Customize here
      controller.dismiss(animated: true)
    }
    
  }
  
  /// Present an message compose view controller modally in UIKit environment
  private func presentMessageCompose() {
    guard MFMessageComposeViewController.canSendText() else {
      return
    }
    let vc = UIApplication.shared.keyWindow?.rootViewController
    
    let composeVC = MFMessageComposeViewController()
    composeVC.messageComposeDelegate = messageComposeDelegate
    
//    Customize Here
    
    vc?.present(composeVC, animated: true)
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
