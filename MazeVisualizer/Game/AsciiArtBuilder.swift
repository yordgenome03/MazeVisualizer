//
//  MazeVisualizerApp.swift
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
}

class AsciiArtBuilder {
    
    let aaTable: [([String]?, [String]?, [String]?, [String]?)] = [
        (nil, nil, AsciiArts.Zero.two, nil), (nil, nil, AsciiArts.One.two, nil), (nil, nil, AsciiArts.Two.two, nil),
        (AsciiArts.Three.zero, nil, AsciiArts.Three.two, AsciiArts.Three.three), (AsciiArts.Four.zero, AsciiArts.Four.one, AsciiArts.Four.two, nil), (AsciiArts.Five.zero, AsciiArts.Five.one, AsciiArts.Five.two, AsciiArts.Five.three),
        (AsciiArts.Six.zero, nil, AsciiArts.Six.two, AsciiArts.Six.three), (AsciiArts.Seven.zero, AsciiArts.Seven.one, AsciiArts.Seven.two, nil), (AsciiArts.Eight.zero, AsciiArts.Eight.one, AsciiArts.Eight.two, AsciiArts.Eight.three),
        (AsciiArts.Nine.zero, nil, AsciiArts.Nine.two, AsciiArts.Nine.three), (AsciiArts.Ten.zero, AsciiArts.Ten.one, AsciiArts.Ten.two, nil), (AsciiArts.Eleven.zero, AsciiArts.Eleven.one, AsciiArts.Eleven.two, AsciiArts.Eleven.three),
        (AsciiArts.Twelve.zero, nil, nil, AsciiArts.Twelve.three), (AsciiArts.Thirteen.zero, AsciiArts.Thirteen.one, nil, nil), (AsciiArts.Fourteen.zero, AsciiArts.Fourteen.one, nil, AsciiArts.Fourteen.three),
    ]
    
    let aaDoorTable: [([String]?, [String]?, [String]?, [String]?)] = [
        (nil, nil, AsciiArts.Zero.twoD, nil), (nil, nil, AsciiArts.One.twoD, nil), (nil, nil, AsciiArts.Two.twoD, nil),
        (AsciiArts.Three.zeroD, nil, AsciiArts.Three.twoD, AsciiArts.Three.threeD), (AsciiArts.Four.zeroD, AsciiArts.Four.oneD, AsciiArts.Four.twoD, nil), (AsciiArts.Five.zeroD, AsciiArts.Five.oneD, AsciiArts.Five.twoD, AsciiArts.Five.threeD),
        (AsciiArts.Six.zeroD, nil, AsciiArts.Six.twoD, AsciiArts.Six.threeD), (AsciiArts.Seven.zeroD, AsciiArts.Seven.oneD, AsciiArts.Seven.twoD, nil), (AsciiArts.Eight.zeroD, AsciiArts.Eight.oneD, AsciiArts.Eight.twoD, AsciiArts.Eight.threeD),
        (AsciiArts.Nine.zeroD, nil, AsciiArts.Nine.twoD, AsciiArts.Nine.threeD), (AsciiArts.Ten.zeroD, AsciiArts.Ten.oneD, AsciiArts.Ten.twoD, nil), (AsciiArts.Eleven.zeroD, AsciiArts.Eleven.oneD, AsciiArts.Eleven.twoD, AsciiArts.Eleven.threeD),
        (AsciiArts.Twelve.zeroD, nil, nil, AsciiArts.Twelve.threeD), (AsciiArts.Thirteen.zeroD, AsciiArts.Thirteen.oneD, nil, nil), (AsciiArts.Fourteen.zeroD, AsciiArts.Fourteen.oneD, nil, AsciiArts.Fourteen.threeD),
    ]
    
    func generateAAImage(player: Player) -> String {
        var resultAA = AsciiArts.emptyArt
        
        for (index, cellWallConfig) in player.sightWallConfigurations.enumerated() {
            let aaConfig = aaTable[index]
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
