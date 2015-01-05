//
//  Vault.swift
//  Aloha
//
//  Created by Medien on 10.11.14.
//  Copyright (c) 2014 Medien. All rights reserved.
//

import Foundation

//surfSpots voneinander trennen
let spotSeperator = "#"
//SpotEigenschaften voneinander trennen
let spotItemSeperator = "|"
//einzelne Werte in Arrays trennen
//FIXME: wahrscheinlich obsolet
//let itemSeperator = "\n"

var Locations = [Location]()

class Vault: UIViewController {
    
    class func saveLocation(punkt: Location?) {
        // anzulegenden Punkt an bisherige Locations anfügen
        // falls leer (gelöscht) wird nil übergeben, das will man natürlich nicht anfügen
        if punkt != nil {
            Locations.append(punkt!)
        }
        var saveStr = ""
        
        println("beim Speichern sind es \(Locations.count) Punkte")
        
        // Locations auseinander fuddeln
        for spot in Locations {
            saveStr += spot.lat.stringValue + spotItemSeperator
            saveStr += spot.long.stringValue + spotItemSeperator
            
            println("Name beim speichern: \(spot.name)")
            //FIXME: spot & itemseperator aus Name und Notizen entfernen -> safe
            saveStr += spot.name + spotItemSeperator
            
            if spot.favorite { saveStr += "1" }
            else { saveStr += "0" }
            saveStr += spotItemSeperator

            saveStr += spot.adress + spotItemSeperator
            
            //waterproperties
            saveStr += String(spot._wavetype) + spotItemSeperator
            saveStr += String(spot._waterdepth) + spotItemSeperator
            saveStr += String(spot._watertemperature) + spotItemSeperator
            saveStr += String(spot._watertype) + spotItemSeperator
            
            saveStr += String(spot._coastproperties) + spotItemSeperator
            saveStr += String(spot._beachtype) + spotItemSeperator
            
            if spot.jellyfisch { saveStr += "1" }
            else { saveStr += "0" }
            saveStr += spotItemSeperator
            
            if spot.sharks { saveStr += "1" }
            else { saveStr += "0" }
            saveStr += spotItemSeperator
            
            if spot.riffs { saveStr += "1" }
            else { saveStr += "0" }
            saveStr += spotItemSeperator
            
            if spot.dirt { saveStr += "1" }
            else { saveStr += "0" }
            saveStr += spotItemSeperator
            
            if spot.cautionXY { saveStr += "1" }
            else { saveStr += "0" }
            saveStr += spotItemSeperator
            
            if spot.cautionZX { saveStr += "1" }
            else { saveStr += "0" }
            saveStr += spotItemSeperator
            
            //TODO: in ner sinnvollenweise umbauen
            //OFFER: wie bei Favorit nen Switch für Haie & Riffs machen (erstmal)
            //for item in spot.possibleDangers { saveStr += item + itemSeperator }
            
            
            saveStr += String(spot._difficulty) + spotItemSeperator

            saveStr += spot.notes + spotItemSeperator

            saveStr += spotSeperator;
        }
        
        let dirs = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true) as? [String]
        
        let path = dirs?[0].stringByAppendingPathComponent("locations.csv")
        
        if (path != nil) {
            saveStr.writeToFile(path!, atomically: true, encoding: NSUTF8StringEncoding, error: nil)
            println("Daten \"\(saveStr)\" geschrieben.")
        }
    }
    
    class func loadLocations() {
        var loadedStr: String
        let dirs = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true) as? [String]
        
        let path = dirs?[0].stringByAppendingPathComponent("locations.csv")
        
        println("path: \(path)")
        
        var checkValidation = NSFileManager.defaultManager()
        
        if (checkValidation.fileExistsAtPath(path!)) {
            loadedStr = String(contentsOfFile: path!, encoding: NSUTF8StringEncoding, error: nil)!
            
            //FIXME: spotSeperator (die Konstante) wirft an der Stelle nen Fehler!
            let splittedLocations = split(loadedStr, {$0=="#"})
            println("splitted Locations: \(splittedLocations.count)")
            for location in splittedLocations {
                println("StringLocation: \(location)")
                var pointItems = split(location, {$0=="|"})
                //FIXME: ohne die Zeile crachsts aufm iPad, aber zeigt die Punkte nachm starten nicht mehr an?! o.O
                // iPad Bugfix - kP warum der Simulator das "überlebt"
                //DEBUG:
//                println("Anzahl pointItems: \(pointItems.count)")
//                if pointItems.count > 0 { continue }
                var nuPunkt = Location()
                
                //FIXME: wenn das schief geht, is halt direkt rum :/
                nuPunkt.lat = NSNumberFormatter().numberFromString(pointItems[0])!
                nuPunkt.long = NSNumberFormatter().numberFromString(pointItems[1])!
                
                nuPunkt.name = pointItems[2]
                
                if pointItems[3] == "1" { nuPunkt.favorite = true }
                else { nuPunkt.favorite = false }
                
                nuPunkt.adress = pointItems[4]
                
                //waterproperties
                nuPunkt._wavetype = pointItems[5].toInt()!
                nuPunkt._waterdepth = pointItems[6].toInt()!
                nuPunkt._watertemperature = pointItems[7].toInt()!
                nuPunkt._watertype = pointItems[8].toInt()!
                
                nuPunkt._coastproperties = pointItems[9].toInt()!
                nuPunkt._beachtype = pointItems[10].toInt()!
                
                if pointItems[11].toInt()! == 1 { nuPunkt.jellyfisch = true }
                else { nuPunkt.jellyfisch = false }
                
                if pointItems[12].toInt()! == 1 { nuPunkt.sharks = true }
                else { nuPunkt.sharks = false }
                
                if pointItems[13].toInt()! == 1 { nuPunkt.riffs = true }
                else { nuPunkt.riffs = false }
                
                if pointItems[14].toInt()! == 1 { nuPunkt.dirt = true }
                else { nuPunkt.dirt = false }
                
                if pointItems[15].toInt()! == 1 { nuPunkt.cautionXY = true }
                else { nuPunkt.cautionXY = false }
                
                if pointItems[16].toInt()! == 1 { nuPunkt.cautionZX = true }
                else { nuPunkt.cautionZX = false }
            

                nuPunkt._difficulty = pointItems[17].toInt()!
                
                nuPunkt.notes = pointItems[18]
                
                println("\(nuPunkt.name)")
                
                Locations.append(nuPunkt)
            }
            
            
//            println("\"\(loadedStr)\" geladen");
        }
        else {
            println("Laden fehlgeschlagen")
        }
        
        println(Locations.count)
        
        for x in Locations {
            println(x.name)
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
    
    class func getLocations() -> [Location] {
        return Locations
    }
}