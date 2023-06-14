//
//  PieSlice.swift
//  GigaTask
//
//

import SwiftUI

struct PieSlice: Shape {
    var startAngle: Angle
    var endAngle: Angle

    func path(in rect: CGRect) -> Path {
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height) / 2
        let start = CGPoint(
            x: center.x + CGFloat(cos(startAngle.radians - 0.5 * .pi)) * radius,
            y: center.y + CGFloat(sin(startAngle.radians - 0.5 * .pi)) * radius)
        var p = Path()

        p.move(to: center)
        p.addLine(to: start)
        p.addArc(center: center, radius: radius, startAngle: startAngle - .degrees(90), endAngle: endAngle - .degrees(90), clockwise: false)
        p.closeSubpath()

        return p
    }
}
