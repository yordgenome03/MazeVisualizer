//
//  MazeListViewModel.swift
//  MazeVisualizer
//
//  Created by yotahara on 2024/07/06.
//

import SwiftUI
import Combine

class MazeDataListViewModel: ObservableObject {
    @Published var mazeDataList: [MazeData] = []
    let repository: MazeRepositoryProtocol = MazeRepository.shared
    private var cancellables: Set<AnyCancellable> = []

    init() {
        repository.mazeDataListPublisher
            .sink { [weak self] mazeDataList in
                self?.mazeDataList = mazeDataList
            }
            .store(in: &cancellables)
    }
}
