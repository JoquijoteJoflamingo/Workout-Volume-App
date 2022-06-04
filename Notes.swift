//
//  Notes.swift
//  workout_app
//
//  Created by Joseph Schaubroeck on 5/25/22.
//

import Foundation

class Notes: Identifiable, ObservableObject {
    @Published var notes = [Note]()
}
