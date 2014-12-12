//
//  Location.swift
//  Aloha
//
//  Created by Medien on 10.11.14.
//  Copyright (c) 2014 Medien. All rights reserved.
//

import Foundation

public struct Location {
    var name: String
    
    var favorite: Bool
    
    //FIXME: welche Form hat das genau?
    var adress: String
    
    //FIXME: welche Form hat das genau?
    var tags: [String]
    
    //FIXME: all waterproperties
    var _wavetype: wavetype
    var _waterdepth: waterdepth
    var _watertemperature: watertemperature
    var _watertype: watertype
    
    //FIXME: welche Form hat das genau?
    var coastproperties: [String]
    
    var notes: String
    
    //FIXME: welche Form hat das genau?
    var possibleDangers: [String]
    
    //FIXME: nice2have enums mit konstanten (dann wärs nen int)
    var difficulty: String
    
    init() {
        name = ""
        favorite = false
        adress = ""
        tags = []
        _wavetype = wavetype()
        _waterdepth = waterdepth()
        _watertemperature = watertemperature()
        _watertype = watertype()
        coastproperties = []
        notes = ""
        possibleDangers = []
        difficulty = ""
    }
    
}

//public struct waterproperties {
//    var waterproperties: Dictionary<>
//    init() {
//        waterproperties.wavetype = wavetype()
//        
//    }
//}

public struct wavetype {
    var wavetype: [String]
    var count: Int { return wavetype.count }
    
    init() {
        wavetype = ["hoch", "mittel", "niedrig"]
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
        waterdepth = ["tief", "mittel", "flach"]
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
        watertemperature = ["kühl", "mittel", "warm"]
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


