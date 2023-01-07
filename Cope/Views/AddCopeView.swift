//
//  AddCopeView.swift
//  Cope
//
//  Created by Gary Doering on 1/6/23.
//

import SwiftUI

struct AddCopeView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [],
        animation: .default)
    private var items: FetchedResults<Item>
    
    // View Controls
    @Binding var isShowingSheet: Bool
    @Binding var isShowingCancelAlert: Bool
    @Binding var isShowingSavingErrorAlert: Bool
    @Binding var isShowingDeletingErrorAlert: Bool
    
    // Add Form State
    @State private var name: String = ""
    @State private var details: String = ""
    @State private var type: String = "Movement"
    @State private var symbol: String = "figure.walk"
    @State private var isDistraction: Bool = false
    @State private var inExtremePain: Bool = false
    @State private var duringDizziness: Bool = false
    @State private var whileExercising: Bool = false
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Strategy Name", text: $name)
                    Picker("Strategy Type", selection: $type) {
                        Text("Movement").tag("Movement")
                        Text("Stretch").tag("Stretch")
                        Text("Grounding").tag("Grounding")
                    }
                }

                Section {
                    Toggle(isOn: $inExtremePain) {
                        Text("Helpful in Extreme Pain")
                    }
                    Toggle(isOn: $duringDizziness) {
                        Text("Helpful During Dizziness")
                    }
                    Toggle(isOn: $whileExercising) {
                        Text("Helpful while Exercising")
                    }
                    Toggle(isOn: $isDistraction) {
                        Text("Is Distraction?")
                    }
                }

                Section {
                    Picker("Strategy Icon", selection: $symbol) {
                        Label("Walking", systemImage: "figure.walk").tag("figure.walk")
                        Label("Hands", systemImage: "hands.sparkles").tag("hands.sparkles")
                        Label("Meditation", systemImage: "figure.mind.and.body").tag("figure.mind.and.body")
                        Label("Wheelchair", systemImage: "figure.roll").tag("figure.roll")
                        Label("Stretch", systemImage: "figure.cooldown").tag("figure.cooldown")
                        Label("Exercise", systemImage: "figure.core.training").tag("figure.core.training")
                        Label("Dance", systemImage: "figure.dance").tag("figure.dance")
                        Label("Martial Arts", systemImage: "figure.martial.arts").tag("figure.martial.arts")
                    }
                }

                Section("Enter any other details below") {
                    TextEditor(text: $details)
                        .frame(maxWidth: .infinity)
                }
            }

            // Add Form Toolbar
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        addItem()
                        isShowingSheet = false
                        clearAllAdding()
                    } label: {
                        Text("Done")
                            .fontWeight(.medium)
                    }
                    .disabled(name == "")
                }

                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        if name != "" || details != "" {
                            isShowingCancelAlert = true
                        } else {
                            isShowingSheet = false
                            clearAllAdding()
                        }
                    }
                    // Cancel Alert
                    .alert("Do you want to cancel?", isPresented: $isShowingCancelAlert) {
                        Button("Yes", role: .destructive) {
                            isShowingCancelAlert = false
                            isShowingSheet = false
                            clearAllAdding()
                        }

                        Button("No", role: .cancel) {
                            isShowingCancelAlert = false
                        }
                    }
                }
            }
            .navigationTitle("Add Strategy")
        }
    }
    
    //     Add Item
        private func addItem() {
            withAnimation {
                let newItem = Item(context: viewContext)
                newItem.name = name
                newItem.symbol = symbol
                newItem.details = details
                newItem.type = type
                newItem.whileExercising = whileExercising
                newItem.painHelpful = inExtremePain
                newItem.dizzyHelpful = duringDizziness
                newItem.isDistraction = isDistraction
                newItem.usedCount = 0

                do {
                    try viewContext.save()
                } catch {
                    isShowingSavingErrorAlert = true
                }
            }
        }
    
    //     Clear Add Form
        private func clearAllAdding() {
            name = ""
            details = ""
            type = ""
            symbol = ""
            inExtremePain = false
            duringDizziness = false
            whileExercising = false
            isDistraction = false
        }
}

struct AddCopeView_Previews: PreviewProvider {
    static var previews: some View {
        AddCopeView(isShowingSheet: .constant(true), isShowingCancelAlert: .constant(false), isShowingSavingErrorAlert: .constant(false), isShowingDeletingErrorAlert: .constant(false))
    }
}
