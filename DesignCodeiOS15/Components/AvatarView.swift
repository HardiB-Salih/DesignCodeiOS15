//
//  AvatarView.swift
//  DesignCodeiOS15
//
//  Created by HardiBSalih on 1.12.2022.
//

import SwiftUI

struct AvatarView: View {
    @AppStorage("isLogged") var isLogged = true

    var body: some View {
        
        
        Group {
            if isLogged {
                AsyncImage(url: URL(string: "https://picsum.photos/200"), transaction: Transaction(animation: .linear)) { phase in
                    switch phase {
                    case .success(let image):
                        image.resizable()
                            .transition(.scale(scale: 0.5, anchor: .center))
                    case .empty:
                        ProgressView()
                    case .failure(_):
                        Color.gray
                    @unknown default:
                        EmptyView()
                    }
                }
            }else {
                Image(AvatarDefault)
                    .resizable()
            }
        }
        .frame(width: 26, height: 26)
        .cornerRadius(10)
        .padding(8)
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 18, style: .continuous))
        .strokeStyle(cornerRadius: 18)
    }
}

struct AvatarView_Previews: PreviewProvider {
    static var previews: some View {
        AvatarView(isLogged: false)
    }
}
