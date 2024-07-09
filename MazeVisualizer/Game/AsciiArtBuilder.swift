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
    
    func generateAAImage(player: Player) -> String {
        var resultAA = AsciiArts.emptyArt
        
        for (index, cellWallConfig) in player.sightWallConfigurations.enumerated() {
            let aaConfig = aaTable[index]

            if let top = aaConfig.0 {
                if case .wall = cellWallConfig.top {
                    resultAA = overlay(base: resultAA, overlay: top)
                }
            }
            if let left = aaConfig.1 {
                if case .wall = cellWallConfig.left {
                    resultAA = overlay(base: resultAA, overlay: left)
                }
            }
            if let right = aaConfig.3 {
                if case .wall = cellWallConfig.right {
                    resultAA = overlay(base: resultAA, overlay: right)
                }
            }
            if let bottom = aaConfig.2 {
                if case .wall = cellWallConfig.bottom {
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
    
//    func convertMazeTo3DRepresentation(maze: [[MazeCellState]]) -> [[CellWallConfiguration]] {
//        let height = maze.count
//        let width = maze[0].count
//        
//        var convertedMaze = [[CellWallConfiguration]](repeating: [CellWallConfiguration](repeating: CellWallConfiguration(top: .wall, left: .wall, bottom: .wall, right: .wall), count: width), count: height)
//        
//        for y in 0..<height {
//            for x in 0..<width {
//                if maze[y][x] == .wall {
//                    convertedMaze[y][x] = CellWallConfiguration(top: .wall, left: .wall, bottom: .wall, right: .wall)
//                } else {
//                    var top: WallState = .wall
//                    var left: WallState = .wall
//                    var bottom: WallState = .wall
//                    var right: WallState = .wall
//                    
//                    if y > 0 && maze[y - 1][x] != .wall {
//                        top = .open
//                    }
//                    if x > 0 && maze[y][x - 1] != .wall {
//                        left = .open
//                    }
//                    if y < height - 1 && maze[y + 1][x] != .wall {
//                        bottom = .open
//                    }
//                    if x < width - 1 && maze[y][x + 1] != .wall {
//                        right = .open
//                    }
//                    
//                    convertedMaze[y][x] = CellWallConfiguration(top: top, left: left, bottom: bottom, right: right)
//                }
//            }
//        }
//        
//        return convertedMaze
//    }
}


class Quasi3D: ObservableObject {
    let aaWidth: Int = 28
    let aaHeight: Int = 28
    
    
    @Published var aaImage: String = AsciiArts.completeImg.joined(separator: "\n")
    let aaa = AsciiArtBuilder()
    let maze = MazeData.default.maze
    
    init() {
        var aa = AsciiArts.emptyArt
        aa = overlay(base: aa, overlay: AsciiArts.Three.three)
        aa = overlay(base: aa, overlay: AsciiArts.Four.one)
        aa = overlay(base: aa, overlay: AsciiArts.Six.zero)
        aa = overlay(base: aa, overlay: AsciiArts.Seven.one)
        aa = overlay(base: aa, overlay: AsciiArts.Seven.two)
        aa = overlay(base: aa, overlay: AsciiArts.Ten.one)
        aa = overlay(base: aa, overlay: AsciiArts.Nine.three)
        aa = overlay(base: aa, overlay: AsciiArts.Twelve.three)
        aa = overlay(base: aa, overlay: AsciiArts.Thirteen.one)

        self.aaImage = aa.joined(separator: "\n")
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
    
    func asciiArtToString(_ art: [String]) -> String {
        return art.joined(separator: "\n")
    }
}


struct SampleView: View {
    @StateObject var viewModel = Quasi3D()


    var body: some View {
        Text(viewModel.aaImage)
            .font(.subheadline.bold())
            .lineLimit(28)
            .frame(maxWidth: .infinity, alignment: .center)
    }
    
}

#Preview {
    SampleView()
}

/*
 
(x: 1, y: 1)
down
[MazeVisualizer.CellWallConfiguration(top: MazeVisualizer.WallState.wall, left: MazeVisualizer.WallState.open, bottom: MazeVisualizer.WallState.wall, right: MazeVisualizer.WallState.open), MazeVisualizer.CellWallConfiguration(top: MazeVisualizer.WallState.wall, left: MazeVisualizer.WallState.open, bottom: MazeVisualizer.WallState.wall, right: MazeVisualizer.WallState.wall), MazeVisualizer.CellWallConfiguration(top: MazeVisualizer.WallState.open, left: MazeVisualizer.WallState.open, bottom: MazeVisualizer.WallState.wall, right: MazeVisualizer.WallState.wall), MazeVisualizer.CellWallConfiguration(top: MazeVisualizer.WallState.open, left: MazeVisualizer.WallState.open, bottom: MazeVisualizer.WallState.wall, right: MazeVisualizer.WallState.wall), MazeVisualizer.CellWallConfiguration(top: MazeVisualizer.WallState.wall, left: MazeVisualizer.WallState.wall, bottom: MazeVisualizer.WallState.wall, right: MazeVisualizer.WallState.wall), MazeVisualizer.CellWallConfiguration(top: MazeVisualizer.WallState.open, left: MazeVisualizer.WallState.wall, bottom: MazeVisualizer.WallState.open, right: MazeVisualizer.WallState.wall), MazeVisualizer.CellWallConfiguration(top: MazeVisualizer.WallState.wall, left: MazeVisualizer.WallState.open, bottom: MazeVisualizer.WallState.wall, right: MazeVisualizer.WallState.open), MazeVisualizer.CellWallConfiguration(top: MazeVisualizer.WallState.wall, left: MazeVisualizer.WallState.open, bottom: MazeVisualizer.WallState.wall, right: MazeVisualizer.WallState.wall), MazeVisualizer.CellWallConfiguration(top: MazeVisualizer.WallState.open, left: MazeVisualizer.WallState.open, bottom: MazeVisualizer.WallState.wall, right: MazeVisualizer.WallState.wall), MazeVisualizer.CellWallConfiguration(top: MazeVisualizer.WallState.wall, left: MazeVisualizer.WallState.open, bottom: MazeVisualizer.WallState.open, right: MazeVisualizer.WallState.open), MazeVisualizer.CellWallConfiguration(top: MazeVisualizer.WallState.wall, left: MazeVisualizer.WallState.open, bottom: MazeVisualizer.WallState.wall, right: MazeVisualizer.WallState.wall), MazeVisualizer.CellWallConfiguration(top: MazeVisualizer.WallState.open, left: MazeVisualizer.WallState.wall, bottom: MazeVisualizer.WallState.open, right: MazeVisualizer.WallState.wall), MazeVisualizer.CellWallConfiguration(top: MazeVisualizer.WallState.wall, left: MazeVisualizer.WallState.open, bottom: MazeVisualizer.WallState.wall, right: MazeVisualizer.WallState.open), MazeVisualizer.CellWallConfiguration(top: MazeVisualizer.WallState.wall, left: MazeVisualizer.WallState.open, bottom: MazeVisualizer.WallState.wall, right: MazeVisualizer.WallState.wall), MazeVisualizer.CellWallConfiguration(top: MazeVisualizer.WallState.open, left: MazeVisualizer.WallState.open, bottom: MazeVisualizer.WallState.open, right: MazeVisualizer.WallState.wall)]
(x: 2, y: 1)
right
[MazeVisualizer.CellWallConfiguration(top: MazeVisualizer.WallState.wall, left: MazeVisualizer.WallState.wall, bottom: MazeVisualizer.WallState.wall, right: MazeVisualizer.WallState.open), MazeVisualizer.CellWallConfiguration(top: MazeVisualizer.WallState.wall, left: MazeVisualizer.WallState.open, bottom: MazeVisualizer.WallState.wall, right: MazeVisualizer.WallState.open), MazeVisualizer.CellWallConfiguration(top: MazeVisualizer.WallState.open, left: MazeVisualizer.WallState.wall, bottom: MazeVisualizer.WallState.open, right: MazeVisualizer.WallState.wall), MazeVisualizer.CellWallConfiguration(top: MazeVisualizer.WallState.wall, left: MazeVisualizer.WallState.wall, bottom: MazeVisualizer.WallState.wall, right: MazeVisualizer.WallState.open), MazeVisualizer.CellWallConfiguration(top: MazeVisualizer.WallState.wall, left: MazeVisualizer.WallState.open, bottom: MazeVisualizer.WallState.wall, right: MazeVisualizer.WallState.open), MazeVisualizer.CellWallConfiguration(top: MazeVisualizer.WallState.open, left: MazeVisualizer.WallState.wall, bottom: MazeVisualizer.WallState.open, right: MazeVisualizer.WallState.wall), MazeVisualizer.CellWallConfiguration(top: MazeVisualizer.WallState.wall, left: MazeVisualizer.WallState.wall, bottom: MazeVisualizer.WallState.wall, right: MazeVisualizer.WallState.open), MazeVisualizer.CellWallConfiguration(top: MazeVisualizer.WallState.wall, left: MazeVisualizer.WallState.open, bottom: MazeVisualizer.WallState.open, right: MazeVisualizer.WallState.wall), MazeVisualizer.CellWallConfiguration(top: MazeVisualizer.WallState.open, left: MazeVisualizer.WallState.wall, bottom: MazeVisualizer.WallState.open, right: MazeVisualizer.WallState.wall), MazeVisualizer.CellWallConfiguration(top: MazeVisualizer.WallState.wall, left: MazeVisualizer.WallState.wall, bottom: MazeVisualizer.WallState.wall, right: MazeVisualizer.WallState.open), MazeVisualizer.CellWallConfiguration(top: MazeVisualizer.WallState.wall, left: MazeVisualizer.WallState.open, bottom: MazeVisualizer.WallState.wall, right: MazeVisualizer.WallState.open), MazeVisualizer.CellWallConfiguration(top: MazeVisualizer.WallState.open, left: MazeVisualizer.WallState.wall, bottom: MazeVisualizer.WallState.open, right: MazeVisualizer.WallState.open), MazeVisualizer.CellWallConfiguration(top: MazeVisualizer.WallState.wall, left: MazeVisualizer.WallState.wall, bottom: MazeVisualizer.WallState.open, right: MazeVisualizer.WallState.open), MazeVisualizer.CellWallConfiguration(top: MazeVisualizer.WallState.open, left: MazeVisualizer.WallState.open, bottom: MazeVisualizer.WallState.open, right: MazeVisualizer.WallState.wall), MazeVisualizer.CellWallConfiguration(top: MazeVisualizer.WallState.open, left: MazeVisualizer.WallState.wall, bottom: MazeVisualizer.WallState.open, right: MazeVisualizer.WallState.wall)]

 */
