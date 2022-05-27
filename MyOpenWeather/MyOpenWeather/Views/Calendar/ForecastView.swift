//
//  ForcasView.swift
//  MyOpenWeather
//
//  Created by aicoin on 2022/5/27.
//

import SwiftUI

struct ForecastView: View {
    
    @Environment(\.calendar) var calendar
    
    @EnvironmentObject var cityStore: CityStore
    
    @State var curCity: City
    
    var body: some View {
        ZStack {
            Color(hex: "CDF0EA")
                .ignoresSafeArea()
            
            VStack {
                Picker("City", selection: $curCity) {
                    ForEach(cityStore.cities, id: \.self) { item in
                        Text("\(item.name)")
                    }
                }.pickerStyle(.wheel)
                
                MonthViewBelowThirty(showHeader: false) { date in
                    Text("30")
                        .hidden()
                        .padding(8)
                        .background(Color.gray)
                        .clipShape(Circle())
                        .padding(.vertical, 4)
                        .overlay(
                            Text(String(self.calendar.component(.day, from: date)))
                        )
                }
                
                Spacer()
            }
        }
    }
}

struct ForecastView_Previews: PreviewProvider {
    static var previews: some View {
        ForecastView(curCity: City(name: "Xinyi", lon: 111.1032678, lat: 22.4277951))
            .environmentObject(CityStore())
    }
}
