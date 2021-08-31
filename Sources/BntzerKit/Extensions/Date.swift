//
//  Date+Deltas.swift
//  GruClient
//
//  Created by Steve Bentz on 7/10/20.
//  Copyright © 2020 Chatbooks. All rights reserved.
//

import Foundation

extension Date {
    /// Returns the amount of years from another date
    func years(from date: Date) -> Int {
        return Calendar.current.dateComponents([.year], from: date, to: self).year ?? 0
    }
    /// Returns the amount of months from another date
    func months(from date: Date) -> Int {
        return Calendar.current.dateComponents([.month], from: date, to: self).month ?? 0
    }
    /// Returns the amount of weeks from another date
    func weeks(from date: Date) -> Int {
        return Calendar.current.dateComponents([.weekOfMonth], from: date, to: self).weekOfMonth ?? 0
    }
    /// Returns the amount of days from another date
    func days(from date: Date) -> Int {
        return Calendar.current.dateComponents([.day], from: date, to: self).day ?? 0
    }
    /// Returns the amount of hours from another date
    func hours(from date: Date) -> Int {
        return Calendar.current.dateComponents([.hour], from: date, to: self).hour ?? 0
    }
    /// Returns the amount of minutes from another date
    func minutes(from date: Date) -> Int {
        return Calendar.current.dateComponents([.minute], from: date, to: self).minute ?? 0
    }
    /// Returns the amount of seconds from another date
    func seconds(from date: Date) -> Int {
        return Calendar.current.dateComponents([.second], from: date, to: self).second ?? 0
    }
    /// Returns the a custom time interval description from another date
    func offset(from date: Date) -> String {
        if years(from: date)   > 0 { return "\(years(from: date)) years"   }
        if months(from: date)  > 0 { return "\(months(from: date)) months"  }
        if weeks(from: date)   > 0 { return "\(weeks(from: date)) weeks"   }
        if days(from: date)    > 0 { return "\(days(from: date)) days"    }
        return ""
    }
}

extension Date {
    var shortDate: String {
        get {
            let df = DateFormatter()
            df.dateFormat = "MM/dd/yyyy"
            return df.string(from: self)
        }
    }
    
    var weekDay: String {
        
        get {
            
            switch Calendar.current.component(.weekday, from: self) {
            case 1:
                return "Monday"
            case 2:
                return "Tuesday"
            case 3:
                return "Wednesday"
            case 4:
                return "Thursday"
            case 5:
                return "Friday"
            case 6:
                return "Saturday"
            case 7:
                return "Sunday"
            default:
                return ""
            }
            
        }
        
    }
}

extension Date {
    var monthYear : Date? {
        get {
            let month = Calendar.current.component(.month, from: self)
            let year = Calendar.current.component(.year, from: self)
            
            var dateComponent = DateComponents()
            dateComponent.month = month
            dateComponent.year = year
            
            return Calendar.current.date(from: dateComponent)
        }
    }
    
    var weekYear : Date? {
        get {
            let week = Calendar.current.component(.weekOfYear, from: self)
            let year = Calendar.current.component(.year, from: self)
            
            var dateComponent = DateComponents()
            dateComponent.weekOfYear = week
            dateComponent.year = year
            
            return Calendar.current.date(from: dateComponent)
        }
    }
}
