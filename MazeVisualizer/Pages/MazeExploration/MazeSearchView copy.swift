//
//  MazeSearchView copy.swift
//  MazeVisualizer
//
//  Created by yotahara on 2024/07/06.
//

import SwiftUI

struct MazeGenerationView: View {
    let mazeSize: Int = 27
    @ObservedObject var viewModel: MazeGenerationViewModel

    var body: some View {
        List {
            Section {
                VStack(spacing: 0) {
                    ForEach(0 ..< viewModel.maze.count, id: \.self) { y in
                        HStack(spacing: 0) {
                            ForEach(0 ..< viewModel.maze[y].count, id: \.self) { x in
                                Rectangle()
                                    .fill(self.color(for: viewModel.maze[y][x]))
                                    .frame(width: 10, height: 10)
                            }
                        }
                    }
                }
            }
            .padding()

            Section {
                Button {
                    Task {
                        await viewModel.generateMaze(width: mazeSize, height: mazeSize)
                    }
                } label: {
                    Text("Regenerate")
                        .font(.body.bold())
                        .foregroundStyle(Color.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color.accentColor)
                        )
                }
            } header: {
                Text("Regenerate Maze")
            }

            Section {
                TextField("Maze Name", text: $viewModel.mazeName)
                    .font(.body)
                    .padding()

                Button {
                    viewModel.saveMaze()
                } label: {
                    Text("Save")
                        .font(.body.bold())
                        .foregroundStyle(Color.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color.accentColor)
                        )
                }
            } header: {
                Text("Save Maze")
            }
        }
        .padding()
        .edgesIgnoringSafeArea(.bottom)
        .navigationTitle("Maze Generation")
        .onAppear {
            Task {
                await viewModel.generateMaze(width: mazeSize, height: mazeSize)
            }
        }
    }

    func color(for cell: MazeCell) -> Color {
        switch cell {
        case .wall:
            return .black
        case .path:
            return .white
        case .start:
            return .green
        case .goal:
            return .red
        }
    }
}

#Preview {
    NavigationStack {
        MazeGenerationView(viewModel: MazeGenerationViewModel(algorithm: DiggingAlgorithm()))
    }
}
