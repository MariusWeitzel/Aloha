//
//  Vault.swift
//  Aloha
//
//  Created by Medien on 10.11.14.
//  Copyright (c) 2014 Medien. All rights reserved.
//

import Foundation

//surfSpots voneinander trennen
let spotSeperator = "#\n"
//SpotEigenschaften voneinander trennen
let spotItemSeperator = "|\n"
//einzelne Werte in Arrays trennen
//FIXME: wahrscheinlich obsolet
//let itemSeperator = "\n"

var Locations = [Location]()

class Vault: UIViewController {
    
    class func saveLocation(punkt: Location) {
        // anzulegenden Punkt an bisherige Locations anfügen
        Locations.append(punkt)
        var saveStr = ""
        
        // Locations auseinander fuddeln
        for spot in Locations {
            saveStr += spot.name + spotItemSeperator
            
            if spot.favorite { saveStr += "1" }
            else { saveStr += "0" }
            saveStr += spotItemSeperator

            saveStr += spot.adress + spotItemSeperator
            
            //for item in spot.tags { saveStr += item + itemSeperator }
            //saveStr += spotItemSeperator
            
            //waterproperties
            //TODO: ausgewähltes item zurück geben/speichern
            //      alternativ auch nur den Index speichern?
            //      machts beim Laden leichter
            
            
            
            saveStr += String(spot._wavetype) + spotItemSeperator
            saveStr += String(spot._waterdepth) + spotItemSeperator
            saveStr += String(spot._watertemperature) + spotItemSeperator
            saveStr += String(spot._watertype) + spotItemSeperator
            
            saveStr += String(spot._coastproperties) + spotItemSeperator
            
            saveStr += spot.notes
            
            //TODO: in ner sinnvollenweise umbauen
            //OFFER: wie bei Favorit nen Switch für Haie & Riffs machen (erstmal)
            //for item in spot.possibleDangers { saveStr += item + itemSeperator }
            
            
            saveStr += String(spot._difficulty)
            
            saveStr += spotSeperator;
        }
        
        let dirs = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true) as? [String]
        
        let path = dirs?[0].stringByAppendingPathExtension("locations.csv")
        
        if (path != nil) {
            saveStr.writeToFile(path!, atomically: true, encoding: NSUTF8StringEncoding, error: nil)
            println("Daten \"\(saveStr)\" geschrieben.")
        }

    }
    
    class func loadLocations() {
        var loadedStr: String
        let dirs = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true) as? [String]
        
        let path = dirs?[0].stringByAppendingPathExtension("locations.csv")
        
        if (path != nil) {
            loadedStr = String(contentsOfFile: path!, encoding: NSUTF8StringEncoding, error: nil)!
            //daten.removeAll(keepCapacity: false)
            //textFeldDaten.text = tempStr
//            myTextFeld.text = tempStr;
            println("\"\(loadedStr)\" geladen");
        }
        else {
            println("Laden fehlgeschlagen")
        }
        
        //FIXME: waaaaaas?
        //loadedStr.componentsSeparatedByString(spotSeperator)
        //TODO: String aus gespeicherter Datei wieder aufsplitten
        
        // Locations auseinander fuddeln & als Array speichern
        /*for spot in Locations {
        saveStr += spot.name + spotItemSeperator
        
        if spot.favorite { saveStr += "1" }
        else { saveStr += "0" }
        saveStr = spotItemSeperator
        
        saveStr += spot.adress
        
        for item in spot.tags { saveStr += item + itemSeperator }
        
        for item in spot.waterproperties { saveStr += item + itemSeperator }
        
        for item in spot.coastproperties { saveStr += item + itemSeperator }
        
        saveStr += spot.notes
        
        for item in spot.possibleDangers { saveStr += item + itemSeperator }
        
        saveStr += spot.difficulty
        }*/
        
        

    }
    
    //TODO: deleteLocation
    //      editLocation
    
}