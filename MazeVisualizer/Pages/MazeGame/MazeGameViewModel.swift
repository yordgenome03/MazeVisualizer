//
//  MazeGameViewModel.swift
//  MazeVisualizer
//
//  Created by yotahara on 2024/07/06.
//

import SwiftUI

class MazeGameViewModel: ObservableObject {
    let maze: [[MazeCellState]]
    @Published var exploredMaze: [[MazeCellExplorationState]] = []
    @Published var player: Player = .init(position: (1, 0), direction: .down, maze: [])
    @Published var aaImage: String = AsciiArt.empty.joined(separator: "\n")
    @Published var completed = false
    private let gameManager: MazeGameManager

    init(maze: [[MazeCellState]]) {
        self.maze = maze
        gameManager = MazeGameManager(maze: nil)
        initializeGameState()
    }

    func resetGame() {
        initializeGameState()
    }

    func handlePlayerMovement(fromDirection direction: Direction) {
        var modifiedDirection: Direction

        if case .up = direction {
            let (player, exploredMaze, completed) = gameManager.movePlayer(toDirection: player.direction)
            withAnimation {
                self.player = player
                self.exploredMaze = exploredMaze
                self.completed = completed
            }
            aaImage = gameManager.aaImage
        } else {
            switch player.direction {
            case .up:
                modifiedDirection = direction
            case .down:
                switch direction {
                case .up: modifiedDirection = .down
                case .down: modifiedDirection = .up
                case .left: modifiedDirection = .right
                case .right: modifiedDirection = .left
                }
            case .left:
                switch direction {
                case .up: modifiedDirection = .left
                case .down: modifiedDirection = .right
                case .left: modifiedDirection = .down
                case .right: modifiedDirection = .up
                }
            case .right:
                switch direction {
                case .up: modifiedDirection = .right
                case .down: modifiedDirection = .left
                case .left: modifiedDirection = .up
                case .right: modifiedDirection = .down
                }
            }
            let (player, exploredMaze) = gameManager.changePlayerDirection(to: modifiedDirection)
            withAnimation {
                self.player = player
                self.exploredMaze = exploredMaze
            }
            aaImage = gameManager.aaImage
        }
    }

    private func initializeGameState() {
        completed = false
        gameManager.applyMaze(maze)
        exploredMaze = gameManager.exploredMaze
        player = gameManager.player
        aaImage = gameManager.aaImage
    }
}
