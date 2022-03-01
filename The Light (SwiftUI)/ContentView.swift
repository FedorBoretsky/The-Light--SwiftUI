//
//  ContentView.swift
//  The Light (SwiftUI)
//
//  Created by Fedor Boretskiy on 18.01.2022.
//

import SwiftUI

struct ContentView: View {
    
    // MARK: – States
    
    enum AppMode: String {
        case screenSimpleLight = "ScreenSimpleLight"
        case screenTrafficLights = "ScreenTrafficLights"
        case cameraLight = "CameraLight"
        case cameraAndScreenLights = "CameraAndScreenLights"
    }
    
    @State var appMode: AppMode = .screenSimpleLight
    @State var isCameraLightOn = false {
        didSet { toggleTorch(on: isCameraLightOn)}
    }
    @State var isScreenLightOn = true
    @State var trafficLightsIndex = 0
    
    var screenColor: Color {
        switch appMode {
        case .screenSimpleLight:
            return isScreenLightOn ? .white : .black
        case .screenTrafficLights:
            return Color(trafficLightsColors[trafficLightsIndex].backgroundColor)
        case .cameraLight:
            return .black
        case .cameraAndScreenLights:
            return isScreenLightOn ? .white : .black
        }
    }
    
    var buttonIconColor: Color {
        if appMode == .screenTrafficLights {
            return Color( trafficLightsColors[trafficLightsIndex].iconColor )
        } else {
            return Color( UIColor(white: 0.5, alpha: 1) )
        }
    }
    
    // MARK: - Layout
    
    var body: some View {
        ZStack {
            // Fill the whole screen with our color.
            screenColor.ignoresSafeArea()
            // Catch the main tap only in the safe area.
            screenColor.onTapGesture { tapScreen() }
            // Mode switching
            VStack{
                Spacer()
                HStack(alignment: .bottom, spacing: 11) {
                    buttonForMode(.screenSimpleLight)
                    buttonForMode(.screenTrafficLights)
                    buttonForMode(.cameraLight)
                    buttonForMode(.cameraAndScreenLights)
                }
                .padding(.bottom, 33)
                .foregroundColor(buttonIconColor)
            }
        }
        .statusBar(hidden: true)
        .onAppear {
            beginMode(.screenSimpleLight)
        }
    }
    
    func buttonForMode(_ buttonMode: AppMode) -> some View {
        ModeImage(imageName: buttonMode.rawValue, isSelected: buttonMode == appMode)
            .onTapGesture {
                tapButtonForMode(buttonMode)
            }
    }
    
    // MARK: - Interaction
    func tapButtonForMode(_ buttonMode: AppMode) {
        if appMode != buttonMode {
            beginMode(buttonMode)
        } else {
            // Use 2nd, 3rd etc. taps on the buttons to control the current mode.
            // No distraction 'reposition yor  finger' for user.
            tapScreen()
        }
    }
    
    func tapScreen() {
        switch appMode {
        case .screenSimpleLight:
            isScreenLightOn.toggle()
        case .screenTrafficLights:
            trafficLightsIndex = trafficLightsNewIndex()
        case .cameraLight:
            isCameraLightOn.toggle()
        case .cameraAndScreenLights:
            isCameraLightOn.toggle()
            isScreenLightOn = isCameraLightOn
        }
    }
    
    func beginMode(_ newMode: AppMode) {
        appMode = newMode
        switch newMode {
        case .screenSimpleLight:
            isCameraLightOn = false
            isScreenLightOn = true
        case .screenTrafficLights:
            isCameraLightOn = false
        case .cameraLight:
            isCameraLightOn = true
            isScreenLightOn = false
        case .cameraAndScreenLights:
            isCameraLightOn = true
            isScreenLightOn = isCameraLightOn
        }
    }
    
    // MARK: - Traffic lights support
    
    struct BacgroundAndIconColorPair {
        let backgroundColor: UIColor
        let iconColor: UIColor
    }
    
    let trafficLightsColors: [BacgroundAndIconColorPair] = [
        BacgroundAndIconColorPair(backgroundColor: #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1), iconColor: UIColor(white: 1, alpha: 0.78)),
        BacgroundAndIconColorPair(backgroundColor: #colorLiteral(red: 0.9490196078, green: 0.9254901961, blue: 0.3490196078, alpha: 1), iconColor: UIColor(white: 0.5, alpha: 1)),
        BacgroundAndIconColorPair(backgroundColor: #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1), iconColor: UIColor(white: 1, alpha: 0.78))
    ]
    
    // Cycling through colors.
    func trafficLightsNewIndex() -> Int {
        let next = trafficLightsIndex + 1
        return (next < trafficLightsColors.count) ? next : 0
    }
    
}


// MARK: - SwiftUI preview

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
