//
//  CityRow.swift
//  MyOpenWeather
//
//  Created by herongjin on 2022/3/27.
//

import SwiftUI
import Kingfisher

struct CityRow : View {
    
    @ObservedObject var city: City
    var isEditing: Bool
    
    var body: some View {
        NavigationLink(destination: CityWeatherView(city: city)) {
            HStack {
                Text(city.name)
                    .lineLimit(nil)
                    .font(.title)
                Spacer()
                if !isEditing {
                    KFImage(URL(string: city.weather?.current.icon ?? ""))
                        .resizable()
                        .frame(width: 60, height: 60)
                }
                Spacer()
                Text(city.weather?.current.temp.formattedTemperature ?? "-ºC")
                    .foregroundColor(.gray)
                    .font(.title)
            }
            .padding([.trailing, .top, .bottom])
        }
    }
    
}

//#if DEBUG
//struct CityRow_Previews : PreviewProvider {
//    static var previews: some View {
//        CityRow()
//    }
//}
//#endif
