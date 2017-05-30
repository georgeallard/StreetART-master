//
//  AddArtViewController.swift
//  StreetART
//
//  Created by George Allard on 30/05/2017.
//  Copyright © 2017 George Allard. All rights reserved.
//

import UIKit
import TextFieldEffects
import Firebase
import MapKit

class AddArtViewController: UIViewController {
    
     let locationManager = CLLocationManager()
    
    
    @IBOutlet weak var nameOfArt: HoshiTextField!
    
    @IBOutlet weak var locationOfArt: HoshiTextField!
    
    @IBOutlet weak var typeOfArt: HoshiTextField!
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func postArt(_ sender: Any) {
        
        
        
        
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
