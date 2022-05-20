//
//  CityHourlyView.swift
//  MyOpenWeather
//
//  Created by herongjin on 2022/3/27.
//

import SwiftUI
import Kingfisher

struct CityHourlyView : View {
    
    @ObservedObject var city: City
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 20) {
                ForEach(city.weather?.hours ?? []) { hour in
                    VStack(spacing: 5) {
                        Text(Date(timeIntervalSince1970: hour.dt).formattedHour)
                            .font(.footnote)
                        KFImage(URL(string: hour.icon))
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 45)
                        Text(hour.temp.formattedTemperature)
                            .font(.footnote)
                    }
                }
            }
            .padding([.trailing, .leading])
        }
    }
    
}

//#if DEBUG
//struct CityHourlyView_Previews : PreviewProvider {
//    static var previews: some View {
//        CityHourlyView()
//    }
//}
//#endif
