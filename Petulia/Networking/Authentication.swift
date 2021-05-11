//
//  Authentication.swift
//  Petulia
//
//  Created by Mohammed Drame on 5/6/21.
//  Copyright © 2021 Johandre Delgado . All rights reserved.
//

import Foundation
import FirebaseAuth


struct User {
  var email: String
}

//enum Result<T> {
//  case success(T)
//  case failure(Error)
//}



class Authentication {
  
  func logIn(email address: String, password secret: String, sucessfull: @escaping (Bool) -> Void ) {
    Auth.auth().signIn(withEmail: address, password: secret) {  authResult, error in
      // user can't log in
      if error != nil {
        sucessfull(false)
        return
      }
      // user sucessuflly log in ✅
      print(authResult?.user.email)
      sucessfull(true)
    }
    
  }
  
  func signUp(email address: String, password secret: String, sucessfull: @escaping (Bool) -> Void) {
    Auth.auth().createUser(withEmail: address, password: secret) {  authResult, error in
      if error != nil {
        sucessfull(false)
        return
      }
      print(authResult?.user.email)
      sucessfull(true)
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
