//
//  navi.swift
//  Cosmic Planner
//
//  Created by Audrey Lucas on 6/24/24.
//

import SwiftUI

struct navi: View {
    var body: some View {
        TabView {
            TaskListView()
                .tabItem() {
                    Image(systemName: "phone.fill")
                    Text("Calls")
                }
        }
    }
}

#Preview {
    navi()
}
