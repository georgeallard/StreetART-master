//
//  MapPinViewController.swift
//  StreetART
//
//  Created by George Allard on 15/05/2017.
//  Copyright © 2017 George Allard. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import Firebase


class MapPinViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var addArt: UIBarButtonItem!
    @IBOutlet weak var mapView: MKMapView!
    
    var ref = FIRDatabase.database().reference().child("art")
    
    var annotation = MKAnnotationView()
    
    var artDrops = [art]()

    var pointAnnotation = MKPointAnnotation()
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let logo = UIImage(named: "streetARNAV")
        let imageView = UIImageView(image: logo)
        self.navigationItem.titleView = imageView

        mapView.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
        mapView.userTrackingMode = .follow
        
       // loadCustomLocations()
        
        let ArtIcon = MKPointAnnotation()
        
        mapView.addAnnotation(ArtIcon)
        
        
    }
 
    override func viewDidAppear(_ animated: Bool) {
          //  self.loadCustomLocations()
    }
        


        
    @IBAction func addArt_TouchUpInside(_ sender: Any) {
        
        let alertController = UIAlertController(title: "Tag Some Art", message: "Tag local art for all users to see!", preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Save", style: .default, handler: { _ in
            
            let artTextField = alertController.textFields![0] as UITextField
            let locationTextField = alertController.textFields![1] as UITextField
            let typeTextField = alertController.textFields![2] as UITextField
            
            
            let newArt = self.ref.childByAutoId()
            
            
            let myLocation: CLLocationCoordinate2D = (self.locationManager.location?.coordinate)!
            
            let annotation = MKPointAnnotation()
            
            annotation.coordinate = myLocation
            
            self.mapView.addAnnotation(annotation)
            
            let newArtData: [String: Any] = [
                "name": artTextField.text!,
                "location": locationTextField.text!,
                "Type": typeTextField.text!,
                "lat": myLocation.latitude,
                "lng": myLocation.longitude
            ]
           
            newArt.setValue(newArtData)
            
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: { _ in })

        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Description"

            textField.keyboardAppearance = .dark
            textField.keyboardType = .default
            textField.autocorrectionType = .default
            textField.clearButtonMode = .whileEditing
            textField.textColor = UIColor.black
        }
        
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Whereabouts?"
            
            textField.keyboardAppearance = .dark
            textField.keyboardType = .default
            textField.autocorrectionType = .default
            textField.clearButtonMode = .whileEditing
            textField.textColor = UIColor.red
        }
       
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "What Type?"
            
            textField.keyboardAppearance = .dark
            textField.keyboardType = .default
            textField.autocorrectionType = .default
            textField.clearButtonMode = .whileEditing
            textField.textColor = UIColor.black
        }



        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        alertController.view.tintColor = UIColor.black  // change text color of the buttons
        alertController.view.backgroundColor = UIColor.white  // change background color
        alertController.view.layer.cornerRadius = 45   // change corner radius
        
        self.present(alertController, animated: true, completion: nil)
        
        
        
        
        
        
    }
    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !(annotation is MKUserLocation) else {
            return nil
        }
        
        let annotationIdentifier = "Identifier"
        var annotationView: MKAnnotationView?
        if let dequeuedAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationIdentifier) {
            annotationView = dequeuedAnnotationView
            annotationView?.annotation = annotation
        }
        else {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
            annotationView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        
        if let annotationView = annotationView {
            
            annotationView.canShowCallout = true
            annotationView.image = UIImage(named: "MapAnnotation")
        }
        return annotationView
        
        

    }
    
    
    
    
    
//    func CreateAnnotation(artDrops: art) {
//        
//        
//        let point = artDrops()
//        
//        point.name = art.name
//        
//        point.coordinate = art.coordinate
//        
//        point.location = art.location
//        
//        point.type = art.type
//        
//        mapView.addAnnotation(point as! MKAnnotation)
//        
//        mapView.selectAnnotation(point as! MKAnnotation, animated: true)
//        
//    }
//    
//
//    
////    func loadCustomLocations() {
////        
////        ref.observe(.childAdded, with: { snapshot in
////            
////            let lat = (snapshot.value as AnyObject!)!["lat"] as! String!
////            let lng = (snapshot.value as AnyObject!)!["lg"] as! String!
////            let name = (snapshot.value as AnyObject!)!["name"] as! String!
////            let type = (snapshot.value as AnyObject!)!["type"] as! String!
////            let location = (snapshot.value as AnyObject!)!["location"] as! String!
////            
////            let annotation = addAnno(name: name!, coordinate: CLLocationCoordinate2D(latitude: lat!, longitude: lng!), type: type!, location: location!)
////            
////            //my annotationView is my custom class for annotations.
////            self.mapView.addAnnotation(self.addAnno as MKAnnotation)
////            
////            print(snapshot)
////            
////        })}
////        
////        
////        
////        
////        
////        
////    }
//
//    
//    
//    func loadCustomLocations() {
//        
//        FIRDatabase.database().reference(withPath: "art")
//        
//        let artLoc = FIRDatabase.database().reference(withPath: "art")
//        
//        artLoc.observe(.value, with: { snapshot in
//            
//            
//            for item in snapshot.children {
//                guard let snapshot = item as? FIRDataSnapshot else { continue }
//                
//                let ref = art(snapshot: snapshot)
//                
//                print(snapshot)
//                
//                self.artDrops.append(ref)
//                
//                self.CreateAnnotation(artDrops: art)
//                
//            }
//        })
//    }

}
