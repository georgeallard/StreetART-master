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
    
    //var #imageLiteral(resourceName: "MapAnnotation") = MKPointAnnotation(
    
      let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mapView.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
        mapView.userTrackingMode = .follow
        
        
}

        
    @IBAction func addArt_TouchUpInside(_ sender: Any) {
        
        
        
       // let artLocation = FIRDatabase.database().reference(withPath: "artSpot")
        
        let myLocation: CLLocationCoordinate2D = (locationManager.location?.coordinate)!
        let annotation = MKPointAnnotation()
        annotation.coordinate = myLocation
        mapView.addAnnotation(annotation)
        
        annotation.title = "This is my annotation"
        self.mapView.addAnnotation(annotation)
        
        //artLocation.setValue(["location": locationManager.location?.coordinate])

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