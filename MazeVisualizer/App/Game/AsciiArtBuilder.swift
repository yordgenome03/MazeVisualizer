//
//  AsciiArtBuilder.swift
//  MazeVisualizer
//
//  Created by yotahara on 2024/07/06.
//

import SwiftUI

enum WallState: Int, Codable {
    case open = 0
    case wall = 1
    case door = 2
}

struct CellWallConfiguration: Equatable {
    var top: WallState
    var left: WallState
    var bottom: WallState
    var right: WallState

    mutating func rotate(to direction: Direction) {
        let defaultTop = top
        let defaultLeft = left
        let defaultBottom = bottom
        let defaultRight = right

        switch direction {
        case .up:
            break
        case .left:
            top = defaultLeft
            left = defaultBottom
            bottom = defaultRight
            right = defaultTop
        case .down:
            top = defaultBottom
            left = defaultRight
            bottom = defaultTop
            right = defaultLeft
        case .right:
            top = defaultRight
            left = defaultTop
            bottom = defaultLeft
            right = defaultBottom
        }
    }
}

extension [[MazeCellState]] {
    func cellWallConfiguration(at x: Int, y: Int) -> CellWallConfiguration {
        let top: WallState = {
            if y > 0 && y <= self.count - 1 {
                switch self[y - 1][x] {
                case .wall: return .wall
                case .goal, .start: return .door
                case .path: return .open
                }
            } else {
                return .wall
            }
        }()

        let bottom: WallState = {
            if y >= 0 && y < self.count - 1 {
                switch self[y + 1][x] {
                case .wall: return .wall
                case .goal, .start: return .door
                case .path: return .open
                }
            } else {
                return .wall
            }
        }()

        let left: WallState = {
            if x > 0 && x <= self[y].count - 1 {
                switch self[y][x - 1] {
                case .wall: return .wall
                case .goal, .start: return .door
                case .path: return .open
                }
            } else {
                return .wall
            }
        }()

        let right: WallState = {
            if x >= 0 && x < self[y].count - 1 {
                switch self[y][x + 1] {
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
}

extension Player {
    var sightWallConfigurations: [CellWallConfiguration] {
        return relativeSightCoordinates.compactMap { x, y in
            let newX = position.x + x
            let newY = position.y + y
            if newY >= 0, newY < maze.count, newX >= 0, newX < maze[newY].count {
                var config = maze.cellWallConfiguration(at: newX, y: newY)
                config.rotate(to: direction)
                return config
            } else {
                return CellWallConfiguration(top: .wall, left: .wall, bottom: .wall, right: .wall)
            }
        }
    }
}

struct AsciiArtBuilder {
    let aaWallTable: [([String]?, [String]?, [String]?, [String]?)] = [
        (nil, nil, AsciiArt.Zero.two, nil), (nil, nil, AsciiArt.One.two, nil), (nil, nil, AsciiArt.Two.two, nil),
        (AsciiArt.Three.zero, nil, AsciiArt.Three.two, AsciiArt.Three.three), (AsciiArt.Four.zero, AsciiArt.Four.one, AsciiArt.Four.two, nil), (AsciiArt.Five.zero, AsciiArt.Five.one, AsciiArt.Five.two, AsciiArt.Five.three),
        (AsciiArt.Six.zero, nil, AsciiArt.Six.two, AsciiArt.Six.three), (AsciiArt.Seven.zero, AsciiArt.Seven.one, AsciiArt.Seven.two, nil), (AsciiArt.Eight.zero, AsciiArt.Eight.one, AsciiArt.Eight.two, AsciiArt.Eight.three),
        (AsciiArt.Nine.zero, nil, AsciiArt.Nine.two, AsciiArt.Nine.three), (AsciiArt.Ten.zero, AsciiArt.Ten.one, AsciiArt.Ten.two, nil), (AsciiArt.Eleven.zero, AsciiArt.Eleven.one, AsciiArt.Eleven.two, AsciiArt.Eleven.three),
        (AsciiArt.Twelve.zero, nil, nil, AsciiArt.Twelve.three), (AsciiArt.Thirteen.zero, AsciiArt.Thirteen.one, nil, nil), (AsciiArt.Fourteen.zero, AsciiArt.Fourteen.one, nil, AsciiArt.Fourteen.three),
    ]

    let aaDoorTable: [([String]?, [String]?, [String]?, [String]?)] = [
        (nil, nil, AsciiArt.Zero.twoD, nil), (nil, nil, AsciiArt.One.twoD, nil), (nil, nil, AsciiArt.Two.twoD, nil),
        (AsciiArt.Three.zeroD, nil, AsciiArt.Three.twoD, AsciiArt.Three.threeD), (AsciiArt.Four.zeroD, AsciiArt.Four.oneD, AsciiArt.Four.twoD, nil), (AsciiArt.Five.zeroD, AsciiArt.Five.oneD, AsciiArt.Five.twoD, AsciiArt.Five.threeD),
        (AsciiArt.Six.zeroD, nil, AsciiArt.Six.twoD, AsciiArt.Six.threeD), (AsciiArt.Seven.zeroD, AsciiArt.Seven.oneD, AsciiArt.Seven.twoD, nil), (AsciiArt.Eight.zeroD, AsciiArt.Eight.oneD, AsciiArt.Eight.twoD, AsciiArt.Eight.threeD),
        (AsciiArt.Nine.zeroD, nil, AsciiArt.Nine.twoD, AsciiArt.Nine.threeD), (AsciiArt.Ten.zeroD, AsciiArt.Ten.oneD, AsciiArt.Ten.twoD, nil), (AsciiArt.Eleven.zeroD, AsciiArt.Eleven.oneD, AsciiArt.Eleven.twoD, AsciiArt.Eleven.threeD),
        (AsciiArt.Twelve.zeroD, nil, nil, AsciiArt.Twelve.threeD), (AsciiArt.Thirteen.zeroD, AsciiArt.Thirteen.oneD, nil, nil), (AsciiArt.Fourteen.zeroD, AsciiArt.Fourteen.oneD, nil, AsciiArt.Fourteen.threeD),
    ]

    func buildAAImage(forConfiguration configuration: [CellWallConfiguration]) -> String {
        var resultAA = AsciiArt.empty

        for (index, cellWallConfig) in configuration.enumerated() {
            let aaConfig = aaWallTable[index]
            let aaDoorConfig = aaDoorTable[index]

            if case .wall = cellWallConfig.top {
                if let top = aaConfig.0 {
                    resultAA = overlay(base: resultAA, overlay: top)
                }
            } else if case .door = cellWallConfig.top {
                if let top = aaDoorConfig.0 {
                    resultAA = overlay(base: resultAA, overlay: top)
                }
            }

            if case .wall = cellWallConfig.left {
                if let left = aaConfig.1 {
                    resultAA = overlay(base: resultAA, overlay: left)
                }
            } else if case .door = cellWallConfig.left {
                if let left = aaDoorConfig.1 {
                    resultAA = overlay(base: resultAA, overlay: left)
                }
            }

            if case .wall = cellWallConfig.right {
                if let right = aaConfig.3 {
                    resultAA = overlay(base: resultAA, overlay: right)
                }
            } else if case .door = cellWallConfig.right {
                if let right = aaDoorConfig.3 {
                    resultAA = overlay(base: resultAA, overlay: right)
                }
            }

            if case .wall = cellWallConfig.bottom {
                if let bottom = aaConfig.2 {
                    resultAA = overlay(base: resultAA, overlay: bottom)
                }
            } else if case .door = cellWallConfig.bottom {
                if let bottom = aaDoorConfig.2 {
                    resultAA = overlay(base: resultAA, overlay: bottom)
                }
            }
        }

        return resultAA.joined(separator: "\n")
    }

    func overlay(base: [String], overlay: [String]) -> [String] {
        var result = base

        for (lineIndex, overlayLine) in overlay.enumerated() {
            if lineIndex >= result.count { continue }
            var newLine = ""
            let baseLine = result[lineIndex]

            for (charIndex, overlayChar) in overlayLine.enumerated() {
                if charIndex >= baseLine.count {
                    newLine.append(" ")
                } else {
                    let baseChar = baseLine[baseLine.index(baseLine.startIndex, offsetBy: charIndex)]
                    newLine.append(overlayChar == "　" ? baseChar : overlayChar)
                }
            }

            result[lineIndex] = newLine
        }

        return result
    }
}
