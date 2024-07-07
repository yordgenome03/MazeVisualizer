//
//  MazeGenerator.swift
//  MazeVisualizer
//
//  Created by yotahara on 2024/07/06.
//

import Foundation

class DiggingMazeGenerator: MazeGenerator {
    
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
                
                if nx > 0 && nx < width - 1 && ny > 0 && ny < height - 1 && maze[ny][nx] == .wall {
                    maze[ny][nx] = .path
                    maze[y + dy / 2][x + dx / 2] = .path
                    stack.append((nx, ny))
                    moved = true
                    steps.append(maze)
                    break
                }
            }
            
            if !moved {
                stack.removeLast()
            }
        }
        
        maze[startY][startX] = .path
        maze[startY - 1][startX] = .start
        maze[goalY][goalX] = .path
        maze[goalY + 1][goalX] = .goal
        steps.append(maze)
        
        return steps
    }
}
