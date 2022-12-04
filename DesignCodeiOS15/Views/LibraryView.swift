//
//  LibraryView.swift
//  DesignCodeiOS15
//
//  Created by HardiBSalih on 1.12.2022.
//

import SwiftUI

struct LibraryView: View {
    var body: some View {
        ZStack {
            Color(Background).ignoresSafeArea()
            
            ScrollView {
                coursesSection
                
                Text("Topics".uppercased()).titleStyle()
                topicSection

                
                Text("Cirtificate".uppercased()).titleStyle()
                CirtificateView()
                    .frame(height: 220)
                    .background(
                        RoundedRectangle(cornerRadius: 30, style: .continuous)
                            .fill(.linearGradient(colors: [.purple, .blue], startPoint: .topLeading, endPoint: .bottomTrailing))
                            .padding(20)
                            .offset(y: -30)
                    )
                    .background(
                        RoundedRectangle(cornerRadius: 30, style: .continuous)
                            .fill(.linearGradient(colors: [.red, .green], startPoint: .topLeading, endPoint: .bottomTrailing))
                            .padding(40)
                            .offset(y: -60)
                    )
                    .padding(20)
                
            }
            
            
            .safeAreaInset(edge: .top) {
                Color.clear.frame(height: 70)
            }
            .overlay(NavigationBar(title: "Explorer", hasScrolled: .constant(true)))
            .background(Image(BLOB).offset(x: -100, y: -400))
        }
    }
    
    var coursesSection : some View {
        ScrollView (.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                ForEach(courses) { couse in
                    SmallCourseItem(course: couse)
                }
            }.padding(.horizontal ,20)
            
            Spacer()
            
        }
    }
    
    var handbookSections: some View {
        HStack(alignment: .top, spacing: 16) {
            ForEach(handbooks) { handbook in
                HandbookItem(handbook: handbook)
            }
        }.padding(.horizontal, 20)
    }
    
    var topicSection : some View {
        VStack {
            ForEach(topics) { topic in
                TopicList(topic: topic)
            }
        }.padding(20)
            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 30, style: .continuous))
            .strokeStyle(cornerRadius: 30)
            .padding(.horizontal,  20)
    }
}

struct LibraryView_Previews: PreviewProvider {
    static var previews: some View {
        LibraryView()
    }
}
