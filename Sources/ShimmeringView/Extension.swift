//
//  File.swift
//  
//
//  Created by Nikita on 25.11.2023.
//

import SwiftUI

@available(iOS 14.0, *)
@available(macOS 11.0, *)
public extension View {
    
    @ViewBuilder func shimmering(
        active: Bool = true,
        animation: Animation = ShimmeringView.animation,
        gradient: Gradient = ShimmeringView.gradient,
        bandSize: CGFloat = 0.3
    ) -> some View {
        if active {
            modifier(ShimmeringView(animation: animation, gradient: gradient, bandSize: bandSize))
        } else {
            self
        }
    }
    
}
