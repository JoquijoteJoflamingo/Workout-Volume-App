//
//  Exercise.swift
//  workout_app
//
//  Created by Joseph Schaubroeck on 5/26/22.
//

import Foundation

class Exercise: Identifiable, ObservableObject {
    var id = UUID()
    var name = String()
    var numSets = Int()
    var muscleGroup = MuscleGroup()
    @Published var repsText:[String] = ["", "", "", "", "", "", "", "", "", ""]
    @Published var weightText:[String] = ["", "", "", "", "", "", "", "", "", ""]
    
    
    init(name: String, numSets: Int, muscleGroup: MuscleGroup) {
        self.name = name
        self.numSets = numSets
        self.muscleGroup = muscleGroup
        
    }
    
    init() {
        self.name = ""
        self.numSets = 0
        self.muscleGroup = MuscleGroup()
    }
}
