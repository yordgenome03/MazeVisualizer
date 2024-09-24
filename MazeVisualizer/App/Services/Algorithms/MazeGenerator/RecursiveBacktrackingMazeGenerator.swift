//
//  RecursiveBacktrackingMazeGenerator.swift
//  MazeVisualizer
//
//  Created by yotahara on 2024/07/06.
//

import Foundation

class RecursiveBacktrackingMazeGenerator: MazeGenerator {
    
    func generateMaze(width: Int, height: Int) -> [[[MazeCellState]]] {
        var maze = Array(repeating: Array(repeating: MazeCellState.wall, count: width), count: height)
        var stack: [(Int, Int)] = []
        var steps: [[[MazeCellState]]] = []
        
        let startX = 1
        let startY = 1
        let goalX = width - 2
        let goalY = height - 2
        
        maze[startY][startX] = .path
        stack.append((startX, startY))
        
        while !stack.isEmpty {
            let (x, y) = stack.last!
            let directions = [(0, 2), (2, 0), (0, -2), (-2, 0)].shuffled()
            var moved = false
            
            for (dx, dy) in directions {
                let nx = x + dx
                let ny = y + dy
                
                if isValidPosition(nx, ny, width, height) && maze[ny][nx] == .wall {
                    carvePath(&maze, from: (x, y), to: (nx, ny))
                    stack.append((nx, ny))
                    moved = true
                    steps.append(maze.map { $0 })
                    break
                }
            }
            
            if !moved {
                stack.removeLast()
            }
        }
        
        setStartAndGoal(&maze, startX, startY, goalX, goalY)
        steps.append(maze.map { $0 })
        
        return steps
    }
    
    private func isValidPosition(_ x: Int, _ y: Int, _ width: Int, _ height: Int) -> Bool {
        return x > 0 && x < width - 1 && y > 0 && y < height - 1
    }
    
    private func carvePath(_ maze: inout [[MazeCellState]], from: (Int, Int), to: (Int, Int)) {
        let (x1, y1) = from
        let (x2, y2) = to
        maze[y2][x2] = .path
        maze[(y1 + y2) / 2][(x1 + x2) / 2] = .path
    }
    
    private func setStartAndGoal(_ maze: inout [[MazeCellState]], _ startX: Int, _ startY: Int, _ goalX: Int, _ goalY: Int) {
        maze[startY][startX] = .path
        maze[startY - 1][startX] = .start
        maze[goalY][goalX] = .path
        maze[goalY + 1][goalX] = .goal
    }
}
