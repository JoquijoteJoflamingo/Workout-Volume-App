//
//  Muscle-Group.swift
//  workout_app
//
//  Created by Joseph Schaubroeck on 5/18/22.
//

import Foundation
import SwiftUI

class MuscleGroup:Identifiable, ObservableObject {
    @Published var id = UUID()
    @Published var name = String()
    @Published var minTargetSets = Int()
    @Published var maxTargetSets = Int()
    @Published var setsWorked = 0
    var rowColor:Color {
        if setsWorked == 0 {
            return Color("Turkish Red")
        }
        else if setsWorked > 0 && setsWorked < minTargetSets {
            return Color("Turkish Yellow")
        }
        else if setsWorked >= minTargetSets && setsWorked <= maxTargetSets {
            return Color("Turkish Green")
        }
        else {
            return Color("Turkish Purple")
        }
    }
    
    init(name: String, minTargetSets: Int, maxTargetSets: Int) {
        self.id = UUID()
        self.name = name
        self.minTargetSets = minTargetSets
        self.maxTargetSets = maxTargetSets
    }
    init() {
        self.id = UUID()
        self.name = ""
        self.minTargetSets = 0
        self.maxTargetSets = 0
        self.setsWorked = 0
        
    }
}

