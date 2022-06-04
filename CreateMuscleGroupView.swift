//
//  CreateMuscleGroupView.swift
//  workout_app
//
//  Created by Joseph Schaubroeck on 5/30/22.
//

import SwiftUI



struct CreateMuscleGroupView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @EnvironmentObject var allMuscleGroups: AllMuscleGroups
    
    @FocusState private var focusedInput: Field?
    // For recording TextField input
    @State var muscleGroupName = ""
    @State var minTarget = ""
    @State var maxTarget = ""
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading) {
                    Spacer()
                    Text("Muscle Group Name")
                        .font(.title2)
                        
                    TextField("Shoulders", text: $muscleGroupName)
                        .focused($focusedInput, equals: .muscleName)
                        .padding()
                        .background(Color.gray.opacity(0.3).cornerRadius(10))
                        .foregroundColor(.black)
                    .font(.headline)
                    
                    
                    Text("Minimum Target Sets").font(.title2)
                    TextField("12", text: $minTarget)
                        .focused($focusedInput, equals: .minSets)
                        .padding()
                        .background(Color.gray.opacity(0.3).cornerRadius(10))
                        .foregroundColor(.black)
                    .font(.headline)
                    .keyboardType(.decimalPad)
                    
                    
                    Text("Maximum Target Sets").font(.title2)
                    TextField("18", text: $maxTarget)
                        .focused($focusedInput, equals: .maxSets)
                        .padding()
                        .background(Color.gray.opacity(0.3).cornerRadius(10))
                        .foregroundColor(.black)
                    .font(.headline)
                    .keyboardType(.decimalPad)
                    
                    
                    
                    // Create group button
                    
                        Button(action: {
                            if textValid(name: muscleGroupName, min: minTarget, max: maxTarget) {
                              saveGroup()
                            }
                
                        }, label: {
                            Text("Save".uppercased())         .padding()
                                .frame(maxWidth: .infinity)
                                .background(textValid(name: muscleGroupName, min: minTarget, max: maxTarget) ? Color.blue : Color.gray)
                                .cornerRadius(10)
                                .foregroundColor(.white)
                            .font(.headline)
                    }).padding()
                    
                    
                    
                }
                .padding()
            .navigationTitle("Create Group")
            
                
            .onAppear() {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.focusedInput = .muscleName
                }
            }
                
            }
            
            
        
        }
        .toolbar {


            ToolbarItemGroup(placement: .keyboard) {

                
                // done button makes row background white
                
//                 done button
//                Button(action: {
//                    dismissKeyboard()
//                }, label: {
//                    Text("Done")
//                })


                
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
        
// might cause the white block issue
//        .padding(.bottom, 70.0)
        
//        .navigationBarBackButtonHidden(true)
//        .navigationBarHidden(true)
    }
    
    func saveGroup() {
        
        // convert TextField Strings to Ints
        let minTargetInt = Int(minTarget)
        let maxTargetInt = Int(maxTarget)
        
        let addGroup = MuscleGroup(name: muscleGroupName, minTargetSets: minTargetInt!, maxTargetSets: maxTargetInt!)
        
        // add to view model array
        allMuscleGroups.muscleGroupArray.append(addGroup)
        
        
        // convert state values back to empty strings
        muscleGroupName = ""
        minTarget = ""
        maxTarget = ""
        // exit cover
        
        self.presentationMode.wrappedValue.dismiss()
    }
}

private extension CreateMuscleGroupView {
    enum Field: Int, Hashable, CaseIterable {
        case muscleName
        case minSets
        case maxSets
    }
}

private extension CreateMuscleGroupView {
    
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


struct CreateMuscleGroupView_Previews: PreviewProvider {
    static var previews: some View {
        CreateMuscleGroupView()
    }
}
