//
//  ModalView.swift
//  DesignCodeiOS15
//
//  Created by HardiBSalih on 30.11.2022.
//

import SwiftUI

struct ModalView: View {
    @EnvironmentObject var model: Model
    @AppStorage("showModal") var showModal = false
    @State var viewState: CGSize = .zero
    @State var isDismised = false
    @State var appear = [false, false ,false]
    @AppStorage("isLogged") var isLogged = false
    
    var body: some View {
        ZStack {
            Color.clear.background(.regularMaterial)
                .onTapGesture {
                    dismissModal()
                }
                .ignoresSafeArea()
            
            Group {
                switch model.selectedModal {
                case .signUp: SignUpView()
                case .signIn: SignInView()
                }
            }
//            .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
            .offset(x: viewState.width, y: viewState.height)
            .offset(y: isDismised ? 1000 : 0)
            .rotationEffect(.degrees(viewState.width / 40))
            .rotation3DEffect(.degrees(viewState.height / 20), axis: (x: 1, y: 0, z: 0))
            .hueRotation(.degrees(viewState.width / 6))
            .gesture(drag)
            .shadow(color: Color(Shadow).opacity(0.2) ,radius: 30, x: 0, y: 30)
            .opacity(appear[0] ? 1 : 0)
            .offset(y: appear[0] ? 0 : 200)
            .padding(20)
            .background(
                Image(BLOB)
                    .offset(x: 200, y: -100)
                    .hueRotation(.degrees(viewState.width / 4))
                    .hueRotation(.degrees(viewState.height / 4))
                    .opacity(appear[2] ? 1 : 0)
                    .offset(y: appear[2] ? 0 : 10)
                    .blur(radius: appear[2] ? 0 : 40)
                    .allowsHitTesting(false)
                    .accessibilityHidden(true)
            )
            
            
            Button {
                dismissModal()
            } label: {
                Image(systemName: "xmark")
                    .font(.body.bold())
                    .foregroundColor(.secondary)
                    .padding(8)
                    .background(.ultraThinMaterial, in: Circle())
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
            .padding(20)
            .opacity(appear[1] ? 1 : 0)
            .offset(y: appear[1] ? 0 : -200)
        }.onAppear{
            withAnimation(.easeInOut) {
                appear[0] = true
            }
            
            withAnimation(.easeInOut.delay(0.1)) {
                appear[1] = true
            }
            
            withAnimation(.easeInOut(duration: 1).delay(0.2)) {
                appear[2] = true
            }
        }.onChange(of: isLogged) { newValue in
            if newValue {
                dismissModal()
            }
        }
    }
    
    var drag: some Gesture {
        DragGesture()
            .onChanged {value in
                viewState = value.translation
            }
            .onEnded{ value in
                if value.translation.height > 200 {
                    withAnimation {
                        showModal = false
                    }
                }
                withAnimation(.openCard){
                    viewState = .zero
                }
            }
        
    }
    
    func dismissModal() {
        withAnimation{
            isDismised = true
        }
        withAnimation(.linear(duration: 1).delay(0.5)) {
            showModal = false
        }
    }
}

struct ModalView_Previews: PreviewProvider {
    static var previews: some View {
        ModalView()
            .environmentObject(Model())
    }
}
