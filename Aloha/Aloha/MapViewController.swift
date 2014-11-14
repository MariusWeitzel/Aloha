//
//  MapViewController.swift
//  Aloha
//
//  Created by chucha on 14.11.14.
//  Copyright (c) 2014 Medien. All rights reserved.
//

import UIKit

class MapViewController: UIViewController , GMSMapViewDelegate{
    
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
    }
        /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
