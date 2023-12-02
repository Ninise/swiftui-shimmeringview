// The Swift Programming Language
// https://docs.swift.org/swift-book

import SwiftUI

@available(iOS 14.0, *)
@available(macOS 10.15, *)
public struct ShimmeringUiView: ViewModifier {
    
    @Environment(\.layoutDirection) private var direction
    
    @State private var isInit = true
    
    private let animation: Animation
    private let gradient: Gradient
    private let min, max: CGFloat
    
    public static let animation = Animation
        .linear(duration: 1.5)
        .delay(0.25)
        .repeatForever(autoreverses: false)

    public static let gradient = Gradient(colors: [
        .gray.opacity(0.6),
        .gray,
        .gray.opacity(0.6)
    ])

    var startPoint: UnitPoint {
        if direction == .rightToLeft {
            return isInit ? UnitPoint(x: max, y: min) : UnitPoint(x: 0, y: 1)
        } else {
            return isInit ? UnitPoint(x: min, y: min) : UnitPoint(x: 1, y: 1)
        }
    }

    var endPoint: UnitPoint {
        if direction == .rightToLeft {
            return isInit ? UnitPoint(x: 1, y: 0) : UnitPoint(x: min, y: max)
        } else {
            return isInit ? UnitPoint(x: 0, y: 0) : UnitPoint(x: max, y: max)
        }
    }
    
    public init(
        animation: Animation = Self.animation,
        gradient: Gradient = Self.gradient,
        bandSize: CGFloat = 0.3
    ) {
        
        self.animation = animation
        self.gradient = gradient
        self.min = 0 - bandSize
        self.max = 1 + bandSize
            
    }

    public func body(content: Content) -> some View {
        content
            .redacted(reason: .placeholder)
            .mask(LinearGradient(gradient: gradient, startPoint: startPoint, endPoint: endPoint))
            .animation(animation, value: isInit)
            .onAppear {
                isInit = false
            }
    }
}

