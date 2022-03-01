//
//  ModeImageView.swift
//  The Light (SwiftUI)
//
//  Created by Fedor Boretskiy on 01.03.2022.
//

import SwiftUI

struct ModeImageView: View {
    
    let imageName: String
    let isSelected: Bool
    
    var body: some View {
        Image(imageName + (isSelected ? " (Selected)" : ""))
    }
}

struct ModeImage_Previews: PreviewProvider {
    static var previews: some View {
        HStack(alignment: .bottom, spacing: 11) {
            ModeImageView(imageName: "ScreenSimpleLight", isSelected: true)
            ModeImageView(imageName: "ScreenTrafficLights", isSelected: false)
            ModeImageView(imageName: "CameraLight", isSelected: false)
            ModeImageView(imageName: "CameraAndScreenLights", isSelected: false)
        }
        .foregroundColor(.red)
    }
}
