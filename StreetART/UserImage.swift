//
//  UserImage.swift
//  StreetART
//
//  Created by George Allard on 25/05/2017.
//  Copyright © 2017 George Allard. All rights reserved.
//

import Foundation
import FirebaseDatabase

struct UserImage {
    
    let key: String!
    let pathToImage: String!
    
    let itemRef: FIRDatabaseReference?
    
    init(url:String, key:String) {
        self.key = key
        self.pathToImage = url
        self.itemRef = nil
    }
    
    init(snapshot:FIRDataSnapshot) {
        key = snapshot.key
        itemRef = snapshot.ref
        
        let snapshotValue = snapshot.value as? NSDictionary
        
        if let imageUrl = snapshotValue?["pathToImage"] as? String {
            pathToImage = imageUrl
        }else{
            pathToImage = ""
        }
        
    }
}

