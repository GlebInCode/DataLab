//
//  DataLabApp.swift
//  DataLab
//
//  Created by Глеб Хамин on 01.07.2025.
//

import SwiftUI
import SwiftData

@main
struct DataLabApp: App {

    var body: some Scene {
        WindowGroup {
            MainView(viewModel: MainViewModel())
        }
        .modelContainer(for: [PersonObjectSD.self, PlanetObjectSD.self])
    }
}
