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
    
    //var #imageLiteral(resourceName: "MapAnnotation") = MKPointAnnotation(
    
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
        
        
}

        
    @IBAction func addArt_TouchUpInside(_ sender: Any) {
        
        let alertController = UIAlertController(title: "Name of Art", message: "", preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Save", style: .default, handler: { _ in
            
            let artTextField = alertController.textFields![0] as UITextField
            let locationTextField = alertController.textFields![1] as UITextField
            let typeTextField = alertController.textFields![2] as UITextField
            
            
            let newArt = self.ref.childByAutoId()
            
            
            let myLocation: CLLocationCoordinate2D = (self.locationManager.location?.coordinate)!
            let annotation = MKPointAnnotation()
            annotation.coordinate = myLocation
            self.mapView.addAnnotation(annotation)
            
            annotation.title = "This is my annotation"
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
            textField.placeholder = "Enter Art Name"
        }
        
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Location"
        }
       
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Type"
        }



        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        
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
    
    
    
    
    
}
