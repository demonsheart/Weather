//
//  Tools.swift
//  MyOpenWeather
//
//  Created by herongjin on 2022/4/1.
//

import SwiftUI

struct FitToWidth: ViewModifier {
    var fraction: CGFloat = 1.0
    func body(content: Content) -> some View {
        GeometryReader { g in
        content
            .font(.system(size: 1000))
            .minimumScaleFactor(0.005)
            .lineLimit(1)
            .frame(width: g.size.width * self.fraction)
        }
    }
}
