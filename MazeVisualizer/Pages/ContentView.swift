//
//  ContentView.swift
//  MazeVisualizer
//
//  Created by yotahara on 2024/07/06.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        TabView {
            NavigationListView()
                .tabItem {
                    Image(systemName: "house")
                }
            
            
            MazeDataListView()
                .tabItem {
                    Image(systemName: "list.star")
                }
        }
    }
}

#Preview {
    ContentView()
}
