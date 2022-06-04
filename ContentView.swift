//
//  ContentView.swift
//  workout_app
//
//  Created by Joseph Schaubroeck on 5/5/22.
//

import SwiftUI

struct ContentView: View {
    
    
    init() {
        UITableView.appearance().backgroundColor = .clear
    }
    
    // light gray
    let secondarySystem = Color(UIColor.secondarySystemBackground)
  
    @State var currentSets = 0
    
    @State var searchBarTest = ""
    

    @State var selectedIndex = 0
    
    @State var muscleGroupName = ""

    
    @StateObject var allMuscleGroups:AllMuscleGroups = AllMuscleGroups()
    
    
    // Notes Tab
    @StateObject var allNotes = Notes()
    @State var noteTitle = ""
    @State var testArray = ["Yaat", "Yeet", "Yiit", "Yoot", "Yuut"]
    
    
    // Workout view
    @ObservedObject var note = Note()
//    @State var exerciseNameText = ""
//    @State var exerciseNumSetsText = ""
    // Add exercise tab
//    @State var showAddExercise = false
    
    let tabBarImageNames = ["rectangle.3.group.fill", "square.and.pencil", "calendar", "gear"]
   
    var body: some View {

        NavigationView {
            ZStack {
    
                // background
                Color(.white).ignoresSafeArea()
                
                VStack {
                    switch selectedIndex {
                        
// MARK: Muscle Group Stats
                    case 0:
                        
                        if allMuscleGroups.muscleGroupArray.isEmpty {
                            Spacer()
                            Text("Create a muscle group to begin").italic().foregroundColor(.gray)
                        }
                        
                        else {
                            List(allMuscleGroups.muscleGroupArray) { item in
                                
                                Section {
                            // NAME                 12/18
                                    HStack {
                                        
                                        Text(item.name)
                                        Spacer()
                                        FractionText(numerator: item.setsWorked, denominator: item.maxTargetSets)
                                        Button(action: {
                                            item.setsWorked += 1
                                            
                                        }, label: {
                                            Text("Increment")
                                        })
                                        
                                    }
                                    
                                }
                                .listRowBackground(item.rowColor)
                            }
                            .listStyle(InsetGroupedListStyle())
                            .environment(\.horizontalSizeClass, .regular)
                        }
                        
                        
                        Spacer()
    //MARK: Go to CreateMuscleGroupView

                        NavigationLink(destination: CreateMuscleGroupView(), label: {
                            Image(systemName: "plus.app.fill")
                                .font(.system(size: 40, weight: .bold))
                                .foregroundColor(Color("Mint Green"))
                                .padding()

                        })
                        .navigationBarTitle("Muscle Groups")
                        

// MARK: Workout Notes Tab
                    case 1:
                            VStack {
                                
                                // search bar IMPLEMENT LATER
                                HStack {
                                    Image(systemName: "magnifyingglass").font(.title3).foregroundColor(.gray)
                                    TextField("Search", text: .constant(""))
                                }
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .overlay(
                                    Rectangle()
                                        .fill(Color.gray.opacity(0.15))
                                        .frame(height: 1)
                                        .padding(.horizontal, -25.0)
                                        .offset(y: 6),
                                    alignment: .bottom
                                )
                                
                                
                                List(allNotes.notes) { item in
                                    NavigationLink(destination: CreateNoteView(note: item), label: {
                                        HStack {
                                            Text(item.title)
                                        }
                                    })
                                    .listRowBackground(secondarySystem)
                                }
                                Spacer()

                                NavigationLink(destination: CreateNoteView(note: note), label: {
                                    ZStack {
                                        Image(systemName: "square.fill").font(.system(size: 40))
                                            .foregroundColor(Color("Mint Green"))
                                        Image(systemName: "pencil").font(.system(size: 30, weight: .bold))
                                            .foregroundColor(.white)

                                    }

                                        .padding()
                                })
                            }
                        
                        .navigationBarTitle("Workout Notes")
                        
                        
                        
                    case 2:
// MARK: Workout Log Notes
                        NavigationView {
                            Button(action: {
                                if (!allMuscleGroups.muscleGroupArray.isEmpty) {
                                    for item in allMuscleGroups.muscleGroupArray {
                                        item.setsWorked += 1
                                    }
                                }
                            }, label: {
                                Text("Increment")
                        })
                        }

                    case 3:
                        NavigationView {
                            Text("Settings")
                        }
                    default: 
                        NavigationView {
                            Text("Remaining Tabs")
                        }

                    }
                    // MARK: Bottom Navigation Tab
                    HStack {
                        ForEach(0..<4) { num in
                            Button(action: {
                                selectedIndex = num
                            }, label: {
                                Spacer()
                                Image(systemName: tabBarImageNames[num])
                                    .font(.system(size: 24, weight: .bold))
                                    .foregroundColor(selectedIndex == num ? Color(.black) : .init(white: 0.75))

                                Spacer()
                            })
                        }
                    }
                }
            }
        }
        .environmentObject(allMuscleGroups)
        .environmentObject(allNotes)
        .preferredColorScheme(ColorScheme.light)

    }
    // takes in a muscle group and the number of sets that the user wants to add to that muscle group
    func incrementMuscleGroup(muscleGroupIn: MuscleGroup, addSets: Int) {
        
        // checks to see if the muscleGroup exists in the viewModel and increments the setsWorked
        for i in allMuscleGroups.muscleGroupArray {
            if i.name == muscleGroupIn.name {
                i.setsWorked += addSets
            }
        }
    }
}
    

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
