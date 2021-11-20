//
//  Stopwatch.swift
//  02_Stopwatch
//
//  Created by rae on 2021/11/20.
//

import UIKit

class Stopwatch {
    var timer: Timer
    var count: Double
    var isCounting: Bool
    
    init() {
        timer = Timer()
        count = 0.0
        isCounting = false
    }
}
