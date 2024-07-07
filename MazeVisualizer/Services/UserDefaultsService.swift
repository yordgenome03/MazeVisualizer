//
//  UserDefaultsService.swift
//  MazeVisualizer
//
//  Created by yotahara on 2024/07/06.
//

import Foundation

class UserDefaultsService {
    private static let mazeListKey = "mazeList"

    static func saveMaze(_ mazeData: MazeData) {
        var mazeList = getMazeList()
        if !mazeList.contains(mazeData.name) {
            mazeList.append(mazeData.name)
            saveMazeList(mazeList)
        }

        do {
            let data = try JSONEncoder().encode(mazeData)
            UserDefaults.standard.set(data, forKey: mazeData.name)
            print("Maze saved successfully")
        } catch {
            print("Failed to save maze: \(error)")
        }
    }

    static func loadMaze(named name: String) -> MazeData? {
        guard let data = UserDefaults.standard.data(forKey: name) else { return nil }
        do {
            let mazeData = try JSONDecoder().decode(MazeData.self, from: data)
            print("Maze loaded successfully")
            return mazeData
        } catch {
            print("Failed to load maze: \(error)")
            return nil
        }
    }
    
    static func getAllMazes() -> [MazeData] {
        let mazeNames = getMazeList()
        return mazeNames.compactMap { loadMaze(named: $0) }
    }
    
    static func deleteMaze(_ mazeData: MazeData) {
        UserDefaults.standard.removeObject(forKey: mazeData.name)
        var mazeList = getMazeList()
        mazeList.removeAll { $0 == mazeData.name }
        saveMazeList(mazeList)
        print("Maze deleted successfully")
    }

    static func deleteMazes(_ mazeDataList: [MazeData]) {
        var mazeList = getMazeList()
        for mazeData in mazeDataList {
            UserDefaults.standard.removeObject(forKey: mazeData.name)
            mazeList.removeAll { $0 == mazeData.name }
        }
        saveMazeList(mazeList)
        print("Mazes deleted successfully")
    }

    private static func getMazeList() -> [String] {
        return UserDefaults.standard.stringArray(forKey: mazeListKey) ?? []
    }

    private static func saveMazeList(_ mazeList: [String]) {
        UserDefaults.standard.set(mazeList, forKey: mazeListKey)
    }
}

