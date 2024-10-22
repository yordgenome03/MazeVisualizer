//
//  MazeDataListView.swift
//  MazeVisualizer
//
//  Created by yotahara on 2024/07/06.
//

import SwiftUI

struct MazeDataListView: View {
    @StateObject var viewModel: MazeDataListViewModel = .init()
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.mazeDataList, id: \.id) { mazeData in
                    NavigationLink {
                        MazeDataDetailView(mazeData: mazeData)
                    } label: {
                        MazeDataListRow(mazeData)
                    }
                }
            }
            .navigationTitle("Saved Maze List")
        }
    }
    
    private func MazeDataListRow(_ mazeData: MazeData) -> some View {
        VStack {
            HStack {
                Text(mazeData.name)
                    .font(.headline)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            HStack {
                Text("Generated by: ")
                    .font(.footnote)
                Text(mazeData.algorithm)
                    .font(.subheadline)
                    .lineLimit(1)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack {
                Text("Shortest distance: ")
                    .font(.footnote)
                Text("\(mazeData.shortestDistance)")
                    .font(.subheadline)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack {
                Text("Size: ")
                    .font(.footnote)
                Text("W:\(mazeData.maze[0].count) ✕ H: \(mazeData.maze.count)")
                    .font(.subheadline)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

#Preview {
    MazeDataListView()
}
