//
//  Calendar.swift
//  MyOpenWeather
//
//  Created by aicoin on 2022/5/27.
//

import SwiftUI

extension DateFormatter {
    static var month: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM"
        return formatter
    }

    static var monthAndYear: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter
    }
}

extension Calendar {
    func generateDates(
        inside interval: DateInterval,
        matching components: DateComponents
    ) -> [Date] {
        var dates: [Date] = []
        dates.append(interval.start)

        enumerateDates(
            startingAfter: interval.start,
            matching: components,
            matchingPolicy: .nextTime
        ) { date, _, stop in
            if let date = date {
                if date < interval.end {
                    dates.append(date)
                } else {
                    stop = true
                }
            }
        }

        return dates
    }
}

struct WeekView<DateView>: View where DateView: View {
    @Environment(\.calendar) var calendar

    let week: Date
    let content: (Date) -> DateView

    init(week: Date, @ViewBuilder content: @escaping (Date) -> DateView) {
        self.week = week
        self.content = content
    }

    private var days: [Date] {
        guard
            let weekInterval = calendar.dateInterval(of: .weekOfYear, for: week)
            else { return [] }
        return calendar.generateDates(
            inside: weekInterval,
            matching: DateComponents(hour: 0, minute: 0, second: 0)
        )
    }

    var body: some View {
        HStack {
            ForEach(days, id: \.self) { date in
                HStack {
                    if self.calendar.isDate(self.week, equalTo: date, toGranularity: .month) {
                        self.content(date)
                    } else {
                        self.content(date).hidden()
                    }
                }
            }
        }
    }
}

struct MonthView<DateView>: View where DateView: View {
    @Environment(\.calendar) var calendar

    let month: Date
    let showHeader: Bool
    let content: (Date) -> DateView

    init(
        month: Date,
        showHeader: Bool = true,
        @ViewBuilder content: @escaping (Date) -> DateView
    ) {
        self.month = month
        self.content = content
        self.showHeader = showHeader
    }

    private var weeks: [Date] {
        guard
            let monthInterval = calendar.dateInterval(of: .month, for: month)
            else { return [] }
        return calendar.generateDates(
            inside: monthInterval,
            matching: DateComponents(hour: 0, minute: 0, second: 0, weekday: calendar.firstWeekday)
        )
    }

    private var header: some View {
        let component = calendar.component(.month, from: month)
        let formatter = component == 1 ? DateFormatter.monthAndYear : .month
        return Text(formatter.string(from: month))
            .font(.title)
            .padding()
    }

    var body: some View {
        VStack {
            if showHeader {
                header
            }

            ForEach(weeks, id: \.self) { week in
                WeekView(week: week, content: self.content)
            }
        }
    }
}

struct CalendarView<DateView>: View where DateView: View {
    @Environment(\.calendar) var calendar

    let interval: DateInterval
    let content: (Date) -> DateView

    init(interval: DateInterval, @ViewBuilder content: @escaping (Date) -> DateView) {
        self.interval = interval
        self.content = content
    }

    private var months: [Date] {
        calendar.generateDates(
            inside: interval,
            matching: DateComponents(day: 1, hour: 0, minute: 0, second: 0)
        )
    }

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                ForEach(months, id: \.self) { month in
                    MonthView(month: month, content: self.content)
                }
            }
        }
    }
}

struct RootView: View {
    @Environment(\.calendar) var calendar

    private var year: DateInterval {
        calendar.dateInterval(of: .year, for: Date())!
    }

    var body: some View {
        CalendarView(interval: year) { date in
            Text("30")
                .hidden()
                .padding(8)
                .background(Color.blue)
                .clipShape(Circle())
                .padding(.vertical, 4)
                .overlay(
                    Text(String(self.calendar.component(.day, from: date)))
                )
        }
    }
}


// MARK: Custom
struct MonthViewBelowThirty<DateView>: View where DateView: View {
    @Environment(\.calendar) var calendar
    
    let content: (Date, ThirtyDailyWeather?) -> DateView
    @Binding var thirty: ThirtyWeatherList?
    
    var weathers: [ThirtyDailyWeather] {
        return thirty?.list ?? [ThirtyDailyWeather]()
    }
    
    var dates: [Date] {
        return weathers.map { $0.date } .sorted { $0 < $1 }
    }

    init(
        thirty: Binding<ThirtyWeatherList?>,
        @ViewBuilder content: @escaping (Date, ThirtyDailyWeather?) -> DateView
    ) {
        self.content = content
        self._thirty = thirty
    }

    private var weeks: [Date] {
        let monthInterval = DateInterval(start: Date(), duration: TimeInterval(30 * 24 * 60 * 60))
        return calendar.generateDates(
            inside: monthInterval,
            matching: DateComponents(hour: 0, minute: 0, second: 0, weekday: calendar.firstWeekday)
        )
    }
    
    private func weakOfDate(week: Date) -> [Date] {
        guard
            let weekInterval = calendar.dateInterval(of: .weekOfYear, for: week)
            else { return [] }
        
        return calendar.generateDates(
            inside: weekInterval,
            matching: DateComponents(hour: 0, minute: 0, second: 0)
        )
    }
    
    func getWeatherFor(date: Date) -> ThirtyDailyWeather? {
        var res: ThirtyDailyWeather? = nil
        for weather in weathers {
            if (self.calendar.isDate(date, inSameDayAs: weather.date)) {
                res = weather
                break
            }
        }
        return res
    }

    var body: some View {
        VStack {
            ForEach(weeks, id: \.self) { week in
                HStack {
                    ForEach(weakOfDate(week: week), id: \.self) { date in
                        HStack {
                            if self.calendar.isDate(week, equalTo: date, toGranularity: .month) && date > Date().dayBefore {
                                self.content(date, getWeatherFor(date: date))
                            } else {
                                self.content(date, nil).hidden()
                            }
                        }
                    }
                }
            }
        }
    }
}
