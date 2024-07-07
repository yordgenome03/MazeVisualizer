//
//  DFSExploration.swift
//  MazeVisualizer
//
//  Created by yotahara on 2024/07/06.
//

import Foundation

class BFSMazeExplorer: MazeExplorer {
    
    func exploreMaze(maze: [[MazeCellState]], start: (Int, Int)) -> [[[ExplorationState]]] {
        var currentStates: [[ExplorationState]] = Array(repeating: Array(repeating: .notExplored, count: maze[0].count), count: maze.count)
        var queue: [(Int, Int, Int)] = [(start.0, start.1, 0)]  // (x, y, distance)
        var steps: [[[ExplorationState]]] = []
        let directions = [(0, 1), (1, 0), (0, -1), (-1, 0)]
        var cameFrom = Array(repeating: Array(repeating: (-1, -1), count: maze[0].count), count: maze.count)

        currentStates[start.1][start.0] = .start
        steps.append(currentStates.map { $0 })

        var goalPosition: (Int, Int)? = nil

        while !queue.isEmpty {
            let (x, y, dist) = queue.removeFirst()

            if maze[y][x] == .goal {
                currentStates[y][x] = .goal
                steps.append(currentStates.map { $0 })
                goalPosition = (x, y)
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

        // 最短経路のパスを更新
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
        } else {
            print("ゴールにたどり着けませんでした")
        }

        return steps
    }
}
