//
//  NotificationsView.swift
//  Fortune Teller
//
//  Created by E Martin on 4/6/24.
//

//
//  ResearchView.swift
//  Fortune Teller
//
//  Created by E Martin on 4/6/24.
//

import Foundation
import SwiftUI

struct NotificationsView: View {
    init() {
        // Customize appearance of tab bar item
        UITabBar.appearance().tintColor = .black // Set color for selected tab item
        UITabBar.appearance().unselectedItemTintColor = .white // Set color for unselected tab items
    }
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all) // Set black background color
            
            VStack {
                Text("Notifications Screen")
                    .font(.title)
                    .foregroundColor(.white) // Set text color to white
                
                Spacer() // Add spacer to push content to the top
            }
        }
        .navigationBarTitle("Notifications") // Set navigation bar title
        .navigationBarColor(.clear) // Use custom modifier to make navigation bar transparent
    }
}

// Custom modifier to make navigation bar transparent
extension View {
    func navigationBarColor(_ backgroundColor: Color) -> some View {
        modifier(NavigationBarColorModifier(backgroundColor: backgroundColor))
    }
}

// Modifier to customize navigation bar appearance
struct NavigationBarColorModifier: ViewModifier {
    var backgroundColor: Color

    init(backgroundColor: Color) {
        self.backgroundColor = backgroundColor
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().shadowImage = UIImage()
    }

    func body(content: Content) -> some View {
        content
            .background(backgroundColor)
            .onAppear {
                UINavigationBar.appearance().backgroundColor = UIColor(backgroundColor)
            }
            .onDisappear {
                UINavigationBar.appearance().backgroundColor = .clear
            }
    }
}

struct Notifications_Previews: PreviewProvider {
    static var previews: some View {
        NotificationsView()
    }
}
