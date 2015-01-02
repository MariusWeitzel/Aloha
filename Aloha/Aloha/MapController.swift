//
//  MapController.swift
//  Aloha
//
//  Created by Medien on 10.11.14.
//  Copyright (c) 2014 Medien. All rights reserved.
//

import Foundation

import UIKit



class MapController: UIViewController,  CLLocationManagerDelegate,  GMSMapViewDelegate, SurfSpotMarkerDelegate  { //MapToLocationViewDelegate,
    
    
    @IBOutlet weak var mapView: GMSMapView! // zeigt die Google Map
    
    
    var marker = GMSMarker() // zeigt die aktuelle Suchposition - Suchpin
    var surfPlaces: [GMSMarker] = [] // sammelt die gespeicherten Surfspots
    var tempCoord: CLLocationCoordinate2D! // speichert die temporäre Koordinate
    var sidebar:Sidebar = Sidebar()
    
//    var marker = GMSMarker()
//    var surfMarker = GMSMarker()
//    var currentSpotLatitude:Double = 0.0
//    var currentSpotLongitude:Double = 0.0
    var addressText:String = "Adresse von Map"
    var getNewAddress:String!{
        get{
            return addressText
        }
    }
    
    let locationManager = CLLocationManager() // sammelt Information der GPS-Daten der eigenen Position
    let dataProvider = GoogleDataProvider() // Daten die zur Nutzung von Gmaps nötig sind
    
    
    @IBOutlet weak var searchMarkerSwitch: UISwitch! // kontrolle über aktivierung von Suchpin und Adresslabel
    
    @IBOutlet weak var adressLabel: UILabel! // zeigt die aktuelle Adresse vom Suchpin an
    
   
    override func viewDidLoad() {
        
        super.viewDidLoad()

        //Lädt direkt am Anfang alle Locations
        //FIXME: möglicherweise früher notwendig!
        Vault.loadLocations()
       
        mapView.delegate = self
        mapView.myLocationEnabled = true
//        mapView.settings.rotateGestures = false
        mapView.settings.compassButton = true
        // erfragt den Zugriff auf Lokalisierung
        
        mapView.settings.consumesGesturesInView = false // Andere Gesten werden nich mehr abgefangen
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        mapView.myLocationEnabled = true
        
        // erzeugt Marker
        marker.position = CLLocationCoordinate2DMake(-33.86, 151.20)
        marker.snippet = "New Surfspot"
        marker.icon = UIImage(named: "icon_me")
        marker.appearAnimation = kGMSMarkerAnimationPop
        marker.map = mapView
        
        //erzeugt die Sidebar
        sidebar = Sidebar(sourceView: self.view)

        loadSurfSpots()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func loadSurfSpots() {
        surfPlaces.removeAll(keepCapacity: true)
        var localLocations = Vault.getLocations()
        for var i:Int = 0; i < localLocations.count; i++ {
            let spot = GMSMarker()
            
            spot.position = CLLocationCoordinate2DMake(localLocations[i].lat.doubleValue, localLocations[i].long.doubleValue)
            spot.snippet = localLocations[i].name
            
            spot.icon = UIImage(named: "surfer")
            
            spot.appearAnimation = kGMSMarkerAnimationPop
            spot.map = self.mapView
            surfPlaces.append(spot)
            
        }
    }
    
    // aktualisiert die Adresse im Label sobald sich die map bewegt und gestoppt hat
    func mapView(mapView: GMSMapView!, idleAtCameraPosition position: GMSCameraPosition!) {
        reverseGeocodeCoordinate(position.target)
    }
    
    
    @IBAction func showSearchMarker(sender: UISwitch) {
        if(searchMarkerSwitch.on){
            self.marker.map = mapView
           
            adressLabel.hidden = false
        }
        else{
            self.marker.map = nil
           
            adressLabel.hidden = true
        }
    }
    
    
    // aktualisiert die Marker auf der Map
    @IBAction func refreshPlaces(sender: UIBarButtonItem) {
        loadSurfSpots()
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
    
    // Wandelt Latitude und Longitude Koordinaten in eine normale Adresse
    func reverseGeocodeCoordinate(coordinate: CLLocationCoordinate2D) {
        
       
        let geocoder = GMSGeocoder()
        
        // Anfrage und Überprüfung ob es zu den Koordinaten auch eine Adresse gibt
       
        geocoder.reverseGeocodeCoordinate(coordinate) { response , error in
            
            self.adressLabel.unlock() // hier wird das Adressenlabel wieder zur Anzeige freigegen
            
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
        
        //speichert die gedrückte Koordinate und bereitet die Verbindung zur LocationEditorView vor
       
        tempCoord = longPressCoordinate
        performSegueWithIdentifier("MapToLocSegue", sender: self)
       
        
    }
    
    // Übergang zum nächsten ViewController mittels Segue
    // IMPORTANT: damit das Surfspot-Icon nachdem Speichern auf der Map angezeigt wird
    // muss der Übergang mittels einer Segue erfolgen. Der Datentransfer erfolgt über
    // ein Delegate, das in der LocationEditorView ausgelöst wird.
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "MapToLocSegue"){
            
//            println("ok segue")
            let vc = segue.destinationViewController as LocationEditorView
            vc.currentCoordinate = tempCoord
            vc.delegate = self

        }
    }
    // öffnet die LocationView nach drücken des Markers und überträgt die dazugehörigen Koordinaten
    func mapView(mapView: GMSMapView!, didTapMarker marker: GMSMarker!) -> Bool {
        
        //FIXME: aus Locations die Koordinate wieder fischen & dem LocationEditorView den Punkt zum anzeigen übergeben
        tempCoord = marker.position
        performSegueWithIdentifier("MapToLocSegue", sender: self)

        
        return true
    }
    
    // IMPORTANT: gehört zum Delegate-Vorgang. Nachdem in der LocationEditorView gespeichert wurde
    // wird diese Funktion ausgeführt die letztendlich das Anzeigen des Surfspots an der entsprechenden 
    // Koordinate übernimmt
    func createNewSurfSpotDidFinish(controller: LocationEditorView, coords: CLLocationCoordinate2D) {
       
        // entferne die LocationEditorView
        controller.navigationController?.popViewControllerAnimated(true)
        // erstelle neuen Surfspotmarker
        if(!surfPlaces.isEmpty){
            for( var i:Int = 0; i < surfPlaces.count; i++){
                if(surfPlaces[i].position.latitude == coords.latitude && surfPlaces[i].position.longitude == coords.longitude){
//                    println("SurfSpot Icon an dieser Stelle schon vorhanden")
                }
                else{
                    var surfMarker = GMSMarker()
                    surfMarker.position = coords
                    surfMarker.snippet = "Surf_Spot"
                    
                    /* IMPORTANT
                    zum Nutzen des Bildes muss aus Urheberrechtlichen Gründen folgendes bei den Credits, Website angegeben werden <div>Icon made by <a href="http://www.freepik.com" title="Freepik">Freepik</a> from <a href="http://www.flaticon.com" title="Flaticon">www.flaticon.com</a> is licensed under <a href="http://creativecommons.org/licenses/by/3.0/" title="Creative Commons BY 3.0">CC BY 3.0</a></div> http://www.flaticon.com/free-icon/surfer-surfing-in-a-big-water-wave_48043
                    */
                    surfMarker.icon = UIImage(named: "surfer")
                    
                    surfMarker.appearAnimation = kGMSMarkerAnimationPop
                    surfMarker.map = self.mapView
                    surfPlaces.append(surfMarker)
//                    println("neue Surfspotlocation: \(coords.latitude, coords.longitude)")
                              }
            }
        }
        else{
            var surfMarker = GMSMarker()
            surfMarker.position = coords
            surfMarker.snippet = "Surf_Spot"
            
            /* IMPORTANT
            zum Nutzen des Bildes muss aus Urheberrechtlichen Gründen folgendes bei den Credits, Website angegeben werden <div>Icon made by <a href="http://www.freepik.com" title="Freepik">Freepik</a> from <a href="http://www.flaticon.com" title="Flaticon">www.flaticon.com</a> is licensed under <a href="http://creativecommons.org/licenses/by/3.0/" title="Creative Commons BY 3.0">CC BY 3.0</a></div> http://www.flaticon.com/free-icon/surfer-surfing-in-a-big-water-wave_48043
            */
            surfMarker.icon = UIImage(named: "surfer")
            
            surfMarker.appearAnimation = kGMSMarkerAnimationPop
            surfMarker.map = self.mapView
            surfPlaces.append(surfMarker)
//            println("neue Surfspotlocation: \(coords.latitude, coords.longitude)")
        

        }
    
    }
    
    func deleteSurfSpotDidFinish(controller: LocationEditorView, coords: CLLocationCoordinate2D) {
        
            // entferne die LocationEditorView
            controller.navigationController?.popViewControllerAnimated(true)
            // erstelle neuen Surfspotmarker
            if(!surfPlaces.isEmpty){
                for( var i:Int = 0; i < surfPlaces.count; i++){
                    if (surfPlaces[i].position.latitude == coords.latitude && surfPlaces[i].position.longitude == coords.longitude) {
                        println("Da isser")
                        surfPlaces.removeAtIndex(i)
                        loadSurfSpots()
                        fetchNearbyPlaces(coords)
                        return
                    }
                }
            }
        }

    // wird aufgerufen wenn der User die Anfrage zur Erlaubnis der Lokalisierung beantwortet hat
    func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        
        if status == .AuthorizedWhenInUse {
            
//            println("authorisiert")
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
            
//            println("lokalisierung abgschlossen")
            locationManager.stopUpdatingLocation()
            fetchNearbyPlaces(location.coordinate)
        }

    }
    
    // kalkuliert den sichtbaren Radius der MapView - für die Filterung von Surfspots im Radius
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
    
    // FIXME: Filtersuche muss hier noch gefixt werden, je nach dem wie Surfspotsgespeichert werden, in Array oder Places

    func fetchNearbyPlaces(coordinate: CLLocationCoordinate2D) {
        // lösche aller Marker
        mapView.clear()
        marker.map = nil
        searchMarkerSwitch.setOn(false, animated: true)
        for spot: GMSMarker in surfPlaces{
            spot.map = mapView
        }
        // sucht in der Nähe nach gefilterten Plätzen
        
                /*
        dataProvider.fetchPlacesNearCoordinate(coordinate, radius:mapRadius, types: searchedTypes) { //surfPlaces in
            for place: GooglePlace in places {
                // erzeugt für jeden gefundenen Platz einen Marker an der Stelle
                let marker = PlaceMaker(place: place)
                // Anzeige des Markers
                marker.map = self.mapView
            }
        }
*/
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
   }
