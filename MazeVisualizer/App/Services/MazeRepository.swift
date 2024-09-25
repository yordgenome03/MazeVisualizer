//
//  MazeRepository.swift
//  MazeVisualizer
//
//  Created by yotahara on 2024/07/06.
//

import Combine

protocol MazeRepositoryProtocol {
    var mazeDataListPublisher: Published<[MazeData]>.Publisher { get }

    func saveMaze(_ mazeData: MazeData)
    func getAllMazes() -> [MazeData]
    func deleteMaze(_ mazeData: MazeData)
}

class MazeRepository: MazeRepositoryProtocol, ObservableObject {
    static let shared = MazeRepository()

    @Published var mazeDataList: [MazeData] = []

    var mazeDataListPublisher: Published<[MazeData]>.Publisher {
        $mazeDataList
    }

    private init() {
        mazeDataList = getAllMazes()
    }

    func saveMaze(_ mazeData: MazeData) {
        UserDefaultsService.saveMaze(mazeData)
        mazeDataList = getAllMazes()
    }

    func getAllMazes() -> [MazeData] {
        var mazeDatas = [MazeData.default]
        mazeDatas.append(contentsOf: UserDefaultsService.getAllMazes())
        return mazeDatas
    }

    func deleteMaze(_ mazeData: MazeData) {
        UserDefaultsService.deleteMaze(mazeData)
        mazeDataList = getAllMazes()
    }

    func deleteMazes(_ mazeDataList: [MazeData]) {
        UserDefaultsService.deleteMazes(mazeDataList)
        self.mazeDataList = getAllMazes()
    }
}
