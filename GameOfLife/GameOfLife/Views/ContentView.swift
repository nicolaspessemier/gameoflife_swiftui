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
    @State var refreshRateInSec: Double = 0.2
    @State var isPlaying = false
    
    var body: some View {
        VStack(alignment: .center, spacing: Spacing.contentViewVertical.value) {
            CustomSlider(refreshRateInSec: $refreshRateInSec, isPlaying: $isPlaying)
            
            ActionBar(grid: $grid,
                      isPlaying: $isPlaying,
                      refreshRateInSec: $refreshRateInSec)
            GridView(grid: $grid)            
                .overlay(Rectangle().stroke(Color.green, lineWidth: 2))
        }
    }
}

struct CustomSlider: View {
    @Binding var refreshRateInSec: Double
    @Binding var isPlaying: Bool
    let sliderRange = 0.05...2.0
    
    var body: some View {
        HStack(alignment: .center, spacing: Spacing.sliderHorizontal.value) {
            Text(String(format: "Refresh Rate: %.2f s", CGFloat(refreshRateInSec)))
            Slider(value: $refreshRateInSec, in: sliderRange)
                .padding()
                .disabled(isPlaying)            
        }
        .padding()
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



