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
      
        
        let ArtIcon = MKPointAnnotation()
        
        mapView.addAnnotation(ArtIcon)
        
        loadCustomLocations()
        
       dropNewPins()
        
        addAnnotation()
        
        let artAnnotation = MKPointAnnotation()
        
        var art = [CLLocation]()
        
     
    
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


 
    func addAnnotation() {
        
        let artAnnotation = MKPointAnnotation()
        
        
        print(artDrops)
        
        
        for location in artDrops {
            
            
            artAnnotation.coordinate = location.coordinate
            
            artAnnotation.title = location.name
            
            artAnnotation.subtitle = location.location
            
            mapView.addAnnotations([artAnnotation])
            
                   }
    
        
    }
    
    
   
    func dropNewPins() {
        
    
        
        let locations = [
            ["title": "Banksy", "subtitle": "Manson hitchiker",     "latitude": 51.5661120, "longitude": -0.1356330],
            ["title": "Banksy", "subtitle": "Banksy One Nation Under CCTV",     "latitude": 51.5171150, "longitude": -0.1353340],
            ["title": "Banksy", "subtitle": "First Graffiti!",     "latitude": 51.5886853, "longitude": -0.2766477],
            ["title": "Banksy", "subtitle": "Rat",     "latitude": 51.439158, "longitude":-2.584531],
            ["title": "Monkey Smoking", "subtitle": "On the Iron Bridge",     "latitude": 51.449185, "longitude":-2.848594],
            ["title": "Desire", "subtitle": "The new world",     "latitude": 53.924803, "longitude":-0.669346],
            ["title": "MagiK", "subtitle": "Amazing Spider",     "latitude": 55.749766, "longitude":-4.179483],
            ["title": "Light", "subtitle": "Calligraphy",     "latitude": 53.895687, "longitude":-7.991744],
            ["title": "SkepT", "subtitle": "Nature",     "latitude": 51.969072, "longitude":-8.222462],
            ["title": "Mural", "subtitle": "Art Bomb",     "latitude": 53.157737, "longitude":-1.169244],
            ["title": "Amazing Wall", "subtitle": "Wolves in Grey",     "latitude": 41.588045, "longitude":-75.480776],
            ["title": "Digital Lights", "subtitle": "Light art hanging from Tree",     "latitude": 16.280152, "longitude":-88.875459],
            ["title": "Banksy", "subtitle": "Monkey Face",     "latitude": 50.743680, "longitude":-1.883553],
            ["title": "Buffalo", "subtitle": "Cool Illustrations",     "latitude": 50.735466, "longitude":-1.897341],
            ["title": "Nice Graff", "subtitle": "Desire To Be on Wall",     "latitude": 50.734030, "longitude":-1.877047],
            ["title": "Pier Graff", "subtitle": "Micky Loves Ya on pier stand",     "latitude": 50.715562, "longitude":-1.875386]
            
        ]
        
        for location in locations {
            let annotation = MKPointAnnotation()
            annotation.title = location["title"] as? String
            annotation.subtitle = location["subtitle"] as? String
            annotation.coordinate = CLLocationCoordinate2D(latitude: location["latitude"] as! Double, longitude: location["longitude"] as! Double)
            mapView.addAnnotation(annotation)
        }
        
    }
    
   
    

    func loadCustomLocations() {
        
        FIRDatabase.database().reference(withPath: "art")
        
        let artPin = FIRDatabase.database().reference(withPath: "art")
        
        artPin.observe(.value, with: { snapshot in
            
            
            for item in snapshot.children {
                guard let snapshot = item as? FIRDataSnapshot else { continue }
                
                let ref = art(snapshot: snapshot)
                
               // print(snapshot)
                
                self.artDrops.append(ref)
                
            }
            
            self.addAnnotation()
            
        })
    }
    
  
//    
//    func  openInMaps() {
//        
//        
//        let regionDistance:CLLocationDistance = 1000
//
//        let coordinates = art.coordinate
//        
//        let regionSpan = MKCoordinateRegionMakeWithDistance(coordinates!, regionDistance, regionDistance)
//        
//        let options = [
//            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
//            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
//        ]
//        
//        let placemark = MKPlacemark(coordinate: coordinates!, addressDictionary: nil)
//        
//        let mapItem = MKMapItem(placemark: placemark)
//        
//        mapItem.name = art.name
//        
//        mapItem.openInMaps(launchOptions: options)
//        
//      
//     
//        }
    
        
        
        
      
        }








    
