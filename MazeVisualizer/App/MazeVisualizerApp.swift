//
//  MazeVisualizerApp.swift
//  MazeVisualizer
//
//  Created by yotahara on 2024/07/06.
//

import SwiftUI
import Clients

@main
struct MazeVisualizerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear {
                    CoreSample().coreSampleMethod()
                }
        }
    }
}
