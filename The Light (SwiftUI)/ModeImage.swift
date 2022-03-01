//
//  ModeImage.swift
//  The Light (SwiftUI)
//
//  Created by Fedor Boretskiy on 01.03.2022.
//

import SwiftUI

struct ModeImage: View {
    
    let imageName: String
    let isSelected: Bool
    
    var body: some View {
        Image(imageName + (isSelected ? " (Selected)" : ""))
    }
}

struct ModeImage_Previews: PreviewProvider {
    static var previews: some View {
        HStack(alignment: .bottom, spacing: 11) {
            ModeImage(imageName: "ScreenSimpleLight", isSelected: true)
            ModeImage(imageName: "ScreenTrafficLights", isSelected: false)
            ModeImage(imageName: "CameraLight", isSelected: false)
            ModeImage(imageName: "CameraAndScreenLights", isSelected: false)
        }
        .foregroundColor(.red)
    }
}
