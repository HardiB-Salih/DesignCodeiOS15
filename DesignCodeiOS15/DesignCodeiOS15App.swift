//
//  DesignCodeiOS15App.swift
//  DesignCodeiOS15
//
//  Created by HardiBSalih on 28.11.2022.
//

import SwiftUI

@main
struct DesignCodeiOS15App: App {
    @StateObject var model = Model()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(model)
        }
    }
}
