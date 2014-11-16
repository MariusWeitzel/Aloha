//
//  ViewController.swift
//  Aloha
//
//  Created by Medien on 07.11.14.
//  Copyright (c) 2014 Medien. All rights reserved.
//

import UIKit

class ViewController: UIViewController,  GMSMapViewDelegate{
    
    var gMaps: GMSMapView?
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var target: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 51.6, longitude: 17.2)
        var mapCam: GMSCameraPosition = GMSCameraPosition(target: target, zoom: 6, bearing: 0, viewingAngle: 0)
        
        gMaps = GMSMapView(frame: CGRectMake(0, 0, self.view.bounds.width, self.view.bounds.height))
        
        if let map = gMaps? {
            map.myLocationEnabled = true
            map.camera = mapCam
            map.delegate = self
            
            self.view.addSubview(gMaps!)
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

