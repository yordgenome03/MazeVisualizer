//
//  MazeExplorationView.swift
//  MazeVisualizer
//
//  Created by yotahara on 2024/07/06.
//

import SwiftUI

struct MazeExplorationView: View {
    let maze: [[ExplorationState]]
    let shortestDistance: Int?
    let showShortestDistance: Bool
    
    init(maze: [[ExplorationState]], shortestDistance: Int?, showShortestDistance: Bool = true) {
        self.maze = maze
        self.shortestDistance = shortestDistance
        self.showShortestDistance = showShortestDistance
    }
    
    var body: some View {
        VStack(spacing: 0) {
            if showShortestDistance {
                HStack {
                    Text("Shortest Distance:")
                    
                    Spacer()
                    
                    Text("\(shortestDistance != nil ? "\(String(describing: shortestDistance!))" : " ?")")
                }
                .padding(.bottom)
                .padding(.horizontal)
            }

            ForEach(maze.indices, id: \.self) { rowIndex in
                HStack(spacing: 0) {
                    ForEach(maze[rowIndex].indices, id: \.self) { columnIndex in
                        Rectangle()
                            .fill(color(for: maze[rowIndex][columnIndex]))
                            .frame(width: 10, height: 10)
                    }
                }
            }
        }
    }
    
    private func color(for cell: ExplorationState) -> Color {
        switch cell {
        case .notExplored:
            return .gray
        case .wall:
            return .black
        case .path:
            return .white
        case .start:
            return .green
        case .goal:
            return .red
        case .shortestPath:
            return .blue
        }
    }
}

#Preview {
    MazeExplorationView(maze: MazeData.default.maze.map {
        $0.map { maze in
            switch maze {
            case .path: return ExplorationState.path(0)
            case .wall: return ExplorationState.wall
            case .start: return ExplorationState.start
            case .goal: return ExplorationState.goal
            }
        }
    }, shortestDistance: nil)
}
