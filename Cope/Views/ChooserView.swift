//
//  ChooserView.swift
//  Cope
//
//  Created by Gary Doering on 1/6/23.
//

import SwiftUI

struct ChooserView: View {
    // Core Data
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [],
        animation: .default)
    private var items: FetchedResults<Item>

    // View Controls
    @State private var movementSheet: Bool = false
    @State private var stretchSheet: Bool = false
    @State private var groundingSheet: Bool = false
    @State private var randomSheet: Bool = false

    var body: some View {
        Menu {
            Section {
                Button {
                    randomSheet = true
                } label: {
                    Label("Choose Total Random", systemImage: "arrow.triangle.swap")
                }
                .disabled(disabledAll())
            }

            Section("Choose a random...") {
                Button {
                    movementSheet = true
                } label: {
                    Label("Movement", systemImage: "figure.jumprope")
                }
                .disabled(disabledFinder("Movement"))

                Button {
                    stretchSheet = true
                } label: {
                    Label("Stretch", systemImage: "figure.strengthtraining.functional")
                }
                .disabled(disabledFinder("Stretch"))

                Button {
                    groundingSheet = true
                } label: {
                    Label("Grounding", systemImage: "figure.mind.and.body")
                }
                .disabled(disabledFinder("Grounding"))
            }
        } label: {
            ChooserButtonView()
        }

        .sheet(isPresented: $movementSheet) {
            NavigationView {
                CopeDetailView(item: findRandom("Movement"))
                    .toolbar {
                        Button {
                            movementSheet = false
                        } label: {
                            Label("Close", systemImage: "xmark")
                        }
                    }
            }
        }

        .sheet(isPresented: $stretchSheet) {
            NavigationView {
                CopeDetailView(item: findRandom("Stretch"))
                    .toolbar {
                        Button {
                            stretchSheet = false
                        } label: {
                            Label("Close", systemImage: "xmark")
                        }
                    }
            }
        }

        .sheet(isPresented: $groundingSheet) {
            NavigationView {
                CopeDetailView(item: findRandom("Grounding"))
                    .toolbar {
                        Button {
                            groundingSheet = false
                        } label: {
                            Label("Close", systemImage: "xmark")
                        }
                    }
            }
        }

        .sheet(isPresented: $randomSheet) {
            let found = items.randomElement()
            NavigationView {
                CopeDetailView(item: found!)
                    .toolbar {
                        Button {
                            groundingSheet = false
                        } label: {
                            Label("Close", systemImage: "xmark")
                        }
                    }
            }
        }
    }
    
    func disabledAll() -> Bool {
        if items.count != 0 {
            return false
        } else {
            return true
        }
    }
    
    func disabledFinder(_ type: String) -> Bool {
        var typeSet: Set<String> = []
        for item in items {
            typeSet.insert(item.type ?? "")
        }
        
        if typeSet.contains(type) {
            return false
        } else {
            return true
        }
    }

    func findRandom(_ type: String) -> Item {
        var found = items.randomElement()
        while found?.type != "\(type)" {
            found = items.randomElement()
        }
        return found!
    }
}

struct ChooserView_Previews: PreviewProvider {
    static var previews: some View {
        ChooserView()
            .previewLayout(.sizeThatFits)
    }
}
