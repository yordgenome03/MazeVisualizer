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

enum MazeCellState: Codable {
    case wall
    case path
    case start
    case goal
}
