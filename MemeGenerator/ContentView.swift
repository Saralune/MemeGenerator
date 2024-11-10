//
//  ContentView.swift
//  MemeGenerator
//
//  Created by Sara Lefort on 08/11/2024.
//

import SwiftUI
import PhotosUI

struct ContentView: View {
  
  @State var selectedImage: String
  @State var text: String
  @State var isTextOn: Bool
  @State var isShadowOn: Bool
  @State var sliderValue: Double
  @State var selectedColor: Color
  @State var pickedPhoto: PhotosPickerItem? = nil
  @State var image = UIImage()
  
  let imagesArray : [String] = [
    "girl", "hangrycat", "oups", "spongebob", "think", "toystory", "trio", "wait"
  ]
  
  var body: some View {
    ScrollView {
      
      // Image sélectionnée
      ZStack {
        
        if(selectedImage != "") {
          Image(selectedImage)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 200, height: 200)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .padding(3)
        } else {
          Image(uiImage: image)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 200, height: 200)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .padding(3)
        }
        
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
                  image = UIImage()
                }
              
              // Icône d'image sélectionnée
              Image(systemName: selectedImage == img ? "checkmark.circle.fill" : "")
                .foregroundStyle(.white)
                .font(.system(size: 25))
                .offset(x: 80, y: -80)
                .shadow(color: .black, radius: 2, x: 0, y: 2)
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
      
      // Importer la photo depuis le téléphone
      PhotosPicker(selection: $pickedPhoto, matching: .images){
        VStack {
          Text("Importer une photo")
            .foregroundStyle(.orange)
            .bold()
            .font(.title2)
          Image(systemName: "camera.fill")
            .font(.system(size: 50))
            .foregroundStyle(.yellow)
        }
      }
      .padding()
      .onChange(of: pickedPhoto) {
        Task {
          if let data = try? await pickedPhoto?
            .loadTransferable(type: Data.self){
            selectedImage = ""
            image = UIImage(data: data)!
            pickedPhoto = nil
          }
        }
      }
      .frame(maxHeight: .infinity, alignment: .topLeading)
      
    }
  }
}

#Preview {
  ContentView(selectedImage: "", text: "testtetetetete rgrgerherhrherherhehzehzeh", isTextOn: true, isShadowOn: true, sliderValue: 0, selectedColor: Color.white)
}
