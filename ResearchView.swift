//
//  ResearchView.swift
//  Fortune Teller
//
//  Created by E Martin on 4/6/24.
//

import Foundation
import SwiftUI

struct ResearchView: View {
    var body: some View {
        Text("Research Screen")
            .font(.title)
            .navigationBarTitle("Research")
            .tabItem {
                Image(systemName: "magnifyingglass")
                Text("Search")
            }
    }
}

struct Research_Previews: PreviewProvider {
    static var previews: some View {
        ResearchView()
    }
}
