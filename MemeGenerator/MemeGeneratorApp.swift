//
//  MemeGeneratorApp.swift
//  MemeGenerator
//
//  Created by Sara Lefort on 08/11/2024.
//

import SwiftUI

@main
struct MemeGeneratorApp: App {
    var body: some Scene {
        WindowGroup {
          ContentView(selectedImage: "", text: "", isTextOn: true, isShadowOn: true, sliderValue: 0, selectedColor: Color.white)
        }
    }
}
