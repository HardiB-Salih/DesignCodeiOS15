//
//  Suggestion.swift
//  DesignCodeiOS15
//
//  Created by HardiBSalih on 30.11.2022.
//

import SwiftUI

struct Suggestion: Identifiable {
    let id = UUID()
    var text: String
}

var suggestions = [
    Suggestion(text: "SwiftUI"),
    Suggestion(text: "React"),
    Suggestion(text: "Design")
]
