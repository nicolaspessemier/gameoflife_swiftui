//
//  ContentView.swift
//  GameOfLife
//
//  Created by Nicolas Pessemier on 2019-08-15.
//  Copyright © 2019 Nicolas Pessemier. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var grid: Grid

    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            ActionBar(grid: $grid)
            GridView(grid: $grid)            
                .overlay(Rectangle().stroke(Color.green, lineWidth: 2))
        }
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static let size = 40
    static var previews: some View {        
        ContentView(grid: Grid(rows: size, columns: size))
    }
}
#endif

