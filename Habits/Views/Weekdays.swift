//
//  Weekdays.swift
//  Habits
//
//  Created by Ipek Erten on 17/12/24.
//

import Foundation

struct Weekday: Identifiable {
    let id = UUID()
    let number: Int
    let name: String
}

func daysForCurrentWeek() -> [Weekday] {
    let calendar = Calendar.current
    let today = Date()
    let weekdaySymbols = calendar.shortWeekdaySymbols // ["Sun", "Mon", "Tue", ...]

    // Get the current weekday number (1 for Sunday, 2 for Monday, ...)
    let todayWeekday = calendar.component(.weekday, from: today)

    // Generate an array of day names and corresponding numbers
    return (0..<7).map { offset in
        let adjustedIndex = (todayWeekday - 1 + offset) % 7 // Wrap around indices
        let dayName = weekdaySymbols[adjustedIndex].uppercased()
        let dayDate = calendar.date(byAdding: .day, value: offset, to: today)!
        let dayNumber = calendar.component(.day, from: dayDate)

        return Weekday(
            number: dayNumber,
            name: adjustedIndex == (todayWeekday - 1) ? "TODAY" : dayName
        )
    }
}

