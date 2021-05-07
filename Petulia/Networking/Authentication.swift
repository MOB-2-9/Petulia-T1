//
//  Authentication.swift
//  Petulia
//
//  Created by Mohammed Drame on 5/6/21.
//  Copyright © 2021 Johandre Delgado . All rights reserved.
//

import Foundation
import FirebaseAuth

class Authentication {
  
  func logIn(email address: String, password secret: String) {
    Auth.auth().signIn(withEmail: address, password: secret) {  authResult, error in
      // user can't log in
      if error != nil {
        print(error)
      }
      // user sucessuflly log in ✅
      print(authResult?.user.email)
    }
  }
  
  func signUp(email address: String, password secret: String) {
    Auth.auth().createUser(withEmail: address, password: secret) {  authResult, error in
      if error != nil {
        print(error)
      }
      print(authResult?.user.email)
      // ...
    }
  }
  
  func logOut() {
    let firebaseAuth = Auth.auth()
    do {
      try firebaseAuth.signOut()
    } catch let signOutError as NSError {
      print ("Error signing out: %@", signOutError)
    }
    
  }
  
  
  
  
}
