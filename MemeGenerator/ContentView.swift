//
//  ContentView.swift
//  MemeGenerator
//
//  Created by Sara Lefort on 08/11/2024.
//

import SwiftUI

struct ContentView: View {
  
  @State var selectedImage: String
  @State var text: String
  @State var isTextOn: Bool
  @State var isShadowOn: Bool
  @State var sliderValue: Double
  @State var selectedColor: Color
  
  let imagesArray : [String] = [
    "girl", "hangrycat", "oups", "spongebob", "think", "toystory", "trio", "wait"
  ]
  
    var body: some View {
      ScrollView {
        
        // Image sélectionnée
        ZStack {
          Image(selectedImage)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 200, height: 200)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .padding(3)
            
            if(isTextOn) {
              Text(text)
                .font(.system(size:30, weight: .bold))
                .foregroundStyle(selectedColor)
                .shadow(color: isShadowOn ? .black : .black.opacity(0), radius: 2, x: 0, y: 2)
                .offset(x: 0, y: sliderValue)
            }
          }
          .padding()
          
          Divider()
            .padding()
        
        // Galerie d'images
        ScrollView (.horizontal){
          HStack(spacing: 20) {
              ForEach(imagesArray, id: \.self) { img in
                ZStack{
                  Image(img)
                    .resizable()
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .frame(width: 200, height: 200)
                    .padding()
                    .onTapGesture {
                      selectedImage = img
                    }
                }
              }
          }
        }
        
        // Texte
          HStack {
            Text("Texte")
              .font(.title2)
              .bold()
            
            Spacer()
            
            Toggle("", isOn: $isTextOn)
          }
          .padding([.leading, .trailing])
          
        VStack {
          // Formulaire
          if(isTextOn){
            TextField("Texte", text: $text)
              .textFieldStyle(.roundedBorder)
          }
          
          // Ombre
          HStack{
            Text("Ombre")
            
            Spacer()
            
            Toggle("", isOn: $isShadowOn)
          }
          
          // Position
          HStack{
            Text("Position")
            
            Spacer()
            
            Slider(value: $sliderValue, in: -100 ... 100, step: 1)
          }
          
          // Couleur
          HStack{
            Text("Couleur")
            
            Spacer()
            
            ColorPicker("", selection: $selectedColor)
          }
        }
        .padding()
      }
      .frame(maxHeight: .infinity, alignment: .topLeading)
    }
}

#Preview {
  ContentView(selectedImage: "", text: "testtetetetete rgrgerherhrherherhehzehzeh", isTextOn: true, isShadowOn: true, sliderValue: 0, selectedColor: Color.white)
}
