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
            GameView
                .frame(maxWidth: .infinity, alignment: .center)
            
            ZStack {
                Button {
                    viewModel.movePlayer(toDirection: .up)
                } label: {
                    Image(systemName: "chevron.up")
                        .frame(width: 40, height: 40)
                        .background(
                            Circle()
                                .fill(Color.yellow)
                        )
                }
                .frame(maxWidth: .infinity,  alignment: .center)
                .frame(maxHeight: .infinity, alignment: .top)
                Button {
                    viewModel.movePlayer(toDirection: .down)
                } label: {
                    Image(systemName: "chevron.down")
                        .frame(width: 40, height: 40)
                        .background(
                            Circle()
                                .fill(Color.yellow)
                        )
                }
                .frame(maxWidth: .infinity,  alignment: .center)
                .frame(maxHeight: .infinity, alignment: .bottom)
                
                Button {
                    viewModel.movePlayer(toDirection: .left)
                } label: {
                    Image(systemName: "chevron.left")
                        .frame(width: 40, height: 40)
                        .background(
                            Circle()
                                .fill(Color.yellow)
                        )
                }
                .frame(maxWidth: .infinity,  alignment: .leading)
                .frame(maxHeight: .infinity, alignment: .center)
                
                Button {
                    viewModel.movePlayer(toDirection: .right)
                } label: {
                    Image(systemName: "chevron.right")
                        .frame(width: 40, height: 40)
                        .background(
                            Circle()
                                .fill(Color.yellow)
                                .frame(width: 40, height: 40)
                        )
                }
                .frame(maxWidth: .infinity,  alignment: .trailing)
                .frame(maxHeight: .infinity, alignment: .center)
            }
            .frame(width: 180, height: 100)
            
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
                                    .rotationEffect(angleForDirection(viewModel.player.direction))
                                    .foregroundColor(.black)
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
            return .gray
        case .path:
            return .white
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
