//
//  MainView.swift
//  MyOpenWeather
//
//  Created by aicoin on 2022/5/27.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            CityListView().environmentObject(CityStore())
                .tabItem {
                    Label("Weather", systemImage: "cloud")
                }
            CalendarView()
                .tabItem {
                    Label("Calendar", systemImage: "calendar")
                }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
