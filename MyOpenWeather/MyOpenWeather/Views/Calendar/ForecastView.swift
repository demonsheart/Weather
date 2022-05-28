//
//  ForcasView.swift
//  MyOpenWeather
//
//  Created by aicoin on 2022/5/27.
//

import SwiftUI
import Kingfisher

struct ForecastView: View {
    
    @Environment(\.calendar) var calendar
    
    @EnvironmentObject var cityStore: CityStore
    
    @State var selectedCity: City
    
    let dateStr = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    
    var customLabel: some View {
        HStack {
            Image(systemName: "location")
            Text(String(selectedCity.name))
            Text("⌵")
                .offset(y: -4)
        }
        .foregroundColor(.white)
        .font(.title)
        .padding()
        .frame(height: 32)
        .background(Color(hex: "7ee5c2"))
        .cornerRadius(16)
    }
    
    var body: some View {
        ZStack {
            Color(hex: "CDF0EA")
                .ignoresSafeArea()
            
            VStack {
                Menu {
                    Picker(selection: $selectedCity, label: EmptyView()) {
                        ForEach(cityStore.cities, id: \.self) { item in
                            Text("\(item.name)")
                        }
                    }
                } label: {
                    customLabel
                }
                
                Divider()
                
                HStack {
                    ForEach(dateStr, id: \.self) { d in
                        Text(d)
                            .padding(EdgeInsets(top: 3, leading: 6, bottom: 3, trailing: 6))
                    }
                }
                
                Divider()
                
                MonthViewBelowThirty(thirty: $selectedCity.thirtyWeather) { date, weather in
                    VStack {
                        Text(String(self.calendar.component(.day, from: date)))
                        
                        if let icon = weather?.icon {
                            KFImage(URL(string: icon))
                                .resizable()
                                .frame(width: 30, height: 30)
                        } else {
                            Text("-")
                                .frame(width: 30, height: 30)
                        }
                        
                    }
                    .padding(EdgeInsets(top: 3, leading: 6, bottom: 3, trailing: 6))
                }
                
                Spacer()
            }
        }
    }
}

struct ForecastView_Previews: PreviewProvider {
    static var previews: some View {
        let store = CityStore()
        ForecastView(selectedCity: store.cities.first ?? City(name: "Xinyi", lon: 111.1032678, lat: 22.4277951))
            .environmentObject(CityStore())
    }
}
