//
//  MazeGameManager.swift
//  MazeVisualizer
//
//  Created by yotahara on 2024/07/06.
//

import Foundation

enum MazeCellExplorationState: Equatable {
    case notExplored
    case wall
    case path
    case start
    case goal
}

class MazeGameManager {
    private var maze: [[MazeCellState]]
    private(set) var exploredMaze: [[MazeCellExplorationState]]
    private(set) var player: Player
    private var completed = false
    var aaImage: String {
        aaBuilder.buildAAImage(forConfiguration: player.sightWallConfigurations)
    }

    let playerStartPosition: (x: Int, y: Int) = (1, 0)

    private let aaBuilder = AsciiArtBuilder()

    init(maze: [[MazeCellState]]?) {
        self.maze = maze ?? [[]]
        exploredMaze = Array(repeating: Array(repeating: .notExplored, count: self.maze[0].count), count: self.maze.count)
        player = Player(position: playerStartPosition, direction: .down, maze: self.maze)
        exploreVisibleArea()
    }

    func applyMaze(_ newMaze: [[MazeCellState]]?) {
        completed = false
        maze = newMaze ?? maze
        exploredMaze = Array(repeating: Array(repeating: .notExplored, count: maze[0].count), count: maze.count)
        player = Player(position: playerStartPosition, direction: .down, maze: maze)
        exploreVisibleArea()
    }

    func exploreVisibleArea() {
        guard !maze.isEmpty else {
            return
        }
        let frontPositions = getFrontPositions()

        for (index, position) in frontPositions.enumerated() {
            let (x, y) = position
            if x >= 0, x < maze[0].count, y >= 0, y < maze.count {
                if index == 2 { // 進行方向2マス目
                    let (x1, y1) = frontPositions[1]
                    if maze[y1][x1] == .wall {
                        continue // 進行方向1マス目が壁なら進行方向2マス目は更新しない
                    }
                }
                switch maze[y][x] {
                case .path:
                    exploredMaze[y][x] = .path
                case .wall:
                    exploredMaze[y][x] = .wall
                case .start:
                    exploredMaze[y][x] = .start
                case .goal:
                    exploredMaze[y][x] = .goal
                }
            }
        }
    }

    private func getFrontPositions() -> [(x: Int, y: Int)] {
        var positions: [(x: Int, y: Int)] = []
        let (x, y) = player.position
        positions.append((x, y))

        switch player.direction {
        case .up:
            positions.append((x, y - 1))
            positions.append((x, y - 2))
            positions.append((x - 1, y - 1))
            positions.append((x + 1, y - 1))
            positions.append((x - 1, y))
            positions.append((x + 1, y))
        case .down:
            positions.append((x, y + 1))
            positions.append((x, y + 2))
            positions.append((x - 1, y + 1))
            positions.append((x + 1, y + 1))
            positions.append((x - 1, y))
            positions.append((x + 1, y))
        case .left:
            positions.append((x - 1, y))
            positions.append((x - 2, y))
            positions.append((x - 1, y - 1))
            positions.append((x - 1, y + 1))
            positions.append((x, y - 1))
            positions.append((x, y + 1))
        case .right:
            positions.append((x + 1, y))
            positions.append((x + 2, y))
            positions.append((x + 1, y - 1))
            positions.append((x + 1, y + 1))
            positions.append((x, y - 1))
            positions.append((x, y + 1))
        }

        return positions
    }

    func movePlayer(toDirection direction: Direction) -> (player: Player, exploredMaze: [[MazeCellExplorationState]], completed: Bool) {
        guard !maze.isEmpty, !completed else {
            return (player, exploredMaze, completed)
        }
        player.move(toDirection: direction)
        if maze[player.position.y][player.position.x] == .goal {
            completed = true
        }
        exploreVisibleArea()
        return (player, exploredMaze, completed)
    }

    func changePlayerDirection(to direction: Direction) -> (player: Player, exploredMaze: [[MazeCellExplorationState]]) {
        guard !maze.isEmpty, !completed else {
            return (player, exploredMaze)
        }
        player.changeDirection(to: direction)
        exploreVisibleArea()
        return (player, exploredMaze)
    }
}
