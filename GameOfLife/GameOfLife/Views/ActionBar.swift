//
//  ActionBar.swift
//  GameOfLife
//
//  Created by Nicolas Pessemier on 2019-08-16.
//  Copyright © 2019 Nicolas Pessemier. All rights reserved.
//

import SwiftUI

struct ActionBar: View {    
    @Binding var grid: Grid
    @Binding var isPlaying: Bool
    @Binding var refreshRateInSec: Double
    @State var timer: Timer?
    
    var body: some View {
        HStack(alignment: .center, spacing: Spacing.actionBar.value) {
            Button(action: { self.resetGrid() }) {
                Image(systemName: "arrow.uturn.left")
                    .imageScale(.large)
            }
            if isPlaying {
                Button(action: { self.stop() }) {
                    Image(systemName: "stop.fill")
                        .imageScale(.large)
                }
            } else {
                Button(action: { self.run() }) {
                    Image(systemName: "play.fill")
                        .imageScale(.large)
                }
            }
        }
    }
    
    func resetGrid() {
        self.grid = Grid(rows: grid.rows, columns: grid.columns)
    }
    
    func run() {
        self.timer = Timer.scheduledTimer(withTimeInterval: self.refreshRateInSec, repeats: true, block: {_ in
            self.grid = self.grid.nextGrid()
        })
        self.timer?.fire()
        self.isPlaying = true
    }
    
    func stop() {
        self.timer?.invalidate()
        self.timer = nil
        isPlaying = false
    }
}

#if DEBUG
struct ActionBar_Previews: PreviewProvider {
    static var previews: some View {
        ActionBar(grid: .constant(Grid(rows: 15, columns: 15)), isPlaying: .constant(false), refreshRateInSec: .constant(0.2))
    }
}
#endif
