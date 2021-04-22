//
//  OrganizationInfoView.swift
//  Petulia
//
//  Created by Anika Morris on 4/19/21.
//  Copyright © 2021 Johandre Delgado . All rights reserved.
//

import SwiftUI
import MessageUI

struct OrganizationInfoView: View {
  @EnvironmentObject var petDataController: PetDataController
  @EnvironmentObject var theme: ThemeManager
  @State private var collapsedAddress: Bool = true
  @State private var collapsedContact: Bool = true
  var organization: OrganizationDetailViewModel
  
  @State var result: Result<MFMailComposeResult, Error>? = nil
  @State private var showingMailView = false
  
  /// The delegate required by `MFMailComposeViewController`
  private let mailComposeDelegate = MailDelegate()
  
  /// The delegate required by `MFMessageComposeViewController`
  private let messageComposeDelegate = MessageDelegate()
  
  var body: some View {
    VStack {
      Text("\(organization.name)")
        .font(.title)
        .multilineTextAlignment(.center)
        .padding(.bottom, 2)
        .padding(.leading, 4)
        .padding(.trailing, 4)
      if organization.addressStreet != "Does not exist" {
        Text("\(organization.addressStreet)")
      }
      Text("\(organization.addressCity), \(organization.addressState)")
//        .font(.title2)
      HStack {
        if organization.phone != "Does not exist" {
          Button(action: {
            callPhone()
          }) {
            HStack(spacing: 10) {
              Text("Call")
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(.white)
              Image(systemName: "phone.fill")
                .foregroundColor(.white)
            }
            .padding()
            .background(theme.accentColor)
            .cornerRadius(6.0)
          }
        }
        Spacer()
        if organization.email != "Does not exist" {
          Button(action: {
            presentMailCompose()
          }) {
            HStack(spacing: 10) {
              Text("Email")
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(.white)
              Image(systemName: "paperplane.fill")
                .foregroundColor(.white)
            }
            .padding()
            .background(theme.accentColor)
            .cornerRadius(6.0)
          }
        }
      }
      .padding()
      NavigationLink(destination: OrganizationDetailView(petDataController: _petDataController, organization: organization)) {
        Text("View available animals")
      }
      .padding()
    }
  }
}

struct OrganizationInfoLoadingView: View {
  
  var body: some View {
    VStack {
      Text("Loading...")
        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
        .padding()
    }
  }
}

extension OrganizationInfoView {
  
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
    
    composeVC.setToRecipients([organization.email])
    
    vc?.present(composeVC, animated: true)
  }
  
  
  /// Phone Call
  func callPhone(){
    let telephone = "tel://"
    let formattedString = telephone + organization.phone
    guard let url = URL(string: formattedString) else { return }
    print(url)
    UIApplication.shared.open(url)
  }
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