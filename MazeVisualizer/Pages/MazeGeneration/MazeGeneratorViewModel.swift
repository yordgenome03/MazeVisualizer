//
//  MazeViewModel.swift
//  MazeVisualizer
//
//  Created by yotahara on 2024/07/06.
//

import SwiftUI

extension Constants {
    static let recursiveBacktracking = "Recursive Backtracking"
    static let growingTree = "Growing Tree"
}

@MainActor
class MazeGeneratorViewModel: ObservableObject {
    @Published var maze: [[MazeCellState]] = []
    @Published var mazeName: String = ""
    @Published var completed = false
    @Published var showSaveMazeView = false
    @Published var width: Int = 21 {
        didSet {
            self.maze = Array(repeating: Array(repeating: .wall, count: width), count: height)
        }
    }
    @Published var height: Int = 21 {
        didSet {
            self.maze = Array(repeating: Array(repeating: .wall, count: width), count: height)
        }
    }
    let generatorList: [String] = [Constants.recursiveBacktracking]
    @Published var selectedGenerator: String = Constants.recursiveBacktracking
    private var currentTask: Task<Void, Never>?
    
    init() {
        self.maze = Array(repeating: Array(repeating: .wall, count: width), count: height)
    }

    func generateMaze() async {
        currentTask?.cancel()
        completed = false

        let generator: MazeGenerator = {
            switch selectedGenerator {
            case Constants.recursiveBacktracking: return DiggingMazeGenerator()
            case Constants.growingTree: return DiggingMazeGenerator()
            default: return DiggingMazeGenerator()
            }
        }()
        
        currentTask = Task {
            let steps = generator.generateMaze(width: width, height: height)

            for step in steps {
                if Task.isCancelled { break }
                await MainActor.run {
                    self.maze = step
                }
                try? await Task.sleep(nanoseconds: 80_000_000)
            }
            
            completed = true
        }
    }
    
    func saveMaze() {
        guard completed && !mazeName.isEmpty else { return }
        let mazeData = MazeData(name: mazeName, maze: maze)
        UserDefaultsService.saveMaze(mazeData)
    }
}

