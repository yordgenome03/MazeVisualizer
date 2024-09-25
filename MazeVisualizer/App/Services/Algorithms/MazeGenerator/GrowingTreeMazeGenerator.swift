//
//  GrowingTreeMazeGenerator.swift
//  MazeVisualizer
//
//  Created by yotahara on 2024/07/06.
//

import Foundation

class GrowingTreeMazeGenerator: MazeGenerator {
    func generateMaze(width: Int, height: Int) -> [[[MazeCellState]]] {
        var maze = initializeMaze(width: width, height: height)
        var positions = initializePositions(width: width, height: height)
        var steps: [[[MazeCellState]]] = []
        let directions = [(0, -1), (1, 0), (0, 1), (-1, 0)]

        positions.shuffle()

        while !positions.isEmpty {
            let (x, y) = positions.removeFirst()
            createWall(&maze, x, y, &positions, &steps, directions)
        }

        setStartAndGoal(&maze, width: width, height: height)
        steps.append(maze.map { $0 })
        return steps
    }

    private func initializeMaze(width: Int, height: Int) -> [[MazeCellState]] {
        var maze = Array(repeating: Array(repeating: MazeCellState.path, count: width), count: height)
        for y in 0 ..< height {
            maze[y][0] = .wall
            maze[y][width - 1] = .wall
        }
        for x in 0 ..< width {
            maze[0][x] = .wall
            maze[height - 1][x] = .wall
        }
        return maze
    }

    private func initializePositions(width: Int, height: Int) -> [(Int, Int)] {
        var positions: [(Int, Int)] = []
        for y in stride(from: 0, to: height, by: 2) {
            positions.append((0, y))
            positions.append((width - 1, y))
        }
        for x in stride(from: 0, to: width, by: 2) {
            positions.append((x, 0))
            positions.append((x, height - 1))
        }
        return positions
    }

    private func createWall(_ maze: inout [[MazeCellState]], _ x: Int, _ y: Int, _ positions: inout [(Int, Int)], _ steps: inout [[[MazeCellState]]], _ directions: [(Int, Int)]) {
        var dirs = directions.shuffled()

        while let dir = dirs.popLast() {
            let tx = x + dir.0
            let ty = y + dir.1
            let tx2 = x + dir.0 * 2
            let ty2 = y + dir.1 * 2

            if isValidWallPosition(tx2, ty2, maze) && maze[ty][tx] == .path && maze[ty2][tx2] == .path {
                maze[ty][tx] = .wall
                maze[ty2][tx2] = .wall

                positions.insert((tx2, ty2), at: 0)
                positions.append((x, y))
                steps.append(maze.map { $0 })
                break
            }
        }
    }

    private func isValidWallPosition(_ x: Int, _ y: Int, _ maze: [[MazeCellState]]) -> Bool {
        return x > 0 && x < maze[0].count && y > 0 && y < maze.count
    }

    private func setStartAndGoal(_ maze: inout [[MazeCellState]], width: Int, height: Int) {
        maze[0][1] = .start
        maze[height - 1][width - 2] = .goal
    }
}
