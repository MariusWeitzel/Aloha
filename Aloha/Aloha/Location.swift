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
    
    //FIXME: welche Form hat das genau?
    var waterproperties: [String]
    
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
        waterproperties = []
        coastproperties = []
        notes = ""
        possibleDangers = []
        difficulty = ""
    }
}