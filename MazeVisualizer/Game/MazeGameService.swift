//
//  UserDefaultsService.swift
//  MazeVisualizer
//
//  Created by yotahara on 2024/07/06.
//

import Foundation

class MazeGameService {
    private let mazeData: MazeData
    private(set) var exploredMaze: [[ExplorationState]]
    private(set) var player: Player
    private var completed = false
    
    init(mazeData: MazeData,
         playerStartPosition: (x: Int, y: Int) = (1, 0),
         playerDirection: Direction = .down) {
        self.mazeData = mazeData
        self.exploredMaze = Array(repeating: Array(repeating: .notExplored, count: mazeData.maze[0].count), count: mazeData.maze.count)
        self.exploredMaze[playerStartPosition.y][playerStartPosition.x] = .start
        self.player = Player(position: playerStartPosition, direction: playerDirection, maze: mazeData.maze)
        exploreVisibleArea()
    }
    
    private func exploreVisibleArea() {                
        let frontPositions = getFrontPositions()
        
        for (index, pos) in frontPositions.enumerated() {
            let (fx, fy) = pos
            if fx >= 0 && fx < mazeData.maze[0].count && fy >= 0 && fy < mazeData.maze.count {
                if index == 1 { // 進行方向2マス目
                    let (fx1, fy1) = frontPositions[0]
                    if mazeData.maze[fy1][fx1] == .wall {
                        continue // 進行方向1マス目が壁なら進行方向2マス目は更新しない
                    }
                }
                switch mazeData.maze[fy][fx] {
                case .path:
                    exploredMaze[fy][fx] = .path(0)
                case .wall:
                    exploredMaze[fy][fx] = .wall
                case .start:
                    exploredMaze[fy][fx] = .start
                case .goal:
                    exploredMaze[fy][fx] = .goal
                }
            }
        }
    }
    
    func getFrontPositions() -> [(x: Int, y: Int)] {
        var positions: [(x: Int, y: Int)] = []
        let (x, y) = player.position
        
        switch player.direction {
        case .up:
            positions.append((x, y-1))
            positions.append((x, y-2))
            positions.append((x-1, y-1))
            positions.append((x+1, y-1))
            positions.append((x-1, y))
            positions.append((x+1, y))
        case .down:
            positions.append((x, y+1))
            positions.append((x, y+2))
            positions.append((x-1, y+1))
            positions.append((x+1, y+1))
            positions.append((x-1, y))
            positions.append((x+1, y))
        case .left:
            positions.append((x-1, y))
            positions.append((x-2, y))
            positions.append((x-1, y-1))
            positions.append((x-1, y+1))
            positions.append((x, y-1))
            positions.append((x, y+1))
        case .right:
            positions.append((x+1, y))
            positions.append((x+2, y))
            positions.append((x+1, y-1))
            positions.append((x+1, y+1))
            positions.append((x, y-1))
            positions.append((x, y+1))
        }
        
        return positions
    }
    
    func movePlayer(toDirection direction: Direction) -> (player: Player, exploredMaze: [[ExplorationState]]) {
        guard !completed else { 
            return (player, exploredMaze)
        }
        player.move(toDirection: direction)
        if mazeData.maze[player.position.y][player.position.x] == .goal {
            completed = true
        }
        exploreVisibleArea()
        return (player, exploredMaze)
    }
    
    func changePlayerDirection(to direction: Direction) -> (player: Player, exploredMaze: [[ExplorationState]]) {
        guard !completed else { 
            return (player, exploredMaze)
        }
        player.changeDirection(to: direction)
        exploreVisibleArea()
        return (player, exploredMaze)
    }
}
