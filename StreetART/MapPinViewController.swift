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
        
//        openMapForPlace()
        
        addAnnotation()
        
        let artAnnotation = MKPointAnnotation()
        
        var art = [CLLocation]()
        
         dropNewPins()
    
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
        
        
        self.mapView.delegate = self
        
        let banksyArt = CLLocationCoordinate2DMake(51.5661120, -0.1356330)
        // Drop a pin
        let dropPin = MKPointAnnotation()
        dropPin.coordinate = banksyArt
        dropPin.title = "Banksy"
        dropPin.subtitle = "Manson hitchiker"
        mapView.addAnnotation(dropPin)
        
        let newBanksy = CLLocationCoordinate2DMake(51.5171150, -0.1353340)
        // Drop a pin
        let dropPinn = MKPointAnnotation()
        dropPinn.coordinate = newBanksy
        dropPinn.title = "Banksy"
        dropPinn.subtitle = "Banksy One Nation Under CCTV"
        mapView.addAnnotation(dropPinn)
        
        let newestBanksy = CLLocationCoordinate2DMake(51.5886853,-0.2766477)
        // Drop a pin
        let dropPinnn = MKPointAnnotation()
        dropPinnn.coordinate = newestBanksy
        dropPinnn.title = "Banksy"
        dropPinnn.subtitle = "Banksy One Nation Under CCTV"
        mapView.addAnnotation(dropPinnn)
        
        let newesttBanksy = CLLocationCoordinate2DMake(51.589621,-0.19643)
        // Drop a pin
        let dropPinnnn = MKPointAnnotation()
        dropPinnnn.coordinate = newesttBanksy
        dropPinnnn.title = "Banksy"
        dropPinnnn.subtitle = "First Graffiti!"
        mapView.addAnnotation(dropPinnnn)
        
        let newesttBanksy = CLLocationCoordinate2DMake(51.439158, -2.584531)
        // Drop a pin
        let dropPinnnnn = MKPointAnnotation()
        dropPinnnnn.coordinate = newesttBanksy
        dropPinnnnn.title = "Banksy"
        dropPinnnnn.subtitle = "First Graffiti!"
        mapView.addAnnotation(dropPinnnnn)
        
   
        
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
    
    
    
//    func openMapForPlace() {
//        
//        let regionDistance:CLLocationDistance = 1000
//        
//        let coordinate = artDrops
//        
//        let regionSpan = MKCoordinateRegionMakeWithDistance(coordinate!, regionDistance, regionDistance)
//        
//        let options = [
//            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
//            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
//        ]
//        
//        let placemark = MKPlacemark(coordinate: coordinate!, addressDictionary: nil)
//        
//        let mapItem = MKMapItem(placemark: placemark)
//        
//        mapItem.name = art.name
//        
//        mapItem.openInMaps(launchOptions: options)
//    }
//    
    
    
    
    
    
}

    

    
    
    
    
    
