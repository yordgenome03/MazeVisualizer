//
//  MazeListView.swift
//  MazeVisualizer
//
//  Created by yotahara on 2024/07/06.
//

import SwiftUI

struct MazeDataDetailView: View {
    @StateObject var viewModel:  MazeDataDetailViewModel
    @Environment(\.dismiss) var dismiss
    @Namespace var namespace
    
    init(mazeData: MazeData) {
        self._viewModel = StateObject(wrappedValue: MazeDataDetailViewModel(mazeData: mazeData))
    }
    
    var body: some View {
        List {
            Section {
                HStack {
                    Text("Generated by: ")
                        .font(.footnote)
                    Text(viewModel.mazeData.algorithm)
                        .font(.subheadline)
                        .lineLimit(1)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                HStack {
                    Text("Shortest distance: ")
                        .font(.footnote)
                    Text("\(viewModel.mazeData.shortestDistance)")
                        .font(.subheadline)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                HStack {
                    Text("Size: ")
                        .font(.footnote)
                    Text("W:\(viewModel.mazeData.maze[0].count) ✕ H:\(viewModel.mazeData.maze.count)")
                        .font(.subheadline)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                HStack {
                    Text("Show shortest path:")
                        .font(.footnote)
                    Toggle("", isOn: $viewModel.showShortestPath)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            } header: {
                
            }
            
            Section {
                if viewModel.showShortestPath {
                    MazeExplorationView(maze: viewModel.exploredMaze,
                                        shortestDistance: viewModel.mazeData.shortestDistance,
                                        showShortestDistance: false)
                    .frame(maxWidth: .infinity, alignment: .center)
                } else {
                    MazeVisualizationView(maze: viewModel.mazeData.maze)
                        .frame(maxWidth: .infinity, alignment: .center)
                }
            }
            
            Section {
                NavigationLink {
                    MazeGameView(maze: viewModel.mazeData.maze)
                } label: {
                    Text("Play Game")
                        .frame(maxWidth: .infinity, alignment: .center)
                }
                
                Button {
                    viewModel.deleteMazeData()
                    dismiss()
                } label: {
                    Text("Delete data")
                        .foregroundStyle(Color.red)
                        .frame(maxWidth: .infinity, alignment: .center)
                }
            } header: {
                
            }
             
            Spacer()
        }
        .navigationTitle(viewModel.mazeData.name)
    }
}

#Preview {
    NavigationStack {
        MazeDataDetailView(mazeData: MazeData.default)
    }
}
