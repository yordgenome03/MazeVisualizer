//
//  ContentView.swift
//  MazeVisualizer
//
//  Created by yotahara on 2024/07/06.
//

import SwiftUI

struct MazeGameView: View {
    @StateObject private var viewModel: MazeGameViewModel
    
    init(maze: [[MazeCellState]]) {
        self._viewModel = StateObject(wrappedValue: .init(maze: maze))
    }
    
    var body: some View {
        VStack {                
            Text(viewModel.aaImage)
                .font(.caption2.bold())
                .frame(maxWidth: .infinity, alignment: .center)
                .frame(maxHeight: .infinity, alignment: .top)
                .padding(.top, 80)
                .overlay { 
                    GameView
                        .scaleEffect(0.8)
                        .opacity(0.7)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .frame(maxHeight: .infinity, alignment: .top)
                        .offset(y: -20)
                }
                .fixedSize(horizontal: false, vertical: true)
                .overlay { 
                    if viewModel.completed {
                        Text("Game Clear")
                            .font(.title.bold())
                            .foregroundStyle(Color.white)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(Color.yellow)
                            )
                    }
                }
            
            HStack(spacing: 10) {
                Button {
                    viewModel.handlePlayerMovement(fromDirection: .left)
                } label: {
                    Image(systemName: "chevron.left")
                        .frame(width: 60, height: 90)
                        .background(
                            Rectangle()
                                .fill(Color.mint)
                        )
                }
                
                VStack(spacing: 10) {
                    Button {
                        viewModel.handlePlayerMovement(fromDirection: .up)
                    } label: {
                        VStack(spacing: 0) {
                            Image(systemName: "chevron.up")
                            Image(systemName: "chevron.up")
                        }
                        .frame(width: 140, height: 40)
                        
                        .background(
                            Rectangle()
                                .fill(Color.mint)
                        )
                    }
                    
                    Button {
                        viewModel.handlePlayerMovement(fromDirection: .down)
                    } label: {
                        Image(systemName: "chevron.down")
                            .frame(width: 140, height: 40)
                            .background(
                                Rectangle()
                                    .fill(Color.mint)
                            )
                    }
                }
                
                Button {
                    viewModel.handlePlayerMovement(fromDirection: .right)
                } label: {
                    Image(systemName: "chevron.right")
                        .frame(width: 60, height: 90)
                        .background(
                            Rectangle()
                                .fill(Color.mint)
                        )
                }
            }
            .frame(maxHeight: .infinity, alignment: .center)
            
            Button {
                viewModel.resetGame()
            } label: {
                Text("Reset")
                    .foregroundStyle(Color.red)
                    .padding(.horizontal)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color.red, lineWidth: 2)
                    )
            }
            .padding()            
        }
    }
    
    private var GameView: some View {
        VStack(spacing: 0) {
            ForEach(0..<viewModel.exploredMaze.count, id: \.self) { y in
                HStack(spacing: 0) {
                    ForEach(0..<viewModel.exploredMaze[y].count, id: \.self) { x in
                        ZStack {
                            Rectangle()
                                .foregroundColor(colorForState(viewModel.exploredMaze[y][x]))
                                .frame(width: 10, height: 10)
                            if viewModel.player.position == (x, y) {
                                Image(systemName: "triangle.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 10, height: 10)
                                    .scaleEffect(x: 0.6)
                                    .rotationEffect(angleForDirection(viewModel.player.direction))
                                    .foregroundColor(.blue)
                            }
                        }
                    }
                }
            }
        }
        
    }
    
    private func colorForState(_ state: MazeCellExplorationState) -> Color {
        switch state {
        case .notExplored:
            return .clear
        case .path:
            return .gray.opacity(0.2)
        case .wall:
            return .black
        case .start:
            return .green
        case .goal:
            return .red
        }
    }
    
    private func angleForDirection(_ direction: Direction) -> Angle {
        switch direction {
        case .up:
            return .degrees(0)
        case .down:
            return .degrees(180)
        case .left:
            return .degrees(270)
        case .right:
            return .degrees(90)
        }
    }
}

#Preview {
    NavigationStack {
        MazeGameView(maze: MazeData.default.maze)
    }
}
