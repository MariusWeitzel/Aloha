//
//  ViewController.swift
//  Aloha
//
//  Created by Medien on 07.11.14.
//  Copyright (c) 2014 Medien. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func ladeVC2(Sender: UIButton!) {
        let secondViewController = self.storyboard?.instantiateViewControllerWithIdentifier("LocationView") as UIViewController
        
        self.presentViewController(secondViewController, animated: true, completion: nil)
        
        println("lade 2ten ViewController")
        
    }
    
    @IBAction func mapView(Sender: UIButton!) {
        let mapViewController = self.storyboard?.instantiateViewControllerWithIdentifier("MapView") as UIViewController
        
        self.presentViewController(mapViewController, animated: true, completion: nil)
        
        println("lade mapViewController")
        
    }
    
}

