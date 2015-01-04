//
//  Location.swift
//  Aloha
//
//  Created by Medien on 10.11.14.
//  Copyright (c) 2014 Medien. All rights reserved.
//

import Foundation

public struct Location {
    //ID bestehend aus der Koordinate
    var lat: NSNumber
    var long: NSNumber
    //Name des Punkts
    var name: String
    //Favorit ja/nein
    var favorite: Bool
    //aus dem MapKit gelieferte Adresse zu dem Punkt (falls möglich)
    var adress: String
    
    //all waterproperties
    var _wavetype: Int
    var _waterdepth: Int
    var _watertemperature: Int
    var _watertype: Int
    
    //Index für ausgewähltes struct coastproperties
    var _coastproperties: Int
    var _beachtype: Int
    
    //freie Notizen zu diesem Punkt
    var notes: String
    
    //FIXME: welche Form hat das genau?
//    var possibleDangers: [String]
    var sharks: Bool
    var riffs: Bool
    var jellyfisch: Bool
    var dirt: Bool
    var cautionXY: Bool
    var cautionZX: Bool
    
    //Index für ausgewähltes struct difficulty
    var _difficulty: Int
    
    init() {
        lat = 0
        long = 0
        name = ""
        favorite = false
        adress = ""
//        tags = []
        //Standardwerte annehmend
        _wavetype = 0
        _waterdepth = 0
        _watertemperature = 0
        _watertype = 0
        //Standardwert (Flachküste) annehmend
        _coastproperties = 0
        _beachtype = 0
        notes = " "
        sharks = false
        riffs = false
        jellyfisch = false
        dirt = false
        cautionXY = false
        cautionZX = false
        
        //Standardwert (mittel) annehmend
        _difficulty = 1
    }
    
}

public struct coastproperties {
    var coastproperties: [String]
    var count: Int { return coastproperties.count }
    init() {
        coastproperties = ["Steilküste", "Flachküste"]
    }
    subscript(index: Int) -> String {
        get {
            return coastproperties[index]
        }
        
    }

}

public struct difficulty {
    var difficulty: [String]
    var count: Int { return difficulty.count }
    init() {
        difficulty = ["einfach", "mittel", "schwierig"]
    }
}

public struct wavetype {
    var wavetype: [String]
    var count: Int { return wavetype.count }
    
    init() {
        wavetype = ["flach", "mittel", "hoch"]
    }
    
    subscript(index: Int) -> String {
        get {
            return wavetype[index]
        }
        set(newValue) {
            // perform a suitable setting action here
        }
    }
}

public struct waterdepth {
    var waterdepth: [String]
    var count: Int { return waterdepth.count }
    
    init() {
        waterdepth = [">10m", "5-10m", "<5m"]
    }
    subscript(index: Int) -> String {
        get {
            return waterdepth[index]
        }
        set(newValue) {
            // perform a suitable setting action here
        }
    }
}

public struct watertemperature {
    var watertemperature: [String]
    var count: Int { return watertemperature.count }
    
    init() {
        watertemperature = ["<15°C", "15-25°C", ">25°C"]
    }
    subscript(index: Int) -> String {
        get {
            return watertemperature[index]
        }
        set(newValue) {
            // perform a suitable setting action here
        }
    }
}

public struct watertype {
    var watertype: [String]
    var count: Int { return watertype.count }
    
    init() {
        watertype = ["süß", "salzig"]
    }
    subscript(index: Int) -> String {
        get {
            return watertype[index]
        }
        set(newValue) {
            // perform a suitable setting action here
        }
    }
    

}

public struct beachtype {
    var beachtype: [String]
    var count: Int { return beachtype.count }
    
    init() {
        beachtype = ["Stein", "Strand", "Sonstiges"]
    }
    subscript(index: Int) -> String {
        get {
            return beachtype[index]
        }
        
    }
}



