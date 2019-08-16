//
//  Grid.swift
//  GameOfLife
//
//  Created by Nicolas Pessemier on 2019-08-15.
//  Copyright © 2019 Nicolas Pessemier. All rights reserved.
//

import Foundation

struct Grid {
    let rows: Int, columns: Int
    private var values: [Bool]
    
    init(rows: Int, columns: Int) {
        self.rows = rows
        self.columns = columns
        values = Array(repeating: false, count: rows * columns)
        randomnize()
    }
    
    static let `default` = Self(rows: 25, columns: 25)

    func indexIsValid(row: Int, column: Int) -> Bool {
        return row >= 0 && row < rows && column >= 0 && column < columns
    }

    subscript(row: Int, column: Int) -> Bool {
        get {
            assert(indexIsValid(row: row, column: column), "Index out of range")
            return values[(row * columns) + column]
        }
        set {
            assert(indexIsValid(row: row, column: column), "Index out of range")
            values[(row * columns) + column] = newValue
        }
    }
    
    func debugPrint() {
        for i in 0..<rows {
            for j in 0..<columns {
                print(self[i, j] ? "X " : ". ", terminator: "")
            }
            print()
        }
    }
    
    func nextGrid() -> Grid {
        var newGrid = Grid(rows: rows, columns: columns)
        for row in 0..<rows {
            for column in 0..<columns {
                let index = IndexPath(row: row, section: column)
                newGrid[row, column] = willCellLive(at: index)
            }
        }
        return newGrid
    }
    
    private func isAlive(at index: IndexPath) -> Bool {
        return self[index.row, index.section]
    }
    
    private func willCellLive(at index: IndexPath) -> Bool {
        let aliveNeighbors = self.neighborsAlive(index: index)
        if isAlive(at: index) {
            switch aliveNeighbors {
            case 0...1: return false
            case 2...3: return true
            default: return false
            }
        } else {
            return aliveNeighbors == 3
        }
    }
    
    private func neighborsAlive(index: IndexPath) -> UInt {
        let indexesToCheck = [
            IndexPath(row: index.row + 1, section: index.section), // right
            IndexPath(row: index.row + 1, section: index.section + 1),
            IndexPath(row: index.row , section: index.section + 1), // bottom
            IndexPath(row: index.row - 1, section: index.section + 1),
            IndexPath(row: index.row - 1, section: index.section), // left
            IndexPath(row: index.row - 1, section: index.section - 1),
            IndexPath(row: index.row, section: index.section - 1), // top
            IndexPath(row: index.row + 1, section: index.section - 1),
        ]
        var neighborsAlive: UInt = 0
        for currentIndex in indexesToCheck {
            if currentIndex.row >= 0,
                currentIndex.section >= 0,
                currentIndex.row < rows,
                currentIndex.section < columns,
                self.isAlive(at: currentIndex) {
                neighborsAlive = neighborsAlive + 1
            }
        }
        return neighborsAlive
    }
    
    private mutating func randomnize() {
        for i in 0..<values.count {
            values[i] = Int.random(in: 0...1) == 1
        }
    }
}
