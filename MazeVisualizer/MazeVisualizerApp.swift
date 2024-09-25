//
//  MazeVisualizerApp.swift
//  MazeVisualizer
//
//  Created by yotahara on 2024/07/06.
//

import SwiftUI
import Clients
import Features
import Domain

@main
struct MazeVisualizerApp: App {
    var body: some Scene {
        WindowGroup {            
            TopView(
                store: .init(initialState: Top.State()) {
                    Top()
                }
            )
            .onAppear {
                ClientSample().sampleMethod()
                DomainSample().sampleMethod()
                FeatureSample().sampleMethod()
            }
        }
    }
}
