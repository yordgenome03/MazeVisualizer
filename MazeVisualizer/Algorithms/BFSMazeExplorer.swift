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
        var queue: [(Int, Int)] = [start]
        var steps: [[[ExplorationState]]] = []
        let directions = [(0, 1), (1, 0), (0, -1), (-1, 0)]

        currentStates[start.1][start.0] = .start
        steps.append(currentStates.map { $0 })

        while !queue.isEmpty {
            let (x, y) = queue.removeFirst()

            if maze[y][x] == .goal {
                currentStates[y][x] = .goal
                steps.append(currentStates.map { $0 })
                break
            }

            for (dx, dy) in directions {
                let nx = x + dx
                let ny = y + dy

                if nx >= 0 && nx < maze[0].count && ny >= 0 && ny < maze.count && currentStates[ny][nx] == .notExplored {
                    if maze[ny][nx] == .wall {
                        currentStates[ny][nx] = .wall
                    } else {
                        currentStates[ny][nx] = .path
                        queue.append((nx, ny))
                        steps.append(currentStates.map { $0 })  // Update step after modifying currentStates
                    }
                }
            }
        }

        return steps
    }
}
