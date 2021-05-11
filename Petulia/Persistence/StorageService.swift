//
//  StorageService.swift
//  cards
//
//  Created by Johandre Delgado  on 24.12.2019.
//  Copyright © 2019 Johandre Delgado . All rights reserved.
//

import Foundation
import FirebaseStorage

/// Provides type save names for files in the disk or bundle
enum FileName: String {
  case favorites = "favorites.json"
  case categories = "categories.json"
  case badges = "badges.json"
}

class StorageService {
  
  //  MARK:  - FROM APP BUNDLE
  func loadFromBundle<T: Decodable>(_ filename: FileName) -> T {
    let data: Data
    
    guard let file = Bundle.main.url(forResource: filename.rawValue, withExtension: nil)
    else {
      fatalError("\n❌ \(#function) - Couldn't find \(filename) in main bundle.")
    }
    
    do {
      data = try Data(contentsOf: file)
    } catch {
      fatalError("\n❌ \(#function) - Couldn't load \(filename) from main bundle:\n\(error)")
    }
    
    do {
      let decoder = JSONDecoder()
      return try decoder.decode(T.self, from: data)
    } catch {
      fatalError("\n❌ \(#function) - Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
  }
  
  
  // MARK:  - LOADING OBJECT FROM DEVICE FILE SYSTEM
  func loadFromDevice<T: Decodable>(named fileName: FileName, as type: T.Type) -> T? {
    do {
      let fileURL = try FileManager.default
        .url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        .appendingPathComponent(fileName.rawValue)
      print("\n\(#function) - Loading OBJECT from device. Path: \(fileURL.path)")
      
      let data = try Data(contentsOf: fileURL)
      let swiftObject = try JSONDecoder().decode(T.self, from: data)
      return swiftObject
    } catch {
      print("❌ \(#function) - Loading OBJECT Error: \(error)")
    }
    return nil
  }
  
  
  
  // MARK:  - SAVING TO FILE SYSTEM
  func saveToDevice<T: Encodable>(_ swiftObject: T, to fileName: FileName) {
    let storage = Storage.storage()
    let storageRef = storage.reference()
    
    print("\n\(#function) -  Saving - \(fileName.rawValue) - to device.")
    
    do {
      let fileURL = try FileManager.default.url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        .appendingPathComponent(fileName.rawValue)
      print("Saving in path: \(fileURL.path)")
      try JSONEncoder().encode(swiftObject)
        .write(to: fileURL)
      sleep(2)
      let localFile = try URL(resolvingAliasFileAt: fileURL)
      print("File Address \(localFile)")
        let file_to_be_uploaded = storageRef.child(fileURL.path)
        let uploadTask = file_to_be_uploaded.putFile(from: localFile, metadata: nil) { metadata, error in
          guard let metadata = metadata else {
            // Uh-oh, an error occurred!
            return
          }
          // Metadata contains file metadata such as size, content-type.
          let size = metadata.size
          // You can also access to download URL after upload.
          file_to_be_uploaded.downloadURL { (url, error) in
            guard let downloadURL = url else {
              // Uh-oh, an error occurred!
              return
            }
          
        }
      }
      
      
    } catch {
      print("❌ \(#function) - Saving error: \(error)")
    }
  }
  
  
}
