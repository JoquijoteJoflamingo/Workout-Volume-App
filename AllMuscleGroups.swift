//
//  AllMuscleGroups.swift
//  workout_app
//
//  Created by Joseph Schaubroeck on 5/20/22.
//

import Foundation

class AllMuscleGroups: Identifiable, ObservableObject {
    @Published var muscleGroupArray:[MuscleGroup] = []
}
