//
//  NavigationListView.swift
//  MazeVisualizer
//
//  Created by yotahara on 2024/07/06.
//

import SwiftUI

struct NavigationListView: View {
    var body: some View {
        NavigationStack {
            List {
                Section {
                    NavigationLink {
                        MazeGeneratorView()
                    } label: {
                        Text("Maze Generation")
                    }

                    NavigationLink {
                        MazeExplorerView()
                    } label: {
                        Text("Maze Exploration")
                    }

                } header: {
                    Text("Basics")
                }
            }
            .navigationTitle("Maze Algorithms")
        }
    }
}

#Preview {
    NavigationListView()
}
