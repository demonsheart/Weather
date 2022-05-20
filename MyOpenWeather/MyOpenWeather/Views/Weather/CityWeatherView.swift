//
//  CityWeatherView.swift
//  MyOpenWeather
//
//  Created by herongjin on 2022/3/27.
//

import SwiftUI

struct CityWeatherView : View {
    
    @ObservedObject var city: City
    
    var temperature: String {
        guard let temperature = city.weather?.current.temp else {
            return "-ºC"
        }
        return temperature.formattedTemperature
    }
    
    var humidity: String {
        guard let humidity = city.weather?.current.humidity else {
            return "-"
        }
        return String(humidity)
    }
    
    var body: some View {
        ZStack {
            Image("hello")
                .resizable()
            
            ScrollView {
                
                Rectangle().frame(height: 50).foregroundColor(.clear)
                
                LazyVStack {
                    VStack{
                        Text(city.name).font(.title)
                        Text(city.weather?.current.weather.first?.weatherDescription ?? "-")
                        Text(temperature).font(.system(size: 75))
                        Text("humidity \(humidity)%")
                    }.padding(.top, 50)
                    
                    Divider().background(Color.white)
                    
                    CityHourlyView(city: city)
                    
                    Divider().background(Color.white)

                    ForEach(city.weather?.week ?? []) { day in
                        CityDailyView(day: day)
                            .frame(height: 60)
                    }

                }
            }
        }
        .edgesIgnoringSafeArea(.all)
        .foregroundColor(.white)
    }
    
}

//#if DEBUG
//struct ContentView_Previews : PreviewProvider {
//    static var previews: some View {
//        CityWeatherView()
//    }
//}
//#endif
