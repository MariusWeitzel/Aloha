//
//  MapController.swift
//  Aloha
//
//  Created by Medien on 10.11.14.
//  Copyright (c) 2014 Medien. All rights reserved.
//

import Foundation

import UIKit

class MapController: UIViewController, CLLocationManagerDelegate{//,  GMSMapViewDelegate {
    
    
    
    
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var mapPin: UIImageView!
    
    @IBOutlet weak var pinImageVerticalConstraint: NSLayoutConstraint!
    var searchedTypes = ["Very Worse", "Worse", "Not Bad", "Good", "Very Good"]
    
    let locationManager = CLLocationManager()
    var marker = GMSMarker()
    
    override func viewDidLoad() {
      
        super.viewDidLoad()
        
        // erfragt den Zugriff auch Lokalisierung
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
        // erzeugt Marker
        marker.position = mapView.camera.target
        marker.snippet = "Hello World"
        marker.icon = UIImage(named: "icon_me")

        marker.appearAnimation = kGMSMarkerAnimationPop
        marker.map = mapView
        
       
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    // Ändert die Map Ansicht
    @IBAction func mapTypeChoice(sender: AnyObject) {
        let segmentedControl = sender as UISegmentedControl
        
        switch segmentedControl.selectedSegmentIndex {
        case 0: mapView.mapType = kGMSTypeNormal
            
        case 1:
                mapView.mapType = kGMSTypeSatellite
            
        case 2: mapView.mapType = kGMSTypeHybrid
            
        default: mapView.mapType = mapView.mapType
        }
    }
   // wird aufgerufen wenn der User die Anfrage zur Erlaubnis der Lokalisierung beantwortet hat
    func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
      
        if status == .AuthorizedWhenInUse {
            
           
            locationManager.startUpdatingLocation()
            
            
            mapView.myLocationEnabled = true // erzeugt einen blauen Punkt, wo sich der User befindet
            mapView.settings.myLocationButton = true // erzeugt einen Button auf der Map zum zentrieren der Location
        }
    }
    
   // wird aufgerufen wenn LocationManager neue Lokalisierungsdaten erhalten hat
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        if let location = locations.first as? CLLocation {
            
            // Kamera und Marker nach neuen Daten ausrichten
            mapView.camera = GMSCameraPosition(target: location.coordinate, zoom: 1, bearing: 0, viewingAngle: 0)
            marker.position = mapView.camera.target
            
            locationManager.stopUpdatingLocation()
        }
       
        
    }



       
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /* @IBAction func ladeVC2(Sender: UIButton!) {
    let secondViewController = self.storyboard?.instantiateViewControllerWithIdentifier("LocationView") as UIViewController
    
    self.presentViewController(secondViewController, animated: true, completion: nil)
    
    println("lade 2ten ViewController")
    
    }
    
    @IBAction func mapView(Sender: UIButton!) {
    let mapViewController = self.storyboard?.instantiateViewControllerWithIdentifier("MapView") as UIViewController
    
    self.presentViewController(mapViewController, animated: true, completion: nil)
    
    println("lade mapViewController")
    
    }
    */
}
