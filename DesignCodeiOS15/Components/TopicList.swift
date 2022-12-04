//
//  TopicList.swift
//  DesignCodeiOS15
//
//  Created by HardiBSalih on 1.12.2022.
//

import SwiftUI

struct TopicList: View {
    var topic : Topic = topics[0]
    
    var body: some View {
        HStack (spacing: 16){
            Image(systemName: topic.icon)
                .frame(width: 36, height: 36)
                .background(.ultraThinMaterial, in: Circle())
            Text(topic.title)
                .fontWeight(.semibold)
            
            Spacer()
        }
    }
}

struct TopicList_Previews: PreviewProvider {
    static var previews: some View {
        TopicList()
    }
}
