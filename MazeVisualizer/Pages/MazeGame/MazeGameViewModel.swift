//
//  ContentView.swift
//  MazeVisualizer
//
//  Created by yotahara on 2024/07/06.
//

import SwiftUI

class MazeGameViewModel: ObservableObject {
    let mazeData: MazeData
    @Published var exploredMaze: [[ExplorationState]] = []
    @Published var player: Player
    @Published var aaImage: String = AsciiArts.emptyArt.joined(separator: "\n")
    
    private var gameService: MazeGameService
    let aaManager = AsciiArtBuilder()
    
    init(mazeData: MazeData) {
        self.mazeData = mazeData
        self.gameService = MazeGameService(mazeData: mazeData)
        self.exploredMaze = gameService.exploredMaze
        self.player = gameService.player
        self.aaImage = aaManager.generateAAImage(player: player)
    }
    
    func resetGame() {
        self.gameService = MazeGameService(mazeData: mazeData)
        self.exploredMaze = gameService.exploredMaze
        self.player = gameService.player
        self.aaImage = aaManager.generateAAImage(player: player)
    }
    
    func movePlayer(toDirection direction: Direction) {
        let currentDirection = self.player.direction
        var modifiedDirection: Direction

        switch currentDirection {
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
        case.right:
            switch direction {
            case .up: modifiedDirection = .right
            case .down: modifiedDirection = .left
            case .left: modifiedDirection = .up
            case .right: modifiedDirection = .down
            }
        }
        
        let (player, exploredMaze) = gameService.movePlayer(toDirection: modifiedDirection)
        withAnimation {
            self.player = player
            self.exploredMaze = exploredMaze
        }
        self.aaImage = aaManager.generateAAImage(player: player)
    }
}
