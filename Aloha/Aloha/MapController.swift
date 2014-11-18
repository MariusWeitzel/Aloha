//
//  MapController.swift
//  Aloha
//
//  Created by Medien on 10.11.14.
//  Copyright (c) 2014 Medien. All rights reserved.
//

import Foundation

import UIKit

class MapController: UIViewController, CLLocationManagerDelegate,  GMSMapViewDelegate {
    
    
    
    
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var mapPin: UIImageView!
    
   
    @IBOutlet weak var pinImageVerticalConstraint: NSLayoutConstraint!
    var searchedTypes = ["Very Worse", "Worse", "Not Bad", "Good", "Very Good"]
    
     var marker = GMSMarker()
    
    let locationManager = CLLocationManager()
    let dataProvider = GoogleDataProvider()
   
   
    
    @IBOutlet weak var adressLabel: UILabel!
    
    @IBAction func longPressForNewPlace(sender: UILongPressGestureRecognizer) {
        println("long press ohne stres")
    }
    override func viewDidLoad() {
      
        super.viewDidLoad()
        
        mapView.delegate = self
        mapView.myLocationEnabled = true
        // erfragt den Zugriff auf Lokalisierung
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        mapView.myLocationEnabled = true
        
        // erzeugt Marker
        marker.position = CLLocationCoordinate2DMake(-33.86, 151.20) //mapView.camera.target
        marker.snippet = "Hello World"
        marker.icon = UIImage(named: "icon_me")
        marker.appearAnimation = kGMSMarkerAnimationPop
        marker.map = mapView
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    // aktualisiert die Adresse im Label sobald sich die map bewegt und gestoppt hat
    func mapView(mapView: GMSMapView!, idleAtCameraPosition position: GMSCameraPosition!) {
        reverseGeocodeCoordinate(position.target)
    }
    // aktualisiert die Marker auf der Map
    @IBAction func refreshPlaces(sender: UIBarButtonItem) {
       fetchNearbyPlaces(mapView.camera.target)
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
    
    //
    func reverseGeocodeCoordinate(coordinate: CLLocationCoordinate2D) {
        
        // Wandelt Latitude und Longitude Koordinaten in eine normale Adresse
        let geocoder = GMSGeocoder()
        
        // Anfrage und Überprüfung ob es zu den Koordinaten auch eine Adresse gibt
        geocoder.reverseGeocodeCoordinate(coordinate) { response , error in
            
            self.adressLabel.unlock()
            
            if let address = response?.firstResult() {
                
                // empfangene Adresse wird als String gespeichert und dem Label hinzugefügt
                let lines = address.lines as [String]
                self.adressLabel.text = join("\n", lines)
                
                let labelHeight = self.adressLabel.intrinsicContentSize().height
                self.mapView.padding = UIEdgeInsets(top: self.topLayoutGuide.length, left: 0, bottom: labelHeight, right: 0)
                
                // zeigt die Ändererung im Label an
                UIView.animateWithDuration(0.25) {
                  
                    self.marker.position = self.mapView.camera.target
                    self.view.layoutIfNeeded()
                }
            }
        }
    }
    // locked die Adressansicht und macht bei änderung einen visuellen Effekt
    func mapView(mapView: GMSMapView!, willMove gesture: Bool){
        adressLabel.lock()
    }
     // registriert langes drücken zum erzeugen eines neuen Markers
    func mapView(mapView: GMSMapView!, didLongPressAtCoordinate longPressCoordinate: CLLocationCoordinate2D){
        var surfMarker = GMSMarker()
        surfMarker.position = longPressCoordinate //mapView.camera.target
        surfMarker.snippet = "Surf_Spot"
        surfMarker.icon = UIImage(named: "icon_me")
        surfMarker.appearAnimation = kGMSMarkerAnimationPop
        surfMarker.map = mapView

        println("long press")
    }
    
    
   // wird aufgerufen wenn der User die Anfrage zur Erlaubnis der Lokalisierung beantwortet hat
    func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
      
        if status == .AuthorizedWhenInUse {
            
           println("authorisiert")
            locationManager.startUpdatingLocation()
            
            mapView.myLocationEnabled = true // erzeugt einen blauen Punkt, wo sich der User befindet
            mapView.settings.myLocationButton = true // erzeugt einen Button auf der Map zum zentrieren der Location
            
        }
        else{
            locationManager.delegate = self
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
   // wird aufgerufen wenn LocationManager neue Lokalisierungsdaten erhalten hat
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        if let location = locations.first as? CLLocation {
            
            // Kamera nach neuen Daten ausrichten
            mapView.camera = GMSCameraPosition(target: location.coordinate, zoom: 1, bearing: 0, viewingAngle: 0)
            marker.position = mapView.camera.target

            println("lokalisierung abgschlossen")
            locationManager.stopUpdatingLocation()
            fetchNearbyPlaces(location.coordinate)
        }
       
        
    }
    
    // kalkuliert den sichtbaren Radius der MapView
    var mapRadius: Double {
        get {
            let region = mapView.projection.visibleRegion()
            let center = mapView.camera.target
            
            let north = CLLocation(latitude: region.farLeft.latitude, longitude: center.longitude)
            let south = CLLocation(latitude: region.nearLeft.latitude, longitude: center.longitude)
            let west = CLLocation(latitude: center.latitude, longitude: region.farLeft.longitude)
            let east = CLLocation(latitude: center.latitude, longitude: region.farRight.longitude)
            
            let verticalDistance = north.distanceFromLocation(south)
            let horizontalDistance = west.distanceFromLocation(east)
            return max(horizontalDistance, verticalDistance)*0.5
        }
    }

    func fetchNearbyPlaces(coordinate: CLLocationCoordinate2D) {
        // lösche aller Marker
        mapView.clear()
        marker.map = mapView
        // sucht in der Nähe nach gefilterten Plätzen
        dataProvider.fetchPlacesNearCoordinate(coordinate, radius:mapRadius, types: searchedTypes) { places in
            for place: GooglePlace in places {
                // erzeugt für jeden gefundenen Platz einen Marker an der Stelle
                let marker = PlaceMaker(place: place)
                // Anzeige des Markers
                marker.map = self.mapView
            }
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
