//
//  ContentView.swift
//  MazeVisualizer
//
//  Created by yotahara on 2024/07/06.
//

import SwiftUI

struct MazeGameView: View {
    @StateObject private var viewModel: MazeGameViewModel
    
    init(mazeData: MazeData) {
        self._viewModel = StateObject(wrappedValue: .init(mazeData: mazeData))
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
            
            HStack(spacing: 10) {
                Button {
                    viewModel.movePlayer(toDirection: .left)
                } label: {
                    Image(systemName: "chevron.left")
                        .frame(width: 60, height: 90)
                        .background(
                            Rectangle()
                                .fill(Color.yellow)
                        )
                }
                
                VStack(spacing: 10) {
                    Button {
                        viewModel.movePlayer(toDirection: .up)
                    } label: {
                        Image(systemName: "chevron.up")
                            .frame(width: 140, height: 40)
                            .background(
                                Rectangle()
                                    .fill(Color.yellow)
                            )
                    }
                    
                    Button {
                        viewModel.movePlayer(toDirection: .down)
                    } label: {
                        Image(systemName: "chevron.down")
                            .frame(width: 140, height: 40)
                            .background(
                                Rectangle()
                                    .fill(Color.yellow)
                            )
                    }
                }
                
                Button {
                    viewModel.movePlayer(toDirection: .right)
                } label: {
                    Image(systemName: "chevron.right")
                        .frame(width: 60, height: 90)
                        .background(
                            Rectangle()
                                .fill(Color.yellow)
                        )
                }
            }
            .frame(maxHeight: .infinity, alignment: .center)
            
            Button("Reset Game") {
                viewModel.resetGame()
            }
            .padding()
            Spacer()
        }
        .navigationTitle(viewModel.mazeData.name)
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
    
    private func colorForState(_ state: ExplorationState) -> Color {
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
        case .shortestPath:
            return .blue
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
        MazeGameView(mazeData: MazeData.default)
    }
}
