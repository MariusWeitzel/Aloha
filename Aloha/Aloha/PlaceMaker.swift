//
//  PlaceMaker.swift
//  Aloha
//
//  Created by chucha on 17.11.14.
//  Copyright (c) 2014 Medien. All rights reserved.
//

import UIKit

class PlaceMaker: GMSMarker {
   
    let place: GooglePlace
    
    
    //initialisiert und platziert einen Markierer mit Pos und Image
    
    init(place: GooglePlace) {
        self.place = place
        super.init()
        
        position = place.coordinate
        icon = UIImage(named: place.placeType+"_pin")
        groundAnchor = CGPoint(x: 0.5, y: 1)
        appearAnimation = kGMSMarkerAnimationPop
    }
    
    
}
