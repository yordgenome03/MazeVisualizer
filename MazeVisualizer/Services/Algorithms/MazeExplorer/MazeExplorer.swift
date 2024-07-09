//
//  MazeAlgorithm.swift
//  MazeVisualizer
//
//  Created by yotahara on 2024/07/06.
//

import Foundation

protocol MazeExplorer {
    func exploreMaze(maze: [[MazeCellState]], start: (Int, Int)) -> (steps: [[[ExplorationState]]], shortestDistance: Int?)
}

enum ExplorationState: Equatable {
    case notExplored
    case wall
    case path(Int)
    case shortestPath(Int)
    case start
    case goal
}
