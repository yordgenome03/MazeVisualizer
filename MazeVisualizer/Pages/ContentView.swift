//
//  ContentView.swift
//  MazeVisualizer
//
//  Created by yotahara on 2024/07/06.
//

import SwiftUI

struct ContentView: View {
    
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
                    
                    NavigationLink {

                    } label: {
                        Text("Maze Shortest Route Search")
                    }
                    
                } header: {
                    Text("Basics")
                }
                
            }
            .navigationTitle("Maze")
        }
    }
}

#Preview {
    ContentView()
}
