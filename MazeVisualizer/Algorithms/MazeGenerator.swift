//
//  MazeAlgorithm.swift
//  MazeVisualizer
//
//  Created by yotahara on 2024/07/06.
//

import Foundation

protocol MazeGenerator {
    func generateMaze(width: Int, height: Int) -> [[[MazeCellState]]]
}

protocol MazeExplorer {
    func exploreMaze(maze: [[MazeCellState]], start: (Int, Int)) -> [[[ExplorationState]]]
}

enum MazeCellState: Codable {
    case wall
    case path
    case start
    case goal
}

enum ExplorationState {
    case notExplored
    case wall
    case path
    case start
    case goal
}
