//
//  CirtificateView.swift
//  DesignCodeiOS15
//
//  Created by HardiBSalih on 1.12.2022.
//

import SwiftUI

struct CirtificateView: View {
    var body: some View {
        VStack (alignment: .leading){
            VStack (alignment: .leading, spacing: 8){
                Text("SwiftUI for iOS 15")
                    .font(.title3.weight(.semibold))
                Text("Cirtificate").font(.subheadline.weight(.medium))
                    .foregroundStyle(.secondary)
            }
            Spacer()
            VStack (alignment: .leading, spacing: 8) {
                Text("FEB 22 22".uppercased())
                    .font(.footnote.weight(.semibold))
                Text("Design Code instractor: Meng To")
                    .font(.footnote.weight(.medium))
            }
            .foregroundStyle(.secondary)
            
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .overlay(
            Image(LOGO2)
            .resizable(resizingMode: .stretch)
            .aspectRatio(contentMode: .fit)
            .frame(width: 26.0, height: 26.0)
            .cornerRadius(10)
            .padding(9)
            .background(Color(.systemBackground).opacity(0.1), in: RoundedRectangle(cornerRadius: 16, style: .continuous))
            .strokeStyle(cornerRadius: 16)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
        
        )
        .padding(20)
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 30, style: .continuous))
        .strokeStyle(cornerRadius: 30)
    }
}

struct CirtificateView_Previews: PreviewProvider {
    static var previews: some View {
        CirtificateView()
    }
}
