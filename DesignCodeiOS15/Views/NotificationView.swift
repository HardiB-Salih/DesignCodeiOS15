//
//  NotificationView.swift
//  DesignCodeiOS15
//
//  Created by HardiBSalih on 1.12.2022.
//

import SwiftUI

struct NotificationView: View {
    var body: some View {
        ZStack {
            Color(Background).ignoresSafeArea()
            
            ScrollView {
                sectionSection
            }
            .background(
                Image(BLOB)
                    .offset(x: -180, y: 300)
            )
        }
        .safeAreaInset(edge: .top, content: {
            Color.clear.frame(height: 70)
        })
        
        .overlay(NavigationBar(title: "Notification", hasScrolled: .constant(true)))
    }
    
    var sectionSection: some View {
        VStack(alignment: .leading, spacing: 0) {
            ForEach (Array(courseSections.enumerated()), id: \.offset) { index, section in
                if index != 0 { Divider() }
                SectionRow(section: section)
            }
        }
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 30, style: .continuous))
        .strokeStyle(cornerRadius: 30)
        .padding(20)
    }
}

struct NotificationView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationView()
    }
}
