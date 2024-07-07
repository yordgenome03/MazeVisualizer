//
//  MazeVisualizationView.swift
//  MazeVisualizer
//
//  Created by yotahara on 2024/07/06.
//

import SwiftUI

struct MazeVisualizationView: View {
    let maze: [[MazeCellState]]

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

    private func color(for cell: MazeCellState) -> Color {
        switch cell {
        case .wall:
            return .black
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
    MazeVisualizationView(maze: MazeData.default.maze)
}
