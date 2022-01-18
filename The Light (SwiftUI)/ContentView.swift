//
//  ContentView.swift
//  The Light (SwiftUI)
//
//  Created by Fedor Boretskiy on 18.01.2022.
//

import SwiftUI

struct ContentView: View {
    @State var isLightOn = true
    var bgColor: Color {
        isLightOn ? .white : .black
    }
    
    var body: some View {
        ZStack {
            // Fill the whole screen with our color.
            bgColor.ignoresSafeArea()
            // Catch the main tap only in the safe area.
            bgColor.onTapGesture { isLightOn.toggle() }
        }
        .statusBar(hidden: true)
    }
} 

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
