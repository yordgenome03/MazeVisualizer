//
//  MazeGenerator.swift
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

enum MazeGeneratorType: String, CustomStringConvertible, CaseIterable {
    case recursiveBacktracking = "Recursive Backtracking"
    case growingTree = "Growing Tree"
    case binaryTree = "Binary Tree"

    var description: String { rawValue }
}
