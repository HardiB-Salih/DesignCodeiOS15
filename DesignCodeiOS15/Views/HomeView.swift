//
//  HomeView.swift
//  DesignCodeiOS15
//
//  Created by HardiBSalih on 29.11.2022.
//

import SwiftUI

struct HomeView: View {
    @State var hasScrolled = false
    @Namespace var nameSpace
    @State var show = false
    @State var showStatusBar = false
    @State var selectedId = UUID()
    @State var selectedIndex = 0
    @State var showCourse = false
    // this way i will access the value of this in my model file
    @EnvironmentObject var model : Model
    @AppStorage("isLiteMode") var isLiteMode = true

    
    var body: some View {
        ZStack {
            Color(Background).ignoresSafeArea()
            ScrollView {
                scrollDetection
                featured
                
                Text("Courses".uppercased())
                    .font(.footnote.weight(.semibold))
                    .foregroundColor(.secondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 20)
                
                // inside the array is for the Grid Horizantal spacing
                //outside the array is for the Grid Vertical spacing
                LazyVGrid (columns: [GridItem(.adaptive(minimum: 300), spacing: 20)], spacing: 20) {
                    if !show {
                        cards
                    }else {
                        //We use the else statement to keep the positioning of the card on the screen and not scrolling to the top
                        ForEach(courses) { course in
                            Rectangle()
                                .fill(.white)
                                .frame(height: 300)
                                .cornerRadius(30)
                                .shadow(color: Color(Shadow), radius: 20, x: 0, y: 10)
                                .opacity(0.3)
                            .padding(.horizontal, 30)
                        }
                    }
                }
                .padding(.horizontal, 20)
                
                
            }
            .coordinateSpace(name: "scroll")
            
            //Look Like you are creating your own safeArea with custom size
            .safeAreaInset(edge: .top, content: {
                Color.clear.frame(height: 70)
            })
            .overlay (
                NavigationBar(title: "Featured", hasScrolled: $hasScrolled)
            )
            
            if show {
                detail
            }
        }
        .statusBarHidden(!showStatusBar)
        .onChange(of: show) { newValue in
            withAnimation(.closeCard){
                if newValue {
                    showStatusBar = false
                } else {
                    showStatusBar = true
                }
            }
        }
    }
    
    
    var scrollDetection : some View {
        GeometryReader { proxy in
            Color.clear.preference(key: ScrollPreferenceKey.self ,value: proxy.frame(in: .named("scroll")).midY)
        }
        .frame(height: 0)
        .onPreferenceChange(ScrollPreferenceKey.self ,perform: { value in
            withAnimation(.easeInOut){
                if value < 0 {
                    hasScrolled = true
                } else {
                    hasScrolled = false
                }
            }
        })
    }
    
    var featured : some View {
        TabView {
            ForEach(Array(featuredCourses.enumerated()), id: \.offset) { index,  course in
                GeometryReader { proxy in
                    let minX = proxy.frame(in: .global).minX
                    FeaturedItem(course: course)
                        .frame(maxWidth: 500)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 40)
                        .rotation3DEffect(.degrees(minX / -10), axis: (x: 0, y: 1, z: 0))
                        .shadow(color: Color(Shadow).opacity(isLiteMode ? 0 : 0.3), radius: 5, x: 0, y:3)
                        .blur(radius: abs(minX / 50))
                        .overlay(
                            Image(course.image)
                                .resizable()
                                .aspectRatio( contentMode: .fit)
                                .frame(height: 230)
                                .offset(x: 32, y: -80)
                                .offset(x: minX)
                        )
                        .onTapGesture {
                            showCourse = true
                            selectedIndex = index
                        }
                        .accessibilityElement(children: .combine)
                        .accessibilityAddTraits(.isButton)

                }
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .frame(height: 430)
        .background(
            Image(BLOB)
                .offset(x: 250, y: -100)
                .accessibilityHidden(true)
        )
        .sheet(isPresented: $showCourse) {
            CourseView(nameSpace: nameSpace,course: featuredCourses[selectedIndex], show: $showCourse)
        }
    }
    
    var cards : some View {
        ForEach(courses) { course in
            CourseItem(nameSpace: nameSpace, course: course, show: $show)
                .onTapGesture {
                    withAnimation(.openCard) {
                        show.toggle()
                        model.showDetail.toggle()
                        showStatusBar = false
                        selectedId = course.id
                    }
            }
                .accessibilityElement(children: .combine)
                .accessibilityAddTraits(.isButton)

        }
    }
    
    var detail: some View {
        ForEach(courses) { course in
            //How to make sure that selected id is open only
            if course.id == selectedId {
                CourseView(nameSpace: nameSpace, course: course, show: $show)
                    .zIndex(1)
                    .transition(.asymmetric(
                        insertion: .opacity.animation(.easeInOut(duration: 0.1)),
                    removal: .opacity.animation(.easeInOut(duration: 0.3).delay(0.2))))
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(Model())
    }
}
