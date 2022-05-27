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
    
    var customLabel: some View {
        HStack {
            Image(systemName: "location")
            Text(String(cityStore.selectedCity.name))
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
                    Picker(selection: $cityStore.selectedCity, label: EmptyView()) {
                        ForEach(cityStore.cities, id: \.self) { item in
                            Text("\(item.name)")
                        }
                    }
                } label: {
                    customLabel
                }
                
                Divider()
                
                MonthViewBelowThirty(showHeader: false) { date in
                    VStack {
                        Text(String(self.calendar.component(.day, from: date)))
                        // TODO: set weather
                        KFImage(URL(string: "https://openweathermap.org/img/wn/10d@2x.png"))
                            .resizable()
                            .frame(width: 30, height: 30)
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
        ForecastView()
            .environmentObject(CityStore())
    }
}
