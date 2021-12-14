//
//  Animation.swift
//  Project_11_Animations
//
//  Created by rae on 2021/12/14.
//

import Foundation

enum Animation: String {
    case twoColor = "2-Color"
    case simple2DRotation = "Simple 2D Rotation"
    case multicolor = "Multicolor"
    case multiPointPosition = "Multi Point Position"
    case bezierCurvePosition = "BezierCurve Position"
    case colorAndFrameChange = "Color and Frame Change"
    case viewFadeIn = "View Fade in"
    case pop = "Pop"
    
    static let lists: [Animation] = [
        .twoColor,
        .simple2DRotation,
        .multicolor,
        .multiPointPosition,
        .bezierCurvePosition,
        .colorAndFrameChange,
        .viewFadeIn,
        .pop
    ]
}
