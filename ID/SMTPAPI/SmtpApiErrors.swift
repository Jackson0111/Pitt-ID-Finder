//
//  SmtpApiErrors.swift
//  SMTPAPI
//
//  Created by Scott Kawai on 10/17/15.
//  Copyright © 2015 SendGrid. All rights reserved.
//

import Foundation

public enum SmtpApiErrors: ErrorType, CustomStringConvertible {
    case TooManyRecipients
    case NumberOfRecipientNamesMismatch
    case TooManyCategories
    case InvalidFilterValueType
    case ScheduledDateTooDistant(NSDate)
    case ScheduledDateInPast(NSDate)
    
    public var description: String {
        func getTimes(date: NSDate) -> (scheduled: String, current: String) {
            let formatter = NSDateFormatter()
            formatter.dateStyle = NSDateFormatterStyle.LongStyle
            let time = NSDateFormatter()
            time.timeStyle = NSDateFormatterStyle.LongStyle
            
            let now = NSDate()
            
            let scheduled = "\(formatter.stringFromDate(date)) at \(time.stringFromDate(date))"
            let current = "\(formatter.stringFromDate(now)) at \(time.stringFromDate(now))"
            
            return (scheduled: scheduled, current: current)
        }
        
        switch self {
        case .TooManyRecipients:
            return "You've added more than 10,000 recipients, which is the maximum number of allowed recipients for the X-SMTPAPI header."
        case .NumberOfRecipientNamesMismatch:
            return "The number of recipient names provided doesn't match the number of recipient email addresses."
        case .TooManyCategories:
            return "You've added more than 10 categories, which is the maximum number of allowed categories for the X-SMTPAPI header."
        case .InvalidFilterValueType:
            return "Only Strings and Ints are allowed when specifying values for filter settings."
        case .ScheduledDateTooDistant(let date):
            let times = getTimes(date)
            return "SmtpApi setSendAt: Date \"\(times.scheduled)\" was set to unsupported time (further than 24 hours in the future - currently it is \(times.current)). See https://sendgrid.com/docs/API_Reference/SMTP_API/scheduling_parameters.html for more details."
        case .ScheduledDateInPast(let date):
            let times = getTimes(date)
            return "SmtpApi setSendAt: Date \"\(times.scheduled)\" was set to a time in the past (currently it is \(times.current))"
        }
    }
}