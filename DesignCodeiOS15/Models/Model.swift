//
//  Model.swift
//  DesignCodeiOS15
//
//  Created by HardiBSalih on 30.11.2022.
//

import SwiftUI
import Combine


class Model : ObservableObject {
    @Published var showDetail: Bool = false
    @Published var selectedModal : Modal = .signIn
}

enum Modal: String {
    case signUp
    case signIn
}
