//
//  MainView.swift
//  MyOpenWeather
//
//  Created by aicoin on 2022/5/27.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var cityStore: CityStore
    
    var body: some View {
        TabView {
            CityListView().environmentObject(cityStore)
                .tabItem {
                    Label("Weather", systemImage: "cloud")
                }
            ForecastView(viewModel: CalendarViewModel(selectedCity: cityStore.cities.first ?? City(name: "Xinyi", lon: 111.1032678, lat: 22.4277951))).environmentObject(cityStore)
                .tabItem {
                    Label("Forecast", systemImage: "calendar")
                }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(CityStore())
    }
}
