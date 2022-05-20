//
//  NewCityView.swift
//  MyOpenWeather
//
//  Created by herongjin on 2022/3/27.
//

import SwiftUI

struct NewCityView : View {
    
    @State private var search: String = ""
    @State private var isValidating: Bool = false
    @StateObject private var completer: CityCompletion = CityCompletion()
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var cityStore: CityStore
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    TextField("search", text: $search) {
                        self.completer.search(self.search)
                    }
                }
                
                Section {
                    ForEach(completer.predictions) { prediction in
                        Button(action: {
                            self.addCity(from: prediction)
                            self.presentationMode.wrappedValue.dismiss()
                        }) {
                            if let state = prediction.state {
                                Text("\(prediction.name), \(state), \(prediction.country)")
                                    .foregroundColor(.primary)
                            } else {
                                Text("\(prediction.name), \(prediction.country)")
                                    .foregroundColor(.primary)
                            }
                        }
                    }
                }
            }
            .disabled(isValidating)
            .navigationBarTitle(Text("Add City"))
            .navigationBarItems(leading: cancelButton)
            .listStyle(GroupedListStyle())
        }
    }
    
    private var cancelButton: some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            Text("cancel")
                .foregroundColor(Color(hex: "51C4D3"))
        }
    }
    
    private func addCity(from prediction: CityCompletion.CityData) {
        isValidating = true
        
        DispatchQueue.main.async {
            let city = City(cityData: prediction)
            if !self.cityStore.cities.contains(city) {
                self.cityStore.cities.append(city)
            }
            self.presentationMode.wrappedValue.dismiss()
            self.isValidating = false
        }
    }
    
}

//#if DEBUG
//struct AddCityView_Previews : PreviewProvider {
//    static var previews: some View {
//        AddCityView()
//    }
//}
//#endif
