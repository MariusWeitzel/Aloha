//
//  Vault.swift
//  Aloha
//
//  Created by Medien on 10.11.14.
//  Copyright (c) 2014 Medien. All rights reserved.
//

import Foundation

var Locations = [Location]()

class Vault {
    
    class func saveLocation() {
        var tempStr = String()
        
        //        weak var textFeldDaten: UITextField!
//        tempStr = myTextFeld.text;
        
        let dirs = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true) as? [String]
        
        let path = dirs?[0].stringByAppendingPathExtension("locations.csv")
        
        if (path != nil) {
            tempStr.writeToFile(path!, atomically: true, encoding: NSUTF8StringEncoding, error: nil)
            println("Daten \"\(tempStr)\" geschrieben.")
        }

    }
    
    class func loadLocations() {
        let dirs = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true) as? [String]
        
        let path = dirs?[0].stringByAppendingPathExtension("locations.csv")
        
        if (path != nil) {
            var tempStr = String(contentsOfFile: path!, encoding: NSUTF8StringEncoding, error: nil)
            //daten.removeAll(keepCapacity: false)
            //textFeldDaten.text = tempStr
//            myTextFeld.text = tempStr;
            println("\"\(tempStr)\" geladen");
        }
        else {
            println("Laden fehlgeschlagen")
        }

    }
    
}