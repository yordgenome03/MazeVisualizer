//
//  DFSExploration.swift
//  MazeVisualizer
//
//  Created by yotahara on 2024/07/06.
//

import Foundation

class BFSMazeExplorer: MazeExplorer {
    private var shortestPath: [MazePath]?
    
    func exploreMaze(maze: [[MazeCellState]], start: (Int, Int)) -> (steps: [[[ExplorationState]]], shortestDistance: Int?) {
        var currentStates: [[ExplorationState]] = Array(repeating: Array(repeating: .notExplored, count: maze[0].count), count: maze.count)
        var queue: [(Int, Int, Int)] = [(start.0, start.1, 0)]  // (x, y, distance)
        var steps: [[[ExplorationState]]] = []
        let directions = [(0, 1), (1, 0), (0, -1), (-1, 0)]
        var cameFrom = Array(repeating: Array(repeating: (-1, -1), count: maze[0].count), count: maze.count)
        
        currentStates[start.1][start.0] = .start
        steps.append(currentStates.map { $0 })
        
        var goalPosition: (Int, Int)? = nil
        var shortestDistance: Int? = nil
        var shortestPath: [MazePath] = []
        
        while !queue.isEmpty {
            let (x, y, dist) = queue.removeFirst()
            
            if maze[y][x] == .goal {
                currentStates[y][x] = .goal
                steps.append(currentStates.map { $0 })
                goalPosition = (x, y)
                shortestDistance = dist
                break
            }
            
            for (dx, dy) in directions {
                let nx = x + dx
                let ny = y + dy
                
                if nx >= 0 && nx < maze[0].count && ny >= 0 && ny < maze.count && currentStates[ny][nx] == .notExplored {
                    if maze[ny][nx] == .wall {
                        currentStates[ny][nx] = .wall
                    } else {
                        currentStates[ny][nx] = .path(dist + 1)
                        queue.append((nx, ny, dist + 1))
                        cameFrom[ny][nx] = (x, y)
                        steps.append(currentStates.map { $0 })
                    }
                }
            }
        }
        
        if let goalPosition = goalPosition {
            var current = goalPosition
            while current != start {
                let (x, y) = current
                if currentStates[y][x] != .start && currentStates[y][x] != .goal {
                    let distance: Int
                    switch currentStates[y][x] {
                    case .path(let dist):
                        distance = dist
                    case .shortestPath(let dist):
                        distance = dist
                    default:
                        distance = 0
                    }
                    currentStates[y][x] = .shortestPath(distance)
                }
                steps.append(currentStates.map { $0 })
                current = cameFrom[y][x]
            }
            
            var path: [(Int, Int)] = []
            var backtrack = goalPosition
            while backtrack != start {
                path.append(backtrack)
                backtrack = cameFrom[backtrack.1][backtrack.0]
            }
            path.append(start)
            path = path.filter { (x, y) in
                !(x == goalPosition.0 && y == goalPosition.1)
            }
            shortestPath = path.map { MazePath(x: $0.0, y: $0.1) }
        } else {
            print("ゴールにたどり着けませんでした")
        }
        
        self.shortestPath = shortestPath
        return (steps, shortestDistance)
    }
    
    func initializeMazeData(name: String, maze: [[MazeCellState]], algorithm: String) -> (shortestPath: [MazePath], shortestDistance: Int) {
        let start = (1, 1)
        let (_, shortestDistance) = exploreMaze(maze: maze, start: start)
        return (shortestPath: shortestPath ?? [], shortestDistance: shortestDistance ?? 0)
    }
}

