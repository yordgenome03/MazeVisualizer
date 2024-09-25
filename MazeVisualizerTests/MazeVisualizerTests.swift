//
//  MazeVisualizerTests.swift
//  MazeVisualizerTests
//
//  Created by yotahara on 2024/07/06.
//

@testable import MazeVisualizer
import XCTest

final class MazeVisualizerTests: XCTestCase {
//    let __maze = """
//                ■Ｓ■■■■■
//                ■□■□□□■
//                ■□□□■□■
//                ■□■□■□■
//                ■□■□■□■
//                ■■■■■Ｇ■
//    """

    let maze: [[MazeCellState]] = [
        [.wall, .start, .wall, .wall, .wall, .wall, .wall],
        [.wall, .path, .wall, .path, .path, .path, .wall],
        [.wall, .path, .path, .path, .wall, .path, .wall],
        [.wall, .path, .wall, .path, .wall, .path, .wall],
        [.wall, .path, .wall, .path, .wall, .path, .wall],
        [.wall, .wall, .wall, .wall, .wall, .goal, .wall],
    ]

    var player: Player!
    var aaBuilder: AsciiArtBuilder!

    override func setUpWithError() throws {
        player = Player(position: (x: 1, y: 0), direction: .down, maze: maze)
        aaBuilder = AsciiArtBuilder()
    }

    override func tearDownWithError() throws {}

    func testPlayerPositionAndDirection() throws {
        XCTAssertEqual(player.position.x, 1)
        XCTAssertEqual(player.position.y, 0)
        XCTAssertEqual(player.direction, .down)

        let config0__10 = player.cellWallConfiguration(at: -1, y: 0)
        let config0_00 = player.cellWallConfiguration(at: 0, y: 0)
        let config0_10 = player.cellWallConfiguration(at: 1, y: 0)
        XCTAssertEqual(config0__10, CellWallConfiguration(top: .wall, left: .wall, bottom: .wall, right: .open))
        XCTAssertEqual(config0_00, CellWallConfiguration(top: .wall, left: .wall, bottom: .open, right: .wall))
        XCTAssertEqual(config0_10, CellWallConfiguration(top: .wall, left: .open, bottom: .wall, right: .wall))
        let config0__11 = player.cellWallConfiguration(at: -1, y: 1)
        let config0_01 = player.cellWallConfiguration(at: 0, y: 1)
        let config0_11 = player.cellWallConfiguration(at: 1, y: 1)
        XCTAssertEqual(config0__11, CellWallConfiguration(top: .wall, left: .wall, bottom: .wall, right: .open))
        XCTAssertEqual(config0_01, CellWallConfiguration(top: .open, left: .wall, bottom: .open, right: .wall))
        XCTAssertEqual(config0_11, CellWallConfiguration(top: .wall, left: .open, bottom: .open, right: .open))
        let config0__12 = player.cellWallConfiguration(at: -1, y: 2)
        let config0_02 = player.cellWallConfiguration(at: 0, y: 2)
        let config0_12 = player.cellWallConfiguration(at: 1, y: 2)
        XCTAssertEqual(config0__12, CellWallConfiguration(top: .wall, left: .wall, bottom: .wall, right: .open))
        XCTAssertEqual(config0_02, CellWallConfiguration(top: .open, left: .wall, bottom: .open, right: .open))
        XCTAssertEqual(config0_12, CellWallConfiguration(top: .wall, left: .open, bottom: .wall, right: .open))
        let config0__13 = player.cellWallConfiguration(at: -1, y: 3)
        let config0_03 = player.cellWallConfiguration(at: 0, y: 3)
        let config0_13 = player.cellWallConfiguration(at: 1, y: 3)
        XCTAssertEqual(config0__13, CellWallConfiguration(top: .wall, left: .wall, bottom: .wall, right: .open))
        XCTAssertEqual(config0_03, CellWallConfiguration(top: .open, left: .wall, bottom: .open, right: .wall))
        XCTAssertEqual(config0_13, CellWallConfiguration(top: .open, left: .open, bottom: .wall, right: .open))
        let config0__14 = player.cellWallConfiguration(at: -1, y: 4)
        let config0_04 = player.cellWallConfiguration(at: 0, y: 4)
        let config0_14 = player.cellWallConfiguration(at: 1, y: 4)
        XCTAssertEqual(config0__14, CellWallConfiguration(top: .wall, left: .wall, bottom: .wall, right: .open))
        XCTAssertEqual(config0_04, CellWallConfiguration(top: .open, left: .wall, bottom: .wall, right: .wall))
        XCTAssertEqual(config0_14, CellWallConfiguration(top: .wall, left: .open, bottom: .wall, right: .open))

        let rotatedConfig0__10 = player.rotateCellWallConfiguration(config0__10, to: .down)
        let rotatedConfig0_00 = player.rotateCellWallConfiguration(config0_00, to: .down)
        let rotatedConfig0_10 = player.rotateCellWallConfiguration(config0_10, to: .down)
        XCTAssertEqual(rotatedConfig0__10, CellWallConfiguration(top: .wall, left: .open, bottom: .wall, right: .wall))
        XCTAssertEqual(rotatedConfig0_00, CellWallConfiguration(top: .open, left: .wall, bottom: .wall, right: .wall))
        XCTAssertEqual(rotatedConfig0_10, CellWallConfiguration(top: .wall, left: .wall, bottom: .wall, right: .open))
        let rotatedConfig0__11 = player.rotateCellWallConfiguration(config0__11, to: .down)
        let rotatedConfig0_01 = player.rotateCellWallConfiguration(config0_01, to: .down)
        let rotatedConfig0_11 = player.rotateCellWallConfiguration(config0_11, to: .down)
        XCTAssertEqual(rotatedConfig0__11, CellWallConfiguration(top: .wall, left: .open, bottom: .wall, right: .wall))
        XCTAssertEqual(rotatedConfig0_01, CellWallConfiguration(top: .open, left: .wall, bottom: .open, right: .wall))
        XCTAssertEqual(rotatedConfig0_11, CellWallConfiguration(top: .open, left: .open, bottom: .wall, right: .open))
        let rotatedConfig0__12 = player.rotateCellWallConfiguration(config0__12, to: .down)
        let rotatedConfig0_02 = player.rotateCellWallConfiguration(config0_02, to: .down)
        let rotatedConfig0_12 = player.rotateCellWallConfiguration(config0_12, to: .down)
        XCTAssertEqual(rotatedConfig0__12, CellWallConfiguration(top: .wall, left: .open, bottom: .wall, right: .wall))
        XCTAssertEqual(rotatedConfig0_02, CellWallConfiguration(top: .open, left: .open, bottom: .open, right: .wall))
        XCTAssertEqual(rotatedConfig0_12, CellWallConfiguration(top: .wall, left: .open, bottom: .wall, right: .open))
        let rotatedConfig0__13 = player.rotateCellWallConfiguration(config0__13, to: .down)
        let rotatedConfig0_03 = player.rotateCellWallConfiguration(config0_03, to: .down)
        let rotatedConfig0_13 = player.rotateCellWallConfiguration(config0_13, to: .down)
        XCTAssertEqual(rotatedConfig0__13, CellWallConfiguration(top: .wall, left: .open, bottom: .wall, right: .wall))
        XCTAssertEqual(rotatedConfig0_03, CellWallConfiguration(top: .open, left: .wall, bottom: .open, right: .wall))
        XCTAssertEqual(rotatedConfig0_13, CellWallConfiguration(top: .wall, left: .open, bottom: .open, right: .open))
        let rotatedConfig0__14 = player.rotateCellWallConfiguration(config0__14, to: .down)
        let rotatedConfig0_04 = player.rotateCellWallConfiguration(config0_04, to: .down)
        let rotatedConfig0_14 = player.rotateCellWallConfiguration(config0_14, to: .down)
        XCTAssertEqual(rotatedConfig0__14, CellWallConfiguration(top: .wall, left: .open, bottom: .wall, right: .wall))
        XCTAssertEqual(rotatedConfig0_04, CellWallConfiguration(top: .wall, left: .wall, bottom: .open, right: .wall))
        XCTAssertEqual(rotatedConfig0_14, CellWallConfiguration(top: .wall, left: .open, bottom: .wall, right: .open))

        let cellConfig0: [CellWallConfiguration] = [
            rotatedConfig0_14, rotatedConfig0__14, rotatedConfig0_04,
            rotatedConfig0_13, rotatedConfig0__13, rotatedConfig0_03,
            rotatedConfig0_12, rotatedConfig0__12, rotatedConfig0_02,
            rotatedConfig0_11, rotatedConfig0__11, rotatedConfig0_01,
            rotatedConfig0_10, rotatedConfig0__10, rotatedConfig0_00,
        ]

        XCTAssertEqual(player.sightWallConfigurations, cellConfig0)

        var aa = AsciiArt.empty
        aa = aaBuilder.overlay(base: aa, overlay: AsciiArt.Three.three)
        aa = aaBuilder.overlay(base: aa, overlay: AsciiArt.Four.one)
        aa = aaBuilder.overlay(base: aa, overlay: AsciiArt.Six.zero)
        aa = aaBuilder.overlay(base: aa, overlay: AsciiArt.Seven.one)
        aa = aaBuilder.overlay(base: aa, overlay: AsciiArt.Seven.two)
        aa = aaBuilder.overlay(base: aa, overlay: AsciiArt.Ten.one)
        aa = aaBuilder.overlay(base: aa, overlay: AsciiArt.Nine.three)
        aa = aaBuilder.overlay(base: aa, overlay: AsciiArt.Twelve.three)
        aa = aaBuilder.overlay(base: aa, overlay: AsciiArt.Thirteen.one)

        player.move(toDirection: .down)

        XCTAssertEqual(player.position.x, 1)
        XCTAssertEqual(player.position.y, 1)
        XCTAssertEqual(player.direction, .down)
        let config1_00 = player.cellWallConfiguration(at: 0, y: 0)
        let config1_01 = player.cellWallConfiguration(at: 0, y: 1)
        XCTAssertEqual(config1_00, CellWallConfiguration(top: .open, left: .wall, bottom: .open, right: .wall))
        XCTAssertEqual(config1_01, CellWallConfiguration(top: .open, left: .wall, bottom: .open, right: .open))

        player.move(toDirection: .left)

        XCTAssertEqual(player.position.x, 1)
        XCTAssertEqual(player.position.y, 1)
        XCTAssertEqual(player.direction, .left)
        let config2_00 = player.cellWallConfiguration(at: 0, y: 0)
        let config2_01 = player.cellWallConfiguration(at: 0, y: 1)
        XCTAssertEqual(config2_00, CellWallConfiguration(top: .open, left: .wall, bottom: .open, right: .wall))
        XCTAssertEqual(config2_01, CellWallConfiguration(top: .open, left: .wall, bottom: .open, right: .open))

        player.move(toDirection: .down)

        XCTAssertEqual(player.position.x, 1)
        XCTAssertEqual(player.position.y, 2)
        XCTAssertEqual(player.direction, .down)
        let config3_00 = player.cellWallConfiguration(at: 0, y: 0)
        let config3_01 = player.cellWallConfiguration(at: 0, y: 1)
        XCTAssertEqual(config3_00, CellWallConfiguration(top: .open, left: .wall, bottom: .open, right: .open))
        XCTAssertEqual(config3_01, CellWallConfiguration(top: .open, left: .wall, bottom: .open, right: .wall))

        player.move(toDirection: .right)

        XCTAssertEqual(player.position.x, 2)
        XCTAssertEqual(player.position.y, 2)
        XCTAssertEqual(player.direction, .right)

        let config4_0_1 = player.cellWallConfiguration(at: 0, y: -1)
        let config4_00 = player.cellWallConfiguration(at: 0, y: 0)
        let config4_01 = player.cellWallConfiguration(at: 0, y: 1)
        XCTAssertEqual(config4_0_1, CellWallConfiguration(top: .wall, left: .open, bottom: .open, right: .open))
        XCTAssertEqual(config4_00, CellWallConfiguration(top: .wall, left: .open, bottom: .wall, right: .open))
        XCTAssertEqual(config4_01, CellWallConfiguration(top: .open, left: .open, bottom: .wall, right: .open))
        let config4_1_1 = player.cellWallConfiguration(at: 1, y: -1)
        let config4_10 = player.cellWallConfiguration(at: 1, y: 0)
        let config4_11 = player.cellWallConfiguration(at: 1, y: 1)
        XCTAssertEqual(config4_1_1, CellWallConfiguration(top: .wall, left: .wall, bottom: .open, right: .open))
        XCTAssertEqual(config4_10, CellWallConfiguration(top: .open, left: .open, bottom: .open, right: .wall))
        XCTAssertEqual(config4_11, CellWallConfiguration(top: .open, left: .wall, bottom: .open, right: .wall))
        let config4_2_1 = player.cellWallConfiguration(at: 2, y: -1)
        let config4_20 = player.cellWallConfiguration(at: 2, y: 0)
        let config4_21 = player.cellWallConfiguration(at: 2, y: 1)
        XCTAssertEqual(config4_2_1, CellWallConfiguration(top: .wall, left: .open, bottom: .wall, right: .open))
        XCTAssertEqual(config4_20, CellWallConfiguration(top: .open, left: .open, bottom: .wall, right: .open))
        XCTAssertEqual(config4_21, CellWallConfiguration(top: .wall, left: .open, bottom: .wall, right: .open))
        let config4_3_1 = player.cellWallConfiguration(at: 3, y: -1)
        let config4_30 = player.cellWallConfiguration(at: 3, y: 0)
        let config4_31 = player.cellWallConfiguration(at: 3, y: 1)
        XCTAssertEqual(config4_3_1, CellWallConfiguration(top: .wall, left: .open, bottom: .open, right: .wall))
        XCTAssertEqual(config4_30, CellWallConfiguration(top: .open, left: .wall, bottom: .open, right: .wall))
        XCTAssertEqual(config4_31, CellWallConfiguration(top: .open, left: .wall, bottom: .open, right: .wall))
        let config4_4_1 = player.cellWallConfiguration(at: 4, y: -1)
        let config4_40 = player.cellWallConfiguration(at: 4, y: 0)
        let config4_41 = player.cellWallConfiguration(at: 4, y: 1)
        XCTAssertEqual(config4_4_1, CellWallConfiguration(top: .wall, left: .open, bottom: .wall, right: .wall))
        XCTAssertEqual(config4_40, CellWallConfiguration(top: .wall, left: .open, bottom: .wall, right: .wall))
        XCTAssertEqual(config4_41, CellWallConfiguration(top: .wall, left: .open, bottom: .wall, right: .wall))

        let rotatedConfig4_0_1 = player.rotateCellWallConfiguration(config4_0_1, to: .right)
        let rotatedConfig4_00 = player.rotateCellWallConfiguration(config4_00, to: .right)
        let rotatedConfig4_01 = player.rotateCellWallConfiguration(config4_01, to: .right)
        XCTAssertEqual(rotatedConfig4_0_1, CellWallConfiguration(top: .open, left: .wall, bottom: .open, right: .open))
        XCTAssertEqual(rotatedConfig4_00, CellWallConfiguration(top: .open, left: .wall, bottom: .open, right: .wall))
        XCTAssertEqual(rotatedConfig4_01, CellWallConfiguration(top: .open, left: .open, bottom: .open, right: .wall))
        let rotatedConfig4_1_1 = player.rotateCellWallConfiguration(config4_1_1, to: .right)
        let rotatedConfig4_10 = player.rotateCellWallConfiguration(config4_10, to: .right)
        let rotatedConfig4_11 = player.rotateCellWallConfiguration(config4_11, to: .right)
        XCTAssertEqual(rotatedConfig4_1_1, CellWallConfiguration(top: .open, left: .wall, bottom: .wall, right: .open))
        XCTAssertEqual(rotatedConfig4_10, CellWallConfiguration(top: .wall, left: .open, bottom: .open, right: .open))
        XCTAssertEqual(rotatedConfig4_11, CellWallConfiguration(top: .wall, left: .open, bottom: .wall, right: .open))
        let rotatedConfig4_2_1 = player.rotateCellWallConfiguration(config4_2_1, to: .right)
        let rotatedConfig4_20 = player.rotateCellWallConfiguration(config4_20, to: .right)
        let rotatedConfig4_21 = player.rotateCellWallConfiguration(config4_21, to: .right)
        XCTAssertEqual(rotatedConfig4_2_1, CellWallConfiguration(top: .open, left: .wall, bottom: .open, right: .wall))
        XCTAssertEqual(rotatedConfig4_20, CellWallConfiguration(top: .open, left: .open, bottom: .open, right: .wall))
        XCTAssertEqual(rotatedConfig4_21, CellWallConfiguration(top: .open, left: .wall, bottom: .open, right: .wall))
        let rotatedConfig4_3_1 = player.rotateCellWallConfiguration(config4_3_1, to: .right)
        let rotatedConfig4_30 = player.rotateCellWallConfiguration(config4_30, to: .right)
        let rotatedConfig4_31 = player.rotateCellWallConfiguration(config4_31, to: .right)
        XCTAssertEqual(rotatedConfig4_3_1, CellWallConfiguration(top: .wall, left: .wall, bottom: .open, right: .open))
        XCTAssertEqual(rotatedConfig4_30, CellWallConfiguration(top: .wall, left: .open, bottom: .wall, right: .open))
        XCTAssertEqual(rotatedConfig4_31, CellWallConfiguration(top: .wall, left: .open, bottom: .wall, right: .open))
        let rotatedConfig4_4_1 = player.rotateCellWallConfiguration(config4_4_1, to: .right)
        let rotatedConfig4_40 = player.rotateCellWallConfiguration(config4_40, to: .right)
        let rotatedConfig4_41 = player.rotateCellWallConfiguration(config4_41, to: .right)
        XCTAssertEqual(rotatedConfig4_4_1, CellWallConfiguration(top: .wall, left: .wall, bottom: .open, right: .wall))
        XCTAssertEqual(rotatedConfig4_40, CellWallConfiguration(top: .wall, left: .wall, bottom: .open, right: .wall))
        XCTAssertEqual(rotatedConfig4_41, CellWallConfiguration(top: .wall, left: .wall, bottom: .open, right: .wall))

        let cellConfig4: [CellWallConfiguration] = [
            rotatedConfig4_4_1, rotatedConfig4_41, rotatedConfig4_40,
            rotatedConfig4_3_1, rotatedConfig4_31, rotatedConfig4_30,
            rotatedConfig4_2_1, rotatedConfig4_21, rotatedConfig4_20,
            rotatedConfig4_1_1, rotatedConfig4_11, rotatedConfig4_10,
            rotatedConfig4_0_1, rotatedConfig4_01, rotatedConfig4_00,
        ]
        XCTAssertEqual(player.sightWallConfigurations, cellConfig4)
    }
}
