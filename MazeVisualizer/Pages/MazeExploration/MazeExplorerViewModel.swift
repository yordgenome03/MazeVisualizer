//
//  MazeExplorationViewModel.swift
//  MazeVisualizer
//
//  Created by yotahara on 2024/07/06.
//

import SwiftUI

@MainActor
class MazeExplorerViewModel: ObservableObject {
    @Published var mazeList: [MazeData] = []
    @Published var selectedMazeData: MazeData = MazeData.default
    @Published var currentMaze: [[ExplorationState]] = Array(repeating: Array(repeating: .notExplored, count: 21), count: 21)
    let explorerList: [String] = ["DFS", "BFS"]
    @Published var selectedExplorer: String = "DFS"
    @Published var completed = false
    @Published var isExploring = false
    private var currentTask: Task<Void, Never>?

    init() {
        loadSavedMazes()
    }
    
    func selectMaze(_ mazeData: MazeData) {
        isExploring = false
        selectedMazeData = mazeData
    }

    func loadSavedMazes() {
        mazeList = [MazeData.default]
        let savedMazes = UserDefaultsService.getAllMazes()
        mazeList.append(contentsOf: savedMazes)
    }
    
    func exploreMaze() async {
        currentTask?.cancel()
        completed = false
        isExploring = true
        
        let explorer: MazeExplorer = {
            switch selectedExplorer {
            case "DFS": return DFSMazeExplorer()
            case "BFS": return BFSMazeExplorer()
            default: return DFSMazeExplorer()
            }
        }()


        let start = (1, 0)
        
        currentTask = Task {
            let steps = explorer.exploreMaze(maze: selectedMazeData.maze, start: start)

            for step in steps {
                if Task.isCancelled { break }
                await MainActor.run {
                    self.currentMaze = step
                }
                try? await Task.sleep(nanoseconds: 100_000_000)
            }
            
            completed = true
        }
    }
}
