//
//  MazeExplorationView.swift
//  MazeVisualizer
//
//  Created by yotahara on 2024/07/06.
//

import SwiftUI

struct MazeExplorationView: View {
    let maze: [[ExplorationState]]

    var body: some View {
        VStack(spacing: 0) {
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
            return .black
        case .wall:
            return .gray
        case .path:
            return .white
        case .start:
            return .green
        case .goal:
            return .red
        }
    }
}

#Preview {
    MazeExplorationView(maze: MazeData.default.maze.map {
        $0.map { maze in
            switch maze {
            case .path: return ExplorationState.path
            case .wall: return ExplorationState.wall
            case .start: return ExplorationState.start
            case .goal: return ExplorationState.goal
            }
        }
    })
}
