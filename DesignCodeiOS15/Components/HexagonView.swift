//
//  HexagonView.swift
//  DesignCodeiOS15
//
//  Created by HardiBSalih on 29.11.2022.
//

import SwiftUI

struct HexagonView: View {
    var body: some View {
        Canvas { context, size in
            context.draw(Image(BLOB), in: CGRect(x: 0, y: 0, width: 200, height: 200))
            
            context.draw(Image(systemName: "hexagon.fill"), in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
            
        }
        .frame(width: 200, height: 212)
        .foregroundStyle(.linearGradient(colors: [.pink, .blue], startPoint: .topLeading, endPoint: .bottomTrailing))
    }
}

struct HexagonView_Previews: PreviewProvider {
    static var previews: some View {
        HexagonView()
    }
}
