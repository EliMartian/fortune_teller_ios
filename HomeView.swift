//
//  HomeView.swift
//  Fortune Teller
//
//  Created by E Martin on 4/6/24.
//

import Foundation
import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Welcome to My App!")
                    .font(.title)
                    .padding()

                NavigationLink(destination: PortfolioView()) {
                    Text("Go to Portfolio Page")
                        .foregroundColor(.blue)
                        .padding()
                }
                
                Spacer()
            }
            .navigationBarTitle("Homez")
            .tabItem {
                Image(systemName: "house.fill")
                Text("Homes")
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
