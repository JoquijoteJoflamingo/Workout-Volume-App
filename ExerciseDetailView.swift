//
//  ExerciseDetailView.swift
//  workout_app
//
//  Created by Joseph Schaubroeck on 5/31/22.
//

import SwiftUI

struct ExerciseDetailView: View {
    
    @State var exercise:Exercise
    
    @FocusState private var focusedInput: Field?
    
    let secondarySystem = Color(UIColor.secondarySystemBackground)
    // convert to dictionaries <int, pair<string, string>>
    @State var setsRepsWeight:[Int:[String:String]] = [:]
    @State var repsText:[String] =
    ["", "", "", "", "", "", "", "", "", ""]
    @State var weightText:[String] = ["", "", "", "", "", "", "", "", "", ""]
    
    var body: some View {
        
        NavigationView {
            List(0..<exercise.numSets, id: \.self) { set in
                Section("Set \(set + 1)") {
                    VStack {
                        HStack {
                            Text("Reps")
                            TextField("0", text: $exercise.repsText[set])
                                .focused($focusedInput, equals: .reps)
                                
                        }
                        
                        HStack {
                            Text("Weight")
                            HStack {
                                TextField("0", text: $exercise.weightText[set])
                                    .focused($focusedInput, equals: .weight)
                                    .frame(width: 35)
                                Text("lbs")
                                Spacer()
                            }
                        }
                    }
                }
                .listRowBackground(secondarySystem)
                
            }
            .navigationTitle(exercise.name)
            .onAppear{
                UITableView.appearance().backgroundColor = .clear
            }
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Button(action: {
                        dismissKeyboard()
                    }, label: {
                        Text("Done")
                    })
                    Spacer()
                    
                    Button(action: {
                        
                    }, label: {
                        Image(systemName: "chevron.up")
                    })
                    
                    Button(action: {
                        
                    }, label: {
                        Image(systemName: "chevron.down")
                    })
                }
            }
            
        }
        
    }
}

private extension ExerciseDetailView {
    enum Field: Int, Hashable, CaseIterable {
        case reps
        case weight
    }
}

private extension ExerciseDetailView {
    func dismissKeyboard() {
        self.focusedInput = nil
    }
}
struct ExerciseDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let muscleGroup = MuscleGroup(name: "Chest", minTargetSets: 12, maxTargetSets: 18)
        let exercise = Exercise(name: "Bench Press", numSets: 3, muscleGroup: muscleGroup)
        ExerciseDetailView(exercise: exercise)
    }
}
