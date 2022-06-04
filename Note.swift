//
//  Note.swift
//  workout_app
//
//  Created by Joseph Schaubroeck on 5/24/22.
//

import Foundation
import SwiftUI

class Note: Identifiable, ObservableObject, Equatable {
    var id = UUID()
    @Published var date:String = ""
    @Published var title:String = ""
    @Published var color = Color(.red)
    @Published var exercises:[Exercise] = []
    
//    init(date: String, title: String, color: Color) {
//        self.date = date
//        self.title = title
//        self.color = color
//    }
    func copy() -> Note {
        let copy = Note()
        copy.id = UUID()
        copy.date = date
        copy.title = title
        copy.color = color
        for item in exercises {
            copy.exercises.append(item)
        }
        return copy
    }
    
    static func == (lhs: Note, rhs: Note) -> Bool {
        return lhs.date == rhs.date && lhs.title == rhs.title && lhs.color == rhs.color
        && lhs.id == rhs.id
    }
}
