//
//  Helper Functions.swift
//  workout_app
//
//  Created by Joseph Schaubroeck on 5/23/22.
//

import Foundation


func textValid(name: String, min: String, max: String) -> Bool {
    if name == "" || min == "" || max == "" {
        return false
    }
    let numMin = Int(min)
    let numMax = Int(max)
    if numMin == nil || numMax == nil {
        return false
    }
    if numMin! < 0 || numMax! < 0 {
        return false
    }
    if numMin! > numMax! {
        return false
    }
    return true
}

func textValid(name: String, numSets: String) -> Bool {
    if name == "" || numSets == "" {
        return false
    }
    
    let intNumSets = Int(numSets)
    
    if intNumSets == nil {
        return false
    }
    if intNumSets! < 0 {
        return false
    }
    
    return true
}
