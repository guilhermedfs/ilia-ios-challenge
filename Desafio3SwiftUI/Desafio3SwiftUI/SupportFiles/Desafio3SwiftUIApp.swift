//
//  Desafio3SwiftUIApp.swift
//  Desafio3SwiftUI
//
//  Created by Guilherme - ília on 27/12/21.
//

import SwiftUI

@main
struct Desafio3SwiftUIApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            PreLaunchView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
