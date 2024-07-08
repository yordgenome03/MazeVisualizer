//
//  MazeListView.swift
//  MazeVisualizer
//
//  Created by yotahara on 2024/07/06.
//

import SwiftUI

class MazeDataDetailViewModel: ObservableObject {
    let mazeData: MazeData
    @Published var showShortestPath = false
    let repository: MazeRepositoryProtocol = MazeRepository.shared
    
    private var _exploredMaze: [[ExplorationState]]?
    var exploredMaze: [[ExplorationState]] {
        if let _exploredMaze = _exploredMaze { return _exploredMaze }
        
        var newMaze: [[ExplorationState]] = mazeData.maze.map { row in
            row.map { cell in
                switch cell {
                case .path:
                    return .path(0)
                case .wall:
                    return .wall
                case .start:
                    return .start
                case .goal:
                    return .goal
                }
            }
        }
        
        for path in mazeData.shortestPath {
            let x = path.x
            let y = path.y
            if y < newMaze.count && x < newMaze[y].count {
                newMaze[y][x] = .shortestPath(0)
            }
        }
        
        _exploredMaze = newMaze
        return newMaze
    }
    
    init(mazeData: MazeData) {
        self.mazeData = mazeData
    }
    
    func deleteMazeData() {
        repository.deleteMaze(mazeData)
    }
}
