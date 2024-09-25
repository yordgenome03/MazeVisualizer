//
//  MazeGeneratorView.swift
//  MazeVisualizer
//
//  Created by yotahara on 2024/07/06.
//

import SwiftUI

struct MazeGeneratorView: View {
    @StateObject var viewModel: MazeGeneratorViewModel = .init()

    var body: some View {
        List {
            Section {
                HStack {
                    Text("Width: \(viewModel.width)")
                    Stepper("", value: $viewModel.width, in: 7 ... 31, step: 2)
                }
                HStack {
                    Text("Height: \(viewModel.height)")
                    Stepper("", value: $viewModel.height, in: 7 ... 31, step: 2)
                }
            } header: {
                Text("Maze Size")
            }

            Section {
                Picker("", selection: $viewModel.selectedGenerator) {
                    ForEach(viewModel.generatorList, id: \.self) { generator in
                        Text(generator.description).tag(generator)
                    }
                }
                .pickerStyle(MenuPickerStyle())
            } header: {
                Text("Generation Algorithm")
            }

            Section {
                MazeVisualizationView(maze: viewModel.maze)
                    .frame(maxWidth: .infinity, alignment: .center)
            }
            .padding()

            Section {
                Button {
                    Task {
                        await viewModel.generateMaze()
                    }
                } label: {
                    Text("Generate")
                        .frame(maxWidth: .infinity, alignment: .center)
                }
            } header: {
                Text("Generate Maze")
            }

            if viewModel.completed {
                Section {
                    NavigationLink {
                        MazeGameView(maze: viewModel.makeMazeData()!.maze)
                    } label: {
                        Text("Play")
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                } header: {
                    Text("Play Maze Game")
                }
            }

            Section {
                Button {
                    viewModel.showSaveMazeView.toggle()
                } label: {
                    Text("Save")
                        .frame(maxWidth: .infinity, alignment: .center)
                }
            } header: {
                Text("Save Maze")
            }
        }
        .padding(.bottom, 24)
        .edgesIgnoringSafeArea(.bottom)
        .navigationTitle("Maze Generation")
        .sheet(isPresented: $viewModel.showSaveMazeView, content: {
            SaveMazeView(viewModel: viewModel)
                .presentationDetents(
                    [.height(220)]
                )
        })
    }
}

struct SaveMazeView: View {
    @StateObject var viewModel: MazeGeneratorViewModel
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                TextField("Maze Name", text: $viewModel.mazeName)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color.accentColor)
                    )

                Button {
                    viewModel.saveMaze()
                    dismiss()
                } label: {
                    Text("Save")
                        .font(.body.bold())
                        .foregroundStyle(Color.white)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .fill(Color.accentColor)
                        )
                }
                .disabled(viewModel.mazeName.isEmpty)
            }
            .padding()
            .navigationTitle("Name Maze and Save")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    NavigationStack {
        MazeGeneratorView()
    }
}
