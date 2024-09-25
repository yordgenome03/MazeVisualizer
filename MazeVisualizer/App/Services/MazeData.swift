//
//  UserDefaultsService.swift
//  MazeVisualizer
//
//  Created by yotahara on 2024/07/06.
//

import Foundation

struct MazePath: Codable, Equatable, Hashable {
    let x: Int
    let y: Int
}

struct MazeData: Codable, Identifiable, Hashable {
    let name: String
    let maze: [[MazeCellState]]
    let algorithm: String
    let shortestPath: [MazePath]
    let shortestDistance: Int
    
    var id: Int { hashValue }
    
    init(name: String, maze: [[MazeCellState]], algorithm: String) {
        self.name = name
        self.maze = maze
        self.algorithm = algorithm
        let (shortestPath, shortestDistance) = BFSMazeExplorer().initializeMazeData(name: name, maze: maze, algorithm: algorithm)
        self.shortestPath = shortestPath
        self.shortestDistance = shortestDistance
    }
    
    static func == (lhs: MazeData, rhs: MazeData) -> Bool {
        return lhs.name == rhs.name &&
        lhs.algorithm == rhs.algorithm &&
        lhs.shortestDistance == rhs.shortestDistance &&
        lhs.maze == rhs.maze &&
        lhs.shortestPath == rhs.shortestPath
    }
    
    static let `default`: MazeData = .init(
        name: "default",
        maze: [
            [
                MazeCellState.wall, MazeCellState.start, MazeCellState.wall, MazeCellState.wall, MazeCellState.wall, MazeCellState.wall, MazeCellState.wall, MazeCellState.wall, MazeCellState.wall, MazeCellState.wall, MazeCellState.wall, MazeCellState.wall, MazeCellState.wall, MazeCellState.wall, MazeCellState.wall, MazeCellState.wall, MazeCellState.wall, MazeCellState.wall, MazeCellState.wall, MazeCellState.wall, MazeCellState.wall
            ],
            [
                MazeCellState.wall, MazeCellState.path, MazeCellState.path, MazeCellState.path, MazeCellState.path, MazeCellState.path, MazeCellState.path, MazeCellState.path, MazeCellState.path, MazeCellState.path, MazeCellState.path, MazeCellState.path, MazeCellState.path, MazeCellState.path, MazeCellState.path, MazeCellState.path, MazeCellState.path, MazeCellState.path, MazeCellState.path, MazeCellState.path, MazeCellState.wall
            ],
            [
                MazeCellState.wall, MazeCellState.path, MazeCellState.wall, MazeCellState.path, MazeCellState.wall, MazeCellState.wall, MazeCellState.wall, MazeCellState.wall, MazeCellState.wall, MazeCellState.wall, MazeCellState.wall, MazeCellState.path, MazeCellState.wall, MazeCellState.wall, MazeCellState.wall, MazeCellState.path, MazeCellState.wall, MazeCellState.wall, MazeCellState.wall, MazeCellState.wall, MazeCellState.wall
            ],
            [
                MazeCellState.wall, MazeCellState.path, MazeCellState.wall, MazeCellState.path, MazeCellState.wall, MazeCellState.path, MazeCellState.path, MazeCellState.path, MazeCellState.path, MazeCellState.path, MazeCellState.wall, MazeCellState.path, MazeCellState.wall, MazeCellState.path, MazeCellState.wall, MazeCellState.path, MazeCellState.wall, MazeCellState.path, MazeCellState.path, MazeCellState.path, MazeCellState.wall
            ],
            [
                MazeCellState.wall, MazeCellState.wall, MazeCellState.wall, MazeCellState.path, MazeCellState.wall, MazeCellState.wall, MazeCellState.wall, MazeCellState.path, MazeCellState.wall, MazeCellState.path, MazeCellState.wall, MazeCellState.wall, MazeCellState.wall, MazeCellState.path, MazeCellState.wall, MazeCellState.path, MazeCellState.wall, MazeCellState.path, MazeCellState.wall, MazeCellState.wall, MazeCellState.wall
            ],
            [
                MazeCellState.wall, MazeCellState.path, MazeCellState.path, MazeCellState.path, MazeCellState.path, MazeCellState.path, MazeCellState.wall, MazeCellState.path, MazeCellState.wall, MazeCellState.path, MazeCellState.path, MazeCellState.path, MazeCellState.path, MazeCellState.path, MazeCellState.wall, MazeCellState.path, MazeCellState.wall, MazeCellState.path, MazeCellState.wall, MazeCellState.path, MazeCellState.wall
            ],
            [
                MazeCellState.wall, MazeCellState.path, MazeCellState.wall, MazeCellState.wall, MazeCellState.wall, MazeCellState.wall, MazeCellState.wall, MazeCellState.path, MazeCellState.wall, MazeCellState.wall, MazeCellState.wall, MazeCellState.path, MazeCellState.wall, MazeCellState.wall, MazeCellState.wall, MazeCellState.path, MazeCellState.wall, MazeCellState.path, MazeCellState.wall, MazeCellState.path, MazeCellState.wall
            ],
            [
                MazeCellState.wall, MazeCellState.path, MazeCellState.wall, MazeCellState.path, MazeCellState.path, MazeCellState.path, MazeCellState.path, MazeCellState.path, MazeCellState.wall, MazeCellState.path, MazeCellState.wall, MazeCellState.path, MazeCellState.path, MazeCellState.path, MazeCellState.path, MazeCellState.path, MazeCellState.wall, MazeCellState.path, MazeCellState.wall, MazeCellState.path, MazeCellState.wall
            ], 
            [
                MazeCellState.wall, MazeCellState.path, MazeCellState.wall, MazeCellState.path, MazeCellState.wall, MazeCellState.wall, MazeCellState.wall, MazeCellState.wall, MazeCellState.wall, MazeCellState.path, MazeCellState.wall, MazeCellState.wall, MazeCellState.wall, MazeCellState.wall, MazeCellState.wall, MazeCellState.path, MazeCellState.wall, MazeCellState.path, MazeCellState.wall, MazeCellState.path, MazeCellState.wall
            ],
            [
                MazeCellState.wall, MazeCellState.path, MazeCellState.wall, MazeCellState.path, MazeCellState.wall, MazeCellState.path, MazeCellState.path, MazeCellState.path, MazeCellState.path, MazeCellState.path, MazeCellState.path, MazeCellState.path, MazeCellState.path, MazeCellState.path, MazeCellState.wall, MazeCellState.path, MazeCellState.wall, MazeCellState.path, MazeCellState.wall, MazeCellState.path, MazeCellState.wall
            ],
            [
                MazeCellState.wall, MazeCellState.path, MazeCellState.wall, MazeCellState.wall, MazeCellState.wall, MazeCellState.path, MazeCellState.wall, MazeCellState.path, MazeCellState.wall, MazeCellState.wall, MazeCellState.wall, MazeCellState.wall, MazeCellState.wall, MazeCellState.wall, MazeCellState.wall, MazeCellState.path, MazeCellState.wall, MazeCellState.path, MazeCellState.wall, MazeCellState.path, MazeCellState.wall
            ],
            [
                MazeCellState.wall, MazeCellState.path, MazeCellState.path, MazeCellState.path, MazeCellState.path, MazeCellState.path, MazeCellState.wall, MazeCellState.path, MazeCellState.wall, MazeCellState.path, MazeCellState.path, MazeCellState.path, MazeCellState.path, MazeCellState.path, MazeCellState.path, MazeCellState.path, MazeCellState.wall, MazeCellState.path, MazeCellState.wall, MazeCellState.path, MazeCellState.wall
            ],
            [
                MazeCellState.wall, MazeCellState.path, MazeCellState.wall, MazeCellState.wall, MazeCellState.wall, MazeCellState.wall, MazeCellState.wall, MazeCellState.path, MazeCellState.wall, MazeCellState.path, MazeCellState.wall, MazeCellState.path, MazeCellState.wall, MazeCellState.wall, MazeCellState.wall, MazeCellState.path, MazeCellState.wall, MazeCellState.path, MazeCellState.wall, MazeCellState.path, MazeCellState.wall
            ],
            [
                MazeCellState.wall, MazeCellState.path, MazeCellState.wall, MazeCellState.path, MazeCellState.wall, MazeCellState.path, MazeCellState.path, MazeCellState.path, MazeCellState.wall, MazeCellState.path, MazeCellState.wall, MazeCellState.path, MazeCellState.wall, MazeCellState.path, MazeCellState.wall, MazeCellState.path, MazeCellState.path, MazeCellState.path, MazeCellState.wall, MazeCellState.path, MazeCellState.wall
            ],
            [
                MazeCellState.wall, MazeCellState.path, MazeCellState.wall, MazeCellState.path, MazeCellState.wall, MazeCellState.wall, MazeCellState.wall, MazeCellState.wall, MazeCellState.wall, MazeCellState.path, MazeCellState.wall, MazeCellState.wall, MazeCellState.wall, MazeCellState.path, MazeCellState.wall, MazeCellState.path, MazeCellState.wall, MazeCellState.wall, MazeCellState.wall, MazeCellState.path, MazeCellState.wall
            ],
            [
                MazeCellState.wall, MazeCellState.path, MazeCellState.wall, MazeCellState.path, MazeCellState.path, MazeCellState.path, MazeCellState.path, MazeCellState.path, MazeCellState.path, MazeCellState.path, MazeCellState.path, MazeCellState.path, MazeCellState.path, MazeCellState.path, MazeCellState.wall, MazeCellState.path, MazeCellState.wall, MazeCellState.path, MazeCellState.path, MazeCellState.path, MazeCellState.wall
            ],
            [
                MazeCellState.wall, MazeCellState.wall, MazeCellState.wall, MazeCellState.path, MazeCellState.wall, MazeCellState.wall, MazeCellState.wall, MazeCellState.path, MazeCellState.wall, MazeCellState.wall, MazeCellState.wall, MazeCellState.path, MazeCellState.wall, MazeCellState.wall, MazeCellState.wall, MazeCellState.path, MazeCellState.wall, MazeCellState.wall, MazeCellState.wall, MazeCellState.path, MazeCellState.wall
            ],
            [
                MazeCellState.wall, MazeCellState.path, MazeCellState.path, MazeCellState.path, MazeCellState.wall, MazeCellState.path, MazeCellState.path, MazeCellState.path, MazeCellState.wall, MazeCellState.path, MazeCellState.wall, MazeCellState.path, MazeCellState.wall, MazeCellState.path, MazeCellState.path, MazeCellState.path, MazeCellState.path, MazeCellState.path, MazeCellState.path, MazeCellState.path, MazeCellState.wall
            ],
            [
                MazeCellState.wall, MazeCellState.wall, MazeCellState.wall, MazeCellState.wall, MazeCellState.wall, MazeCellState.path, MazeCellState.wall, MazeCellState.wall, MazeCellState.wall, MazeCellState.path, MazeCellState.wall, MazeCellState.path, MazeCellState.wall, MazeCellState.path, MazeCellState.wall, MazeCellState.wall, MazeCellState.wall, MazeCellState.wall, MazeCellState.wall, MazeCellState.wall, MazeCellState.wall
            ],
            [
                MazeCellState.wall, MazeCellState.path, MazeCellState.path, MazeCellState.path, MazeCellState.path, MazeCellState.path, MazeCellState.wall, MazeCellState.path, MazeCellState.path, MazeCellState.path, MazeCellState.path, MazeCellState.path, MazeCellState.wall, MazeCellState.path, MazeCellState.path, MazeCellState.path, MazeCellState.path, MazeCellState.path, MazeCellState.path, MazeCellState.path, MazeCellState.wall
            ],
            [
                MazeCellState.wall, MazeCellState.wall, MazeCellState.wall, MazeCellState.wall, MazeCellState.wall, MazeCellState.wall, MazeCellState.wall, MazeCellState.wall, MazeCellState.wall, MazeCellState.wall, MazeCellState.wall, MazeCellState.wall, MazeCellState.wall, MazeCellState.wall, MazeCellState.wall, MazeCellState.wall, MazeCellState.wall, MazeCellState.wall, MazeCellState.wall, MazeCellState.goal, MazeCellState.wall
            ]
        ],
        algorithm: MazeGeneratorType.growingTree.description
    )
}
