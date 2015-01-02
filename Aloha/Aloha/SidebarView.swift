//
//  SidebarView.swift
//  Aloha
//
//  Created by Medien on 10.11.14.
//  Copyright (c) 2014 Medien. All rights reserved.
//

import Foundation
import UIKit

class SidebarView: UIViewController {
    
    
    var switchDemo=UISwitch(frame:CGRectMake(700, 100, 0, 0));
    
    func stateChanged(switchState: UISwitch) {
        if switchState.on {
            println("The Switch is On")
        } else {
            println("The Switch is Off")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        switchDemo.on = true
        switchDemo.setOn(true, animated: false);
        self.view.addSubview(switchDemo);
        // Do any additional setup after loading the view, typically from a nib.
        switchDemo.addTarget(self, action: Selector("stateChanged:"), forControlEvents: UIControlEvents.ValueChanged)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}