//
//  MazeExplorerView.swift
//  MazeVisualizer
//
//  Created by yotahara on 2024/07/06.
//

import SwiftUI

struct MazeExplorerView: View {
    @StateObject var viewModel: MazeExplorerViewModel = .init()

    var body: some View {
        List {
            Section {
                Picker("", selection: $viewModel.selectedMazeData) {
                    ForEach(viewModel.mazeDataList, id: \.self) { mazeData in
                        Text(mazeData.name).tag(mazeData.id)
                    }
                }
                .pickerStyle(MenuPickerStyle())
            } header: {
                Text("Selected Maze")
            }

            Section {
                Picker("", selection: $viewModel.selectedExplorer) {
                    ForEach(viewModel.explorerList, id: \.self) { explorer in
                        Text(explorer).tag(explorer)
                    }
                }
                .pickerStyle(MenuPickerStyle())
            } header: {
                Text("Exploration Algorithm")
            }

            if viewModel.isExploring {
                MazeExplorationView(maze: viewModel.currentMaze,
                                    shortestDistance: viewModel.shortestDistance)
                    .frame(maxWidth: .infinity, alignment: .center)
            } else {
                MazeVisualizationView(maze: viewModel.selectedMazeData.maze)
                    .frame(maxWidth: .infinity, alignment: .center)
            }

            Section {
                Button {
                    Task {
                        await viewModel.exploreMaze()
                    }
                } label: {
                    Text("Start Exploration")
                        .frame(maxWidth: .infinity, alignment: .center)
                }
            }
        }
        .padding(.bottom, 24)
        .edgesIgnoringSafeArea(.bottom)
        .navigationTitle("Maze Exploration")
    }
}

#Preview {
    NavigationStack {
        MazeExplorerView(viewModel: .init())
    }
}
