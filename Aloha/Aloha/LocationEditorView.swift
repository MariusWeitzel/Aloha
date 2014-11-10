//
//  LocationEditorView.swift
//  Aloha
//
//  Created by Medien on 10.11.14.
//  Copyright (c) 2014 Medien. All rights reserved.
//

import UIKit

class LocationViewEditor: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func bla(Sender: UIButton!) {
        let secondViewController = self.storyboard?.instantiateViewControllerWithIdentifier("LocationView") as UIViewController
        
        self.presentViewController(secondViewController, animated: true, completion: nil)
        
        println("zurück zum ersten ViewController")
    }
}