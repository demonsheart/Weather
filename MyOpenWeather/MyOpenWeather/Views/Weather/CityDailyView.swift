//
//  CityDailyView.swift
//  MyOpenWeather
//
//  Created by herongjin on 2022/3/27.
//

import SwiftUI
import Kingfisher

struct CityDailyView : View {
    
    @State var day: DailyWeather
    
    var body: some View {
        ZStack {
            HStack(alignment: .center) {
                Text(Date(timeIntervalSince1970: day.dt).formattedDay)
                Spacer()
                HStack(spacing: 16) {
                    verticalTemperatureView(min: true)
                    verticalTemperatureView(min: false)
                }
            }
            .padding([.leading, .trailing])
            
            KFImage(URL(string: day.icon))
                .resizable()
                .scaledToFit()
                .frame(width: 60, height: 60)
        }
    }
    
    func verticalTemperatureView(min: Bool) -> some View {
        VStack(alignment: .trailing) {
            Text(min ? "min" : "max")
                .font(.footnote)
                .foregroundColor(.gray)
            Text(min ? day.temp.min.formattedTemperature : day.temp.max.formattedTemperature)
                .font(.headline)
        }
    }
    
}

//#if DEBUG
//struct CityDailyView_Previews : PreviewProvider {
//    static var previews: some View {
//        CityDailyView()
//    }
//}
//#endif
