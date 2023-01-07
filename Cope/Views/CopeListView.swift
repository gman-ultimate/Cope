//
//  CopeListView.swift
//  Cope
//
//  Created by Gary Doering on 1/6/23.
//

import CoreData
import SwiftUI

struct CopeListView: View {
    // Core Data
    @Environment(\.managedObjectContext) private var viewContext
    
    @SectionedFetchRequest<String, Item>(
        sectionIdentifier: \.type!,
        sortDescriptors: [SortDescriptor(\.name, order: .reverse)]
    )
    private var mySections: SectionedFetchResults<String, Item>
    
    // View Controls
    @State private var isShowingSheet: Bool = false
    @State private var isShowingCancelAlert: Bool = false
    @State private var isShowingSavingErrorAlert: Bool = false
    @State private var isShowingDeletingErrorAlert: Bool = false
    
    // Primary View
    var body: some View {
        NavigationView {
            ZStack {
                Color("Background")
                    .ignoresSafeArea()
                strategyList
                    .sheet(isPresented: $isShowingSheet) {
                        AddCopeView(isShowingSheet: $isShowingSheet, isShowingCancelAlert: $isShowingCancelAlert, isShowingSavingErrorAlert: $isShowingSavingErrorAlert, isShowingDeletingErrorAlert: $isShowingDeletingErrorAlert)
                    }
                    .navigationTitle("Cope")
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button {
                                isShowingSheet = true
                            } label: {
                                Label("Add Strategy", systemImage:  "plus.circle.fill")
                                    .imageScale(.large)
                            }
                        }
                    }
            }
        }
        .overlay(content: {
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    ChooserView()
                        .padding(.trailing, 30)
                }
            }
        })
        .alert("Couldn't Save Strategy", isPresented: $isShowingSavingErrorAlert) {
            Text("ERROR 001, if this continues to happen, please reinstall the app and restart your device.")
            Button("Ok", role: .cancel) { }
        }
        .alert("Failed to Delete Strategy", isPresented: $isShowingDeletingErrorAlert) {
            Text("ERROR 002, if this continues to happen, please reinstall the app and restart your device.")
            Button("Ok", role: .cancel) { }
        }
    }
    
    var strategyList: some View {
        List {
            ForEach(mySections) { section in
                Section(section.id) {
                    ForEach(section) { item in
                        NavigationLink {
                            CopeDetailView(item: item)
                        } label: {
                            Label(item.name ?? "Strategy name not found", systemImage: "\(item.symbol ?? "exclamationmark.triangle.fill")")
                        }
                        .swipeActions(content: {
                            Button(role: .destructive, action: {
                                deleteItem(item: item)
                            }, label: {
                                Label("Delete", systemImage: "trash")
                            })
                        })
                    }
                }
            }
        }
#if os(iOS)
        .listStyle(.insetGrouped)
#endif
    }
    
    public func deleteItem(item: Item) {
        viewContext.delete(item)
        do {
            try viewContext.save()
        } catch {
            print(error)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CopeListView()
    }
}
