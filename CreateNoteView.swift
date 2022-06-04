//
//  CreateNoteView.swift
//  workout_app
//
//  Created by Joseph Schaubroeck on 5/30/22.
//

import SwiftUI

struct CreateNoteView: View {
//    init() {
//        UITableView.appearance().backgroundColor = .clear
//    }
//
    @FocusState private var focusedInput: Field?
    
    @State var note: Note
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    let secondarySystem = Color(UIColor.secondarySystemBackground)
    @EnvironmentObject var allNotes: Notes
    @EnvironmentObject var allMuscleGroups: AllMuscleGroups
    
//    @State var noteTitle = ""
//
    @State var exerciseNameText = ""
    @State var exerciseNumSetsText = ""
    @State var showSheet:Bool = false
    @State var exerciseSheet = Exercise()
//    @State var newNote = Note()
    
    
    var body: some View {
        VStack {
            VStack(spacing: 15.0) {
                HStack {
                    // Button for returning to previous view and saving note
                    Button(action: {
                        saveNote()
                    }, label: {
                        Image(systemName: "arrow.backward.square.fill")
                            .font(.system(size: 40))
                            .foregroundColor(Color("Mint Green"))
                    })
                    Spacer()
                }
                
                // TextField for entering note title
                TextField("Title", text: $note.title).padding()
                    .background(secondarySystem).cornerRadius(10)
                    .foregroundColor(.black)
                    .font(.headline).focused($focusedInput, equals: .title)

            }
            .padding()
            VStack {
                // List for showing all of the exercises added to the note
                NavigationView {
                    VStack {
                        if note.exercises.isEmpty {
                            Text("Add exercises here").italic().foregroundColor(.gray)
                        }
                        else {
                            List(note.exercises) { exercise in
                                HStack {
                                    Text(exercise.name).padding()
                                    Spacer()
                                    Text(String(exercise.numSets) + " sets").padding()
                                    
                                    Button(action: {
                                        exerciseSheet = exercise
                                        showSheet.toggle()
                                    }, label: {
                                        Image(systemName: "info.circle.fill").font(.system(size: 25)).padding().foregroundColor(Color("Mint Green"))
                                    })
                                    
                                    
                                }
                                .listRowBackground(secondarySystem)
                                
                                .sheet(isPresented: $showSheet, content: {
                                    ExerciseDetailView(exercise: exerciseSheet)
                                })
                            }
                        }
                    }
                    .navigationTitle("Exercises")
                    

                }
                // Section for user to add data
                // Exercise name:
                // Number of sets:
                Section(header: Text("Add new exercise")
                    .font(.title2)) {
                    TextField("Exercise name:", text: $exerciseNameText).padding()
                            .background(secondarySystem).cornerRadius(10)
                            .foregroundColor(.black)
                        .font(.headline)
                        .font(.headline).focused($focusedInput, equals: .exerciseName)
                        
                        
                    TextField("Number of sets", text: $exerciseNumSetsText).padding()
                            .background(secondarySystem).cornerRadius(10)
                            .foregroundColor(.black)
                        .font(.headline).keyboardType(.decimalPad).font(.headline)
                        .focused($focusedInput, equals: .numSets)
                    
                    
                    // only usable if user entered valid info
                    Menu(content: {
                        if textValid(name: exerciseNameText, numSets: exerciseNumSetsText) {
                            ForEach(0..<allMuscleGroups.muscleGroupArray.count) { item in
                                Button(action: {
                                    
                                    addExerciseToNote(muscleGroupIn: allMuscleGroups.muscleGroupArray[item])
                                }, label: {
                                    Text(allMuscleGroups.muscleGroupArray[item].name)
                                })
                            }
                        }
                    }, label: {
                        Image(systemName: "plus.app.fill")
                            .font(.system(size: 40, weight: .bold))
                            .foregroundColor(textValid(name: exerciseNameText, numSets: exerciseNumSetsText) ? Color("Mint Green") : Color.gray)
                            .padding()
                    })
                    
                }
            }.padding()
        }
        
        
                .navigationBarBackButtonHidden(true)
                .navigationBarHidden(true)
                .toolbar {
                    
                    
                    ToolbarItemGroup(placement: .keyboard) {
                        
                        // done button
                        Button(action: {
                            dismissKeyboard()
                        }, label: {
                            Text("Done")
                        })
                        Spacer()
                        
                        // up and down arrows on keyboard
                        Button(action: {
                            previous()
                        }, label: {
                            Image(systemName: "chevron.up")
                        })
                        .disabled(hasReachedStart)
                        
                        Button(action: {
                            next()
                        }, label: {
                            Image(systemName: "chevron.down")
                        })
                        .disabled(hasReachedEnd)
                    }
                }
    }
    
    func saveNote() {
//        // If the title is blank, label as untitled
//        if noteTitle.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
//            note.title = "Untitled"
//        }
//
//        // else make the note's title the same as the textField
//        else {
//            note.title = noteTitle
//        }
        if allNotes.notes.contains(note) {
            
            self.presentationMode.wrappedValue.dismiss()
            return
        }
        
        // if there were exercises added, add the note to allNotes
        if !note.exercises.isEmpty {
            let newNote = note.copy()
            allNotes.notes.append(newNote)
        }

        // convert state variables back to default for textField purposes
//        noteTitle = ""
        // convert note back to default
        note.exercises = []
        note.title = ""
        
        self.presentationMode.wrappedValue.dismiss()
        
    }
    
    // adds exercise to note
    func addExerciseToNote(muscleGroupIn: MuscleGroup) {
        
        // convert string from textField to int
        // already checked that it was not nil so we can force unwrap
        let intNumSets = Int(exerciseNumSetsText)
        
        // increment the MuscleGroup's setsWorked by the textField int input
        incrementMuscleGroup(muscleGroupIn: muscleGroupIn, addSets: intNumSets!)
        
        // create an Exercise variable and assign all the necessary attributes
        let someExercise = Exercise(name: exerciseNameText, numSets: intNumSets!, muscleGroup: muscleGroupIn)
//        someExercise.muscleGroup = muscleGroupIn
//        someExercise.name = exerciseNameText
//        someExercise.numSets = intNumSets!
        
        // revert textField state variables back to empty strings
        exerciseNameText = ""
        exerciseNumSetsText = ""
        
        // add the initialized Exercise variable to the note's exercises array
        note.exercises.append(someExercise)

    }
    
    func incrementMuscleGroup(muscleGroupIn: MuscleGroup, addSets: Int) {
        
        // checks to see if the muscleGroup exists in the viewModel and increments the setsWorked
        for i in allMuscleGroups.muscleGroupArray {
            if i.name == muscleGroupIn.name {
                i.setsWorked += addSets
            }
        }
    }
}

private extension CreateNoteView {
    enum Field: Int, Hashable, CaseIterable {
        case title
        case exerciseName
        case numSets
    }
}

private extension CreateNoteView {
    
    var hasReachedEnd:Bool {
        self.focusedInput == Field.allCases.last
    }
    
    var hasReachedStart:Bool {
        self.focusedInput == Field.allCases.first
    }
    
    func dismissKeyboard() {
        self.focusedInput = nil
    }

    func next() {
        
        // make sure that these are unwrappable or else do nothing
        guard let currentInput = focusedInput,
              let lastIndex = Field.allCases.last?.rawValue else {
            return
        }
        
        // go to next index
        // prevents accessing index not in range
        let index = min(currentInput.rawValue + 1, lastIndex)
        self.focusedInput = Field(rawValue: index)
        
    }
    
    func previous() {
        
        guard let currentInput = focusedInput,
              let firstIndex = Field.allCases.first?.rawValue else {
            return
        }
        // get highest value out of two so that we don't get below 0
        let index = max(currentInput.rawValue - 1, firstIndex)
        self.focusedInput = Field(rawValue: index)
    }
}


struct CreateNoteView_Previews: PreviewProvider {
    static var previews: some View {
        CreateNoteView(note: Note())
    }
}
