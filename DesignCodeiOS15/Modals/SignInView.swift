//
//  SignInView.swift
//  DesignCodeiOS15
//
//  Created by HardiBSalih on 30.11.2022.
//

import SwiftUI

struct SignInView: View {
    enum Field: Hashable {
        case email
        case password
    }
    @State var email = ""
    @State var password = ""
    @FocusState var focusField : Field?
    @State var circleY : CGFloat = 120
    @State var emailY : CGFloat = 0
    @State var passwordY : CGFloat = 0
    @State var circleColor: Color = .blue
    @EnvironmentObject var model : Model
    @State var appear = [false, false ,false]
    @AppStorage("isLogged") var isLogged = false
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Sign in").font(.largeTitle).bold()
                .opacity(appear[0] ? 1 : 0)
                .offset(y: appear[0] ? 0 : 20)
            Text("Access 120+ hours of courses, tutorials and livestreams")
                .font(.headline)
                .opacity(appear[1] ? 1 : 0)
                .offset(y: appear[1] ? 0 : 20)
            //How to Using Combine Text
            Group {
                TextField("Email", text: $email)
                    .inputStyle()
                    .textContentType(.emailAddress)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .focused($focusField, equals: .email)
                    .shadow(color: focusField == .email ? .primary.opacity(0.3) : .clear, radius: 10, x: 0, y: 3)
                    .overlay(geometry)
                    .onPreferenceChange(CirclePreferenceKey.self) { value in
                        emailY = value
                        circleY = value
                    }
                SecureField("Password", text: $password)
                    .inputStyle(icon: "lock")
                    .textContentType(.password)
                    .focused($focusField, equals: .password)
                    .shadow(color: focusField == .password ? .primary.opacity(0.3) : .clear, radius: 10, x: 0, y: 3)
                    .overlay(geometry)
                    .onPreferenceChange(CirclePreferenceKey.self) { value in
                        passwordY = value
                    }
                
                Button {
                    isLogged = true
                } label: {
                    Text("Sign In")
                        .frame(maxWidth: .infinity)
                }
                .font(.headline)
                .blendMode(.luminosity)
                .buttonStyle(.anguler)
                .tint(.accentColor)
                .controlSize(.large)
                .shadow(color: Color(Shadow).opacity(0.2) ,radius: 30, x: 0, y: 30)
                
                
                
                Divider()
                HStack {
                    Text("No account yet?")
                    Button {
                        model.selectedModal = .signUp
                    } label: {
                        Text("__Sign up__")
                    }
                }
            }
            .font(.footnote)
            .foregroundColor(.secondary)
            .accentColor(.secondary)
            .opacity(appear[2] ? 1 : 0)
            .offset(y: appear[2] ? 0 : 20)
            
        }
        .padding(20)
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 30, style: .continuous))
        .background(
            Circle()
                .fill(circleColor)
                .frame(width: 68, height: 68)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                .offset(y: circleY)
        )
        .coordinateSpace(name: "container")
        .strokeStyle(cornerRadius: 30)
        //        .shadow(color: Color(Shadow).opacity(0.2) ,radius: 30, x: 0, y: 30)
        //        .padding(20)
        //        .background(
        //            Image(BLOB)
        //                .offset(x: 200, y: -100)
        //        )
        .onChange(of: focusField) { value in
            withAnimation(.openCard) {
                if value == .email {
                    circleY = emailY
                    circleColor = .blue
                } else {
                    circleY = passwordY
                    circleColor = .red
                }
            }
        }.onAppear{
            withAnimation(.spring().delay(0.1)) {
                appear[0] = true
            }
            
            withAnimation(.spring().delay(0.2)) {
                appear[1] = true
            }
            
            withAnimation(.spring().delay(0.3)) {
                appear[2] = true
            }
        }
        .onDisappear{
            withAnimation(.easeInOut) {
                appear[0] = false
            }
            
            withAnimation(.easeInOut.delay(0.1)) {
                appear[1] = false
            }
            
            withAnimation(.easeInOut(duration: 1).delay(0.2)) {
                appear[2] = false
            }
        }
        
    }
    
    var geometry : some View {
        GeometryReader { proxy in
            Color.clear.preference(key: CirclePreferenceKey.self, value: proxy.frame(in: .named("container")).minY)
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            SignInView()
                .environmentObject(Model())
        }
    }
}
