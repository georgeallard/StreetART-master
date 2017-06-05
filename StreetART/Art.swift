//
//  MapPin.swift
//  StreetART
//
//  Created by George Allard on 25/05/2017.
//  Copyright © 2017 George Allard. All rights reserved.
//

import Foundation
import FirebaseDatabase
import CoreLocation

class art {
    
    let coordinate: CLLocationCoordinate2D!
    var name: String!
    var location: String!
    var type: String!
    var ref: FIRDatabaseReference?
   
    
    
    var description: String {
        return "This art is  \(name!) \(location!)"
    }
    
    init(snapshot: FIRDataSnapshot) {
        
        let snapshotValue = snapshot.value as! [String: Any]
        
        ref = snapshot.ref
        
        name = snapshotValue["name"] as! String
        
        location = snapshotValue["location"] as! String
        
        coordinate = CLLocationCoordinate2D(latitude: snapshotValue["lat"] as! Double, longitude: snapshotValue["lng"] as! Double)
        
       // type = snapshotValue["type"] as! String
       

  

    
}
