//
//  MapView.swift
//  Petulia
//
//  Created by Henry Calderon on 4/29/21.
//  Copyright © 2021 Johandre Delgado . All rights reserved.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
  var address: String
  @State private var coordinate = CLLocationCoordinate2D()
    
    func makeUIView(context: Context) -> MKMapView {
        MKMapView(frame: .zero)
    }
  
  func updateUIView(_ view: MKMapView, context: Context) {
    coordinates(forAddress: address){
      (location) in
      guard let location = location else {
        // Handle error here.
        return
      }
      coordinate = location
      //      openMapForPlace(lat: location.latitude, long: location.longitude)
    }
    let span = MKCoordinateSpan(latitudeDelta: 2.0, longitudeDelta: 2.0)
    let region = MKCoordinateRegion(center: coordinate, span: span)
    //      let setRegion =
    view.setRegion(region, animated: true)
  }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(address: "Redwood City")
    }
}

extension MapView{
  func coordinates(forAddress address: String, completion: @escaping (CLLocationCoordinate2D?) -> Void) {
    let geocoder = CLGeocoder()
    geocoder.geocodeAddressString(address) {
      (place, error) in
      guard error == nil else {
        print("Geocoding error: \(error!)")
        completion(nil)
        return
      }
      completion(place?.first?.location?.coordinate)
    }
  }
  
//  coordinates(forAddress: "YOUR ADDRESS") {
//    (location) in
//    guard let location = location else {
//      // Handle error here.
//      return
//    }
//    coordinate = location
//    //      openMapForPlace(lat: location.latitude, long: location.longitude)
//  }
  
  
}
