//
//  MazeExplorationViewModel.swift
//  MazeVisualizer
//
//  Created by yotahara on 2024/07/06.
//

import SwiftUI
import Combine

@MainActor
class MazeExplorerViewModel: ObservableObject {
    @Published var mazeDataList: [MazeData] = []
    @Published var selectedMazeData: MazeData = MazeData.default {
        didSet {
            shortestDistance = nil
        }
    }
    @Published var currentMaze: [[ExplorationState]] = Array(repeating: Array(repeating: .notExplored, count: 21), count: 21)
    let explorerList: [String] = ["DFS", "BFS"]
    @Published var selectedExplorer: String = "DFS"
    @Published var completed = false
    @Published var isExploring = false
    @Published var shortestDistance: Int?
    private var currentTask: Task<Void, Never>?
    private var cancellables: Set<AnyCancellable> = []
    
    private let repository: MazeRepositoryProtocol = MazeRepository.shared

    init() {
        repository.mazeDataListPublisher
            .sink { [weak self] mazeDataList in
                self?.mazeDataList = mazeDataList
            }
            .store(in: &cancellables)
    }
    
    func exploreMaze() async {
        currentTask?.cancel()
        completed = false
        isExploring = true
        shortestDistance = nil
        
        let explorer: MazeExplorer = {
            switch selectedExplorer {
            case "DFS": return DFSMazeExplorer()
            case "BFS": return BFSMazeExplorer()
            default: return DFSMazeExplorer()
            }
        }()

        let start = (1, 0)
        
        currentTask = Task {
            let (steps, shortestDistance) = explorer.exploreMaze(maze: selectedMazeData.maze, start: start)
            
            for step in steps {
                if Task.isCancelled { break }
                await MainActor.run {
                    self.currentMaze = step
                }
                try? await Task.sleep(nanoseconds: 20_000_000)
            }
            
            self.shortestDistance = shortestDistance
            completed = true
        }
    }
}
