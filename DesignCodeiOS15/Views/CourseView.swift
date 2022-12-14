//
//  CourseView.swift
//  DesignCodeiOS15
//
//  Created by HardiBSalih on 30.11.2022.
//

import SwiftUI

struct CourseView: View {
    var nameSpace : Namespace.ID
    var course: Course = courses[0]
    @Binding var show : Bool
    @State var appear = [false, false, false]
    @EnvironmentObject var model : Model
    
    @State var viewState: CGSize = .zero
    @State var isDragable = true
    @State var showSection = false
    @State var selectedIndex = 0
    
    var body: some View {
        ZStack {
            ScrollView {
                cover
                
                content
                    .offset(y: 120)
                    .padding(.bottom, 200)
                    .opacity(appear[2] ? 1 : 0)
            }
            .coordinateSpace(name: "scroll")
            .onAppear{ model.showDetail = true }
            .onDisappear{ model.showDetail = false }
            // Check This Screen Again
            .background(Color(Background))
            .mask(RoundedRectangle(cornerRadius: viewState.width / 3, style: .continuous))
            .shadow(color: .black.opacity(0.3), radius: 30, x: 0, y: 10)
            .scaleEffect(viewState.width / -500 + 1) // play with this numbers
            .background(.black.opacity(viewState.width / 500))
            .background(.ultraThinMaterial)
            .gesture(isDragable ? drag : nil)
            .ignoresSafeArea()
            
            button
            
            
            
        }
        //When the view Appear add the delay to show the element
        .onAppear{
            fadeIn()
        }
        .onChange(of: show) { newV in
            fadeOut()
        }
        
        // When the view dismised its Look like the animation is been used still so i place it befor the close button clicked.
//        .onChange(of: show) { newValue in
//            appear[0] = false
//            appear[1] = false
//            appear[2] = false
//        }
    }
    
    var button : some View {
        Button {
            fadeOut()
            withAnimation(.closeCard) {
                show.toggle()
                model.showDetail.toggle()
            }
        } label: {
            Image(systemName: "xmark")
                .font(.body.bold())
                .foregroundColor(.secondary)
                .padding(8)
                .background(.ultraThinMaterial, in: Circle())
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
        .padding(20)
        .ignoresSafeArea()
    }
    
    var cover : some View {
        GeometryReader { proxy in
            let scrollY = proxy.frame(in: .named("scroll")).minY
            VStack {
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .foregroundStyle(.white)
            .background(
                Image(course.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(20)
                    .frame(maxWidth: 500)
                    .matchedGeometryEffect(id: "image\(course.id)", in: nameSpace)
                // To make the element faster move multiply by positive number
                    .offset(y: scrollY > 0 ? scrollY * -0.8 : 0)
            )
            .background(
                Image(course.background)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .matchedGeometryEffect(id: "background\(course.id)", in: nameSpace)
                    .offset(y: scrollY > 0 ? -scrollY : 0)
                    .scaleEffect(scrollY > 0 ? scrollY / 1000 + 1 : 1) //cool
                    .blur(radius: scrollY / 10)
            )
            .mask(
                RoundedRectangle(cornerRadius: appear[0] ? 0 : 30, style: .continuous)
                .matchedGeometryEffect(id: "mask\(course.id)", in: nameSpace)
                .offset(y: scrollY > 0 ? -scrollY : 0)
            )
            
            .overlay(
                overlayContent
                    .offset(y: scrollY > 0 ? scrollY * -0.6 : 0)
            )
            .frame(height: scrollY > 0 ? 500 + scrollY : 500)
        }.frame(height: 500)
    }
    
    var content: some View {
        VStack(alignment: .leading, spacing: 0) {
            ForEach (Array(courseSections.enumerated()), id: \.offset) { index, section in
                if index != 0 { Divider() }
                SectionRow(section: section)
                    .onTapGesture {
                        showSection = true
                        selectedIndex = index
                    }
            }
        }
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 30, style: .continuous))
        .strokeStyle(cornerRadius: 30)
        .padding(20)
        .sheet(isPresented: $showSection) {
            SectionView(section: courseSections[selectedIndex])
        }
        
    }
    
    var overlayContent : some View {
        VStack(alignment: .leading, spacing: 12){
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
            
            
            Divider()
                .opacity(appear[0] ? 1 : 0)
            HStack{
                Image(AvatarDefault).resizable()
                    .frame(width: 26, height: 26)
                    .cornerRadius(10)
                    .padding(8)
                    .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 18, style: .continuous))
                .strokeStyle(cornerRadius: 18)
                Text("HardiB.Salih")
            }
            .opacity(appear[1] ? 1 : 0)

        }
            .padding(20)
            .background(
                Rectangle()
                    .fill(.ultraThinMaterial)
                    .mask(RoundedRectangle(cornerRadius: 30, style: .continuous).matchedGeometryEffect(id: "blur\(course.id)", in: nameSpace))
            )
            .offset(y: 250)
            .padding(20)
    }
    
    var drag : some Gesture {
        DragGesture(minimumDistance: 30, coordinateSpace: .local)
            .onChanged{ value in
                guard value.translation.width > 0 else { return }
                
                if value.startLocation.x < 100 {
                    withAnimation(.closeCard){
                        viewState = value.translation
                    }
                }
                
                if viewState.width > 200 {
                    close()
                }
            }
            .onEnded { value in
                if viewState.width > 80 {
                    close()
                } else {
                    withAnimation(.closeCard) {
                        viewState = .zero
                    }
                }
            }
    }
    
    func fadeIn() {
        withAnimation(.easeOut.delay(0.3)){
            appear[0] = true
        }
        withAnimation(.easeOut.delay(0.4)){
            appear[1] = true
        }
        withAnimation(.easeOut.delay(0.5)){
            appear[2] = true
        }
    }
    
    func fadeOut() {
        appear[0] = false
        appear[1] = false
        appear[2] = false
    }
    
    func close() {
        withAnimation(.closeCard.delay(0.3)) {
            show.toggle()
            model.showDetail.toggle()
        }
        
        withAnimation(.closeCard) {
            viewState = .zero
        }
        
        isDragable = true
    }
}

struct CourseView_Previews: PreviewProvider {
    @Namespace static var nameSpace

    static var previews: some View {
        CourseView(nameSpace: nameSpace, show: .constant(true))
            .environmentObject(Model())
    }
}
