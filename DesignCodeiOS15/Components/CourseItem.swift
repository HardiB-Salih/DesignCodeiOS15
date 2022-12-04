//
//  CourseItem.swift
//  DesignCodeiOS15
//
//  Created by HardiBSalih on 30.11.2022.
//

import SwiftUI

struct CourseItem: View {
    var nameSpace : Namespace.ID
    var course: Course = courses[0]
    @Binding var show : Bool
    
    var body: some View {
        VStack {
            Spacer()
            VStack (alignment: .leading, spacing: 12){
                Text(course.title)
                    .font(.largeTitle.bold())
                    .matchedGeometryEffect(id: "title\(course.id)", in: nameSpace)
                .frame(maxWidth: .infinity, alignment: .leading)
                Text(course.subtitle.uppercased())
                    .font(.footnote.weight(.semibold))
                    .matchedGeometryEffect(id: "subtitle\(course.id)", in: nameSpace)
                Text(course.text)
                    .font(.footnote)
                    .matchedGeometryEffect(id: "text\(course.id)", in: nameSpace)
            }
            .padding(20)
            .background(
                Rectangle()
                    .fill(.ultraThinMaterial)
                    .mask(RoundedRectangle(cornerRadius: 30, style: .continuous)
                        .blur(radius: 30)
                        .matchedGeometryEffect(id: "blur\(course.id)", in: nameSpace))
            )
            
        }
        .foregroundStyle(.white)
        .background(
            Image(course.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(20)
                .matchedGeometryEffect(id: "image\(course.id)", in: nameSpace)
        )
        .background(
            Image(course.background)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .matchedGeometryEffect(id: "background\(course.id)", in: nameSpace)
        )
        .mask(RoundedRectangle(cornerRadius: 30, style: .continuous).matchedGeometryEffect(id: "mask\(course.id)", in: nameSpace))
        .frame(height: 300)
//        .padding(20)
    }
}

struct CourseItem_Previews: PreviewProvider {
    @Namespace static var nameSpace
    static var previews: some View {
        CourseItem(nameSpace: nameSpace, show: .constant(true))
    }
}
