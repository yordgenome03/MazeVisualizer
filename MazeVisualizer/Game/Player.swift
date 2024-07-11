//
//  UserDefaultsService.swift
//  MazeVisualizer
//
//  Created by yotahara on 2024/07/06.
//

import Foundation

enum Direction: CaseIterable {
    case up, down, left, right
}

struct Player {
    var position: (x: Int, y: Int)
    var direction: Direction
    let maze: [[MazeCellState]]
    
    mutating func move(toDirection newDirection: Direction) {
        direction = newDirection
        var newPosition = position
        
        switch newDirection {
        case .up:
            newPosition.y -= 1
        case .down:
            newPosition.y += 1
        case .left:
            newPosition.x -= 1
        case .right:
            newPosition.x += 1
        }
        
        guard newPosition.y >= 0
                && newPosition.y < maze.count
                && newPosition.x >= 0
                && newPosition.x < maze[0].count
                && maze[newPosition.y][newPosition.x] != .wall  else {
            return
        }
        position = newPosition
    }
    
    mutating func changeDirection(to newDirection: Direction) {
        direction = newDirection
    }
    
    var relativeSightCoordinates: [(x: Int, y: Int)] {        
        switch self.direction {
        case .up:
            return [
                (-1, -4), (1, -4), (0, -4),
                (-1, -3), (1, -3), (0, -3),
                (-1, -2), (1, -2), (0, -2),
                (-1, -1), (1, -1), (0, -1),      
                (-1, 0), (1, 0), (0, 0),            
            ]
        case .down:
            return [
                (1, 4), (-1, 4), (0, 4),
                (1, 3), (-1, 3), (0, 3),
                (1, 2), (-1, 2), (0, 2),
                (1, 1), (-1, 1), (0, 1),      
                (1, 0), (-1, 0), (0, 0),
            ]
        case .left:
            return [
                (-4, 1), (-4, -1), (-4, 0),
                (-3, 1), (-3, -1), (-3, 0),
                (-2, 1), (-2, -1), (-2, 0),
                (-1, 1), (-1, -1), (-1, 0),
                (0, 1), (0, -1), (0, 0),
            ]
        case .right:
            return [
                (4, -1), (4, 1), (4, 0),
                (3, -1), (3, 1), (3, 0),
                (2, -1), (2, 1), (2, 0),
                (1, -1), (1, 1), (1, 0),
                (0, -1), (0, 1), (0, 0),
            ]
        }
    }
}
