//
//  AngulerButtonStyle.swift
//  DesignCodeiOS15
//
//  Created by HardiBSalih on 30.11.2022.
//

import SwiftUI

struct AngulerButtonStyle : ButtonStyle {
    @Environment(\.controlSize) var controlSize
    var extraPadding : CGFloat {
        switch controlSize {
        case .mini:
            return 0
        case .small:
            return 0
        case .regular:
            return 4
        case .large:
            return 12
        @unknown default:
            return 0
        }
    }
    
    var cornerRadius : CGFloat {
        switch controlSize {
        case .mini:
            return 12
        case .small:
            return 12
        case .regular:
            return 16
        case .large:
            return 20
        @unknown default:
            return 12
        }
    }
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .padding(.horizontal, 10 + extraPadding)
            .padding(.vertical, 4 + extraPadding)
            .background(
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    .fill(.linearGradient(colors: [Color(.systemBackground), Color(.systemBackground).opacity(0.6)], startPoint: .top, endPoint: .bottom))
                    .blendMode(.softLight)
            
            )
            .background(
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    .fill(AngularGradient(colors: [.pink, .purple, .blue, .pink], center: .center, startAngle: .degrees(-90), endAngle: .degrees(270)))
                    .blur(radius: cornerRadius)
            )
            .strokeStyle(cornerRadius: cornerRadius)
    }
}

extension ButtonStyle where Self == AngulerButtonStyle {
    static var anguler : Self {
        return .init()
    }
}
