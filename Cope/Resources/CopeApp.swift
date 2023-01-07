//
//  CopeApp.swift
//  Cope
//
//  Created by Gary Doering on 1/6/23.
//

import SwiftUI

@main
struct CopeApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            CopeListView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
