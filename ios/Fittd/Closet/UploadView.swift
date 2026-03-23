//
//  UploadView.swift
//  Fittd
//
//  Created by 佐保楓 on 2025/06/19.
//

import SwiftUI
import PhotosUI
import UIKit

struct UploadView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var model: Model // your shared model
    
    @State private var photoItem: PhotosPickerItem?
    @State private var selectedImage: UIImage?
    @State private var imageData: Data?
    @State private var resultText: String = ""
    
    
    @State private var category = ""
    @State private var subcategory = ""
    @State private var colorName = ""
    @State private var mood = ""
    @State private var season = ""
    @State private var occasion = ""
    @State private var brand = ""
    
    var itemToEdit: ClothingItem?
    
    init(itemToEdit: ClothingItem? = nil) {
        self.itemToEdit = itemToEdit
        // Pre-fill values if editing
        _category = State(initialValue: itemToEdit?.category ?? "")
        _subcategory = State(initialValue: itemToEdit?.subcategory ?? "")
        _colorName = State(initialValue: itemToEdit?.colorName ?? "")
        _mood = State(initialValue: itemToEdit?.mood ?? "")
        _season = State(initialValue: itemToEdit?.season ?? "")
        _occasion = State(initialValue: itemToEdit?.occasion ?? "")
        _brand = State(initialValue: itemToEdit?.brand ?? "")
        _imageData = State(initialValue: itemToEdit?.imageData)
        if let data = itemToEdit?.imageData, let uiImg = UIImage(data: data) {
            _selectedImage = State(initialValue: uiImg)
        }
    }
    
    var body: some View {
        Form{
      
            PhotosPicker("Select Photo", selection: $photoItem, matching: .images)
                .onChange(of: photoItem) {  oldItem, newItem in
                    if let newItem {
                        Task {
                            if let data = try? await newItem.loadTransferable(type: Data.self),
                               let uiImage = UIImage(data: data) {
                                self.selectedImage = uiImage
                                uploadImage(image: uiImage)
                                
                            }
                        } // Task
                    }
                } // PhotosPicker
    
            
            if let uiImage = selectedImage {
                VStack {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 250)
                        .cornerRadius(10)
                }
                .frame(maxWidth: .infinity, alignment: .center)

            }
            
            
       
            
            Group {
                Picker("Category", selection: $category) {
                    Text("Select").tag("")
                    ForEach(Array(categoryData.keys), id: \.self) { Text($0) }
                }
           
                Picker("Subcategory", selection: $subcategory) {
                    Text("Select ").tag("")
                    ForEach(categoryData[category] ?? [], id: \.self) { Text($0) }
                }
                      
                Picker("Color", selection: $colorName) {
                    Text("Select ").tag("")
                    ForEach(colorOptions, id: \.self) { Text($0.capitalized) }
                }
                      
                Picker("Mood", selection: $mood) {
                    Text("Select").tag("")
                    ForEach(moods, id: \.self) { Text($0) }
                }
                    
                Picker("Season", selection: $season) {
                    Text("Select").tag("")
                    ForEach(seasons, id: \.self) { Text($0) }
                }
            
                Picker("Occasion", selection: $occasion) {
                    Text("Select").tag("")
                    ForEach(occasions, id: \.self) { Text($0) }
                }
                HStack {
                    Text("Brand: ")
                    TextField("", text: $brand)
                }
      
        } // Group
        .pickerStyle(.menu)
    
            Button("Save") {
                if let data = imageData {
                    let item = ClothingItem(
                        imageData: data,
                        category: category,
                        subcategory: subcategory,
                        colorName: colorName,
                        mood: mood,
                        season: season,
                        occasion: occasion,
                        brand: brand
                    )
                    if let oldItem = itemToEdit,
                       let index = model.allClothes.firstIndex(of: oldItem) {
                        // Update existing
                        model.allClothes[index] = item
                       
                    } else {
                        model.allClothes.append(item)
                    }
                    
                    dismiss()
                }
            } // Button
            .frame(maxWidth: .infinity, alignment: .center)
            .padding(.top, 20)
            .disabled(imageData == nil)
            .buttonStyle(.borderedProminent)
        } //Form
        .scrollContentBackground(.hidden)
        .padding(.top, -30)
    } //body
    
    
    
    func uploadImage(image: UIImage) {
        guard let url = URL(string: "http://127.0.0.1:5000/remove-background") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let boundary = UUID().uuidString
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        var data = Data()
        let imageData = image.pngData()!
        data.append("--\(boundary)\r\n".data(using: .utf8)!)
        data.append("Content-Disposition: form-data; name=\"file\"; filename=\"image.png\"\r\n".data(using: .utf8)!)
        data.append("Content-Type: image/png\r\n\r\n".data(using: .utf8)!)
        data.append(imageData)
        data.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)
        
        URLSession.shared.uploadTask(with: request, from: data) { responseData, _, error in
            if let data = responseData, let uiImage = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.selectedImage = uiImage
                    self.imageData = data
                }
            }
        }.resume()
    } // func
} // UploadClothingView




#Preview {
    UploadView()
        .environmentObject(Model())
}
