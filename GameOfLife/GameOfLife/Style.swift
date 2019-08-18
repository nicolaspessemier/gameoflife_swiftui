//
//  Style.swift
//  GameOfLife
//
//  Created by Nicolas Pessemier on 2019-08-18.
//  Copyright © 2019 Nicolas Pessemier. All rights reserved.
//

import UIKit

enum Spacing {
    case actionBar, defaultMargin, contentViewVertical, sliderHorizontal
    
    var value: CGFloat {
        switch self {
        case .actionBar: return 60.0
        case .defaultMargin: return 20.0
        case .contentViewVertical: return 25.0
        case .sliderHorizontal: return 20.0
        }
    }
}
