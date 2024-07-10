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
    var maze: [[MazeCellState]]
    
    func move(toDirection newDirection: Direction) -> Player {
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
        
        if newPosition.y >= 0
            && newPosition.y < maze.count
            && newPosition.x >= 0
            && newPosition.x < maze[0].count
            && maze[newPosition.y][newPosition.x] != .wall {
            return Player(position: newPosition, direction: newDirection, maze: maze)
        }
        return Player(position: position, direction: newDirection, maze: maze)
    }
    
    func changeDirection(to newDirection: Direction) -> Player {
        Player(position: position, direction: newDirection, maze: maze)
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
    
    func cellWallConfiguration(at x: Int, y: Int) -> CellWallConfiguration {
        let newX = position.x + x
        let newY = position.y + y
        let top: WallState = {
            if newY > 0 && newY <= maze.count - 1{
                switch maze[newY - 1][newX] {
                case .wall:  return .wall
                case .goal, .start: return .door
                case .path: return .open
                }
            } else {
                return .wall
            }
        }()
        
        let bottom: WallState = {
            if newY >= 0 && newY < maze.count - 1 {
                switch maze[newY + 1][newX] {
                case .wall: return .wall
                case .goal, .start: return .door
                case .path: return .open
                }
            } else {
                return .wall
            }
        }()
        
        let left: WallState = {
            if newX > 0 && newX <= maze[newY].count - 1 {
                switch maze[newY][newX - 1] {
                case .wall: return .wall
                case .goal, .start: return .door
                case .path: return .open
                }
            } else {
                return .wall
            }
        }()
        
        let right: WallState = {
            if newX >= 0 && newX < maze[newY].count - 1 {
                switch maze[newY][newX + 1] {
                case .wall: return .wall
                case .goal, .start: return .door
                case .path: return .open
                }
            } else {
                return .wall
            }
        }()        
        
        return CellWallConfiguration(top: top,
                                     left: left,
                                     bottom: bottom,
                                     right: right)
    }
    
    var sightWallConfigurations: [CellWallConfiguration] {
        return relativeSightCoordinates.compactMap { x, y in
            let newX = position.x + x
            let newY = position.y + y
            if newY >= 0, newY < maze.count, newX >= 0, newX < maze[newY].count {
                return rotateCellWallConfiguration(cellWallConfiguration(at: x, y: y), to: direction)
            } else {
                return CellWallConfiguration(top: .wall, left: .wall, bottom: .wall, right: .wall)
            }
        }
    }
    
    func rotateCellWallConfiguration(_ config: CellWallConfiguration, to direction: Direction) -> CellWallConfiguration {
        switch direction {
        case .up:
            return config
        case .left:
            return CellWallConfiguration(top: config.left, left: config.bottom, bottom: config.right, right: config.top)
        case .down:
            return CellWallConfiguration(top: config.bottom, left: config.right, bottom: config.top, right: config.left)
        case .right:
            return CellWallConfiguration(top: config.right, left: config.top, bottom: config.left, right: config.bottom)
        }
    }
}
