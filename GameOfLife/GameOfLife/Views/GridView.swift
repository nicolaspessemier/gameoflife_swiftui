//
//  GridView.swift
//  GameOfLife
//
//  Created by Nicolas Pessemier on 2019-08-16.
//  Copyright © 2019 Nicolas Pessemier. All rights reserved.
//

import SwiftUI

struct GridView: View {
    @Binding var grid: Grid
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ForEach(0..<grid.rows) { row in
                HStack(alignment: .center, spacing: 0) {
                    ForEach(0..<self.grid.columns) { column in
                        Circle()
                            .frame(width: 10.0, height: 10.0, alignment: .center)
                            .foregroundColor(self.grid[row, column] ? .green : .white)
                    }
                }
            }
        }
    }
}

#if DEBUG
struct GridView_Previews: PreviewProvider {
    static var previews: some View {
        GridView(grid: .constant(.default))
    }
}
#endif