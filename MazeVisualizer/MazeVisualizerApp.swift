//
//  MazeVisualizerApp.swift
//  MazeVisualizer
//
//  Created by yotahara on 2024/07/06.
//

import Clients
import Domain
import Features
import SwiftUI

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
