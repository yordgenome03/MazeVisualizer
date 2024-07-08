//
//  BinaryTreeMazeGenerator.swift
//  MazeVisualizer
//
//  Created by yotahara on 2024/07/06.
//

import Foundation

class BinaryTreeMazeGenerator: MazeGenerator {
    
    func generateMaze(width: Int, height: Int) -> [[[MazeCellState]]] {
        var maze = initializeMaze(width: width, height: height)
        var steps: [[[MazeCellState]]] = []
        
        for y in stride(from: 2, to: height - 1, by: 2) {
            for x in stride(from: 2, to: width - 1, by: 2) {
                var directions = [(1, 0), (0, 1)]  // Right or Down
                if y == 2 {
                    directions.append((0, -1))  // Up if in the top row
                }
                
                let dir = directions.randomElement()!
                let tx = x + dir.0
                let ty = y + dir.1
                if tx >= 0 && tx < width && ty >= 0 && ty < height {
                    maze[ty][tx] = .wall
                }
                
                steps.append(maze.map { $0 })
            }
        }
        
        setStartAndGoal(&maze, width: width, height: height)
        steps.append(maze.map { $0 })
        return steps
    }
    
    private func initializeMaze(width: Int, height: Int) -> [[MazeCellState]] {
        var maze = Array(repeating: Array(repeating: MazeCellState.path, count: width), count: height)
        for y in 0..<height {
            for x in 0..<width {
                if x == 0 || x == width - 1 || y == 0 || y == height - 1 {
                    maze[y][x] = .wall
                } else if x % 2 == 0 && y % 2 == 0 {
                    maze[y][x] = .wall
                }
            }
        }
        return maze
    }
    
    private func setStartAndGoal(_ maze: inout [[MazeCellState]], width: Int, height: Int) {
        maze[0][1] = .start
        maze[height - 1][width - 2] = .goal
    }
}
