//
//  MazeViewModel.swift
//  MazeVisualizer
//
//  Created by yotahara on 2024/07/06.
//

import SwiftUI

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
    let generatorList: [MazeGeneratorType] = MazeGeneratorType.allCases
    @Published var selectedGenerator: MazeGeneratorType = .recursiveBacktracking
    private var algorithm: MazeGeneratorType = .recursiveBacktracking
    private var currentTask: Task<Void, Never>?
    
    private let repository: MazeRepositoryProtocol = MazeRepository.shared

    init() {
        self.maze = Array(repeating: Array(repeating: .wall, count: width), count: height)
    }

    func generateMaze() async {
        currentTask?.cancel()
        completed = false
        algorithm = selectedGenerator
        
        let generator: MazeGenerator = {
            switch selectedGenerator {
            case .recursiveBacktracking: return RecursiveBacktrackingMazeGenerator()
            case .growingTree: return GrowingTreeMazeGenerator()
            case .binaryTree: return BinaryTreeMazeGenerator()
            }
        }()
        
        currentTask = Task {
            let steps = generator.generateMaze(width: width, height: height)

            for step in steps {
                if Task.isCancelled { break }
                await MainActor.run {
                    self.maze = step
                }
                try? await Task.sleep(nanoseconds: 50_000_000)
            }
            
            completed = true
        }
    }
    
    func saveMaze() {
        guard completed && !mazeName.isEmpty else { return }
        let mazeData = MazeData(name: mazeName, maze: maze, algorithm: algorithm.description)
        repository.saveMaze(mazeData)
    }
}

