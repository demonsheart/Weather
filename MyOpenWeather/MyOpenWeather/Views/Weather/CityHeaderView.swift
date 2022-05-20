//
//  CityHeaderView.swift
//  MyOpenWeather
//
//  Created by herongjin on 2022/3/27.
//

import SwiftUI
import Kingfisher

struct CityHeaderView: View {
    
    @ObservedObject var city: City
    
    var temperature: String {
        guard let temperature = city.weather?.current.temp else {
            return "-ºC"
        }
        return temperature.formattedTemperature
    }
    
    var body: some View {
        HStack {
            KFImage(URL(string: city.weather?.current.icon ?? ""))
            Spacer()
            Text(city.weather?.current.weather.first?.weatherDescription ?? "-")
                .font(.title)
            Spacer()
            Text(temperature)
                .font(.title)
            Spacer()
        }
        .frame(height: 80)
    }
    
}

//#if DEBUG
//struct CityHeader_Previews : PreviewProvider {
//    static var previews: some View {
//        CityHeaderView()
//    }
//}
//#endif
