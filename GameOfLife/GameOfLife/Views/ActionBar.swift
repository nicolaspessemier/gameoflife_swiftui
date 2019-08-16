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
    @State var timer: Timer?
    @State var speed: Double = 0.2
    
    var body: some View {
        HStack(alignment: .center, spacing: 60) {
            Button(action: { self.resetGrid() }) {
                Image(systemName: "arrow.uturn.left")
                    .imageScale(.large)
            }
            if timer != nil {
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
        self.timer = Timer.scheduledTimer(withTimeInterval: self.speed, repeats: true, block: {_ in
            self.grid = self.grid.nextGrid()
        })
        self.timer?.fire()
    }
    
    func stop() {
        self.timer?.invalidate()
        self.timer = nil
    }
}

#if DEBUG
struct ActionBar_Previews: PreviewProvider {
    static var previews: some View {
        ActionBar(grid: .constant(Grid(rows: 15, columns: 15)))
    }
}
#endif
