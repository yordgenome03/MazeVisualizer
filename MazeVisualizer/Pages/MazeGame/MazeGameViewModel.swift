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

    private var gameService: MazeGameService

    init(mazeData: MazeData) {
        self.mazeData = mazeData
        self.gameService = MazeGameService(mazeData: mazeData)
        self.exploredMaze = gameService.exploredMaze
        self.player = gameService.player
    }
    
    func movePlayer(toDirection direction: Direction) {
        let (player, exploredMaze) = gameService.movePlayer(toDirection: direction)
        withAnimation {
            self.player = player
            self.exploredMaze = exploredMaze
        }
    }
}
