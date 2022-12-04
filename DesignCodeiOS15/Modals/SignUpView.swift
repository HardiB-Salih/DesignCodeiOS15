//
//  SignUpView.swift
//  DesignCodeiOS15
//
//  Created by HardiBSalih on 30.11.2022.
//

import SwiftUI

struct SignUpView: View {
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
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Sign Up").font(.largeTitle).bold()
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
                    
                } label: {
                    Text("Create account")
                        .frame(maxWidth: .infinity)
                }
                .font(.headline)
                .blendMode(.luminosity)
                .buttonStyle(.anguler)
                .tint(.accentColor)
                .controlSize(.large)
                .shadow(color: Color(Shadow).opacity(0.2) ,radius: 30, x: 0, y: 30)
                
                
                
                Text("By clicking on ")
                + Text("__Sign up__, ").foregroundColor(.primary.opacity(0.7))
                + Text("you agree to our **Terms of service** and **[Privacy policy](https://designcode.io)**.")
                
                Divider()
                HStack {
                    Text("Already have an account?")
                    Button {
                        model.selectedModal = .signIn
                    } label: {
                        Text("__Sign in__")
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
            withAnimation(.easeInOut) {
                appear[0] = true
            }
            
            withAnimation(.easeInOut.delay(0.1)) {
                appear[1] = true
            }
            
            withAnimation(.easeInOut(duration: 1).delay(0.2)) {
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

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            SignUpView()
                .environmentObject(Model())
        }
        
    }
}
