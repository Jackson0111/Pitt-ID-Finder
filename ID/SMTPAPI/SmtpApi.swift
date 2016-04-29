//
//  SmtpApi.swift
//  SMTPAPI-Swift
//
//  Created by Scott Kawai on 10/23/14.
//  Copyright (c) 2014 SendGrid. All rights reserved.
//

import Foundation

public class SmtpApi {
    
    // MARK: PROPERTIES
    //=========================================================================
    public var to: [String]?
    public var sub: [String:[String]]?
    public var section: [String:String]?
    public var category: [String]?
    public var unique_args: [String:String]?
    public var filters: [String:AnyObject]?
    public var send_at: Int?
    public var send_each_at: [Int]?
    public var asm_group_id: Int?
    public var ip_pool: String?
    
    // MARK: COMPUTED PROPERTIES
    //=========================================================================
    public var dictionaryValue: [String:AnyObject] {
        var dictionary: [String:AnyObject] = [:]
        
        if let tos = self.to {
            dictionary["to"] = tos
        }
        
        if let subs = self.sub {
            dictionary["sub"] = subs
        }
        
        if let sections = self.section {
            dictionary["section"] = sections
        }
        
        if let args = self.unique_args {
            dictionary["unique_args"] = args
        }
        
        if let categories = self.category {
            dictionary["category"] = categories
        }
        
        if let filters = self.filters {
            dictionary["filters"] = filters
        }
        
        if let sendAt = self.send_at {
            dictionary["send_at"] = sendAt
        }
        
        if let sendEachAt = self.send_each_at {
            dictionary["send_each_at"] = sendEachAt
        }
        
        if let asm = self.asm_group_id {
            dictionary["asm_group_id"] = asm
        }
        
        if let ip_pool = self.ip_pool {
            dictionary["ip_pool"] = ip_pool
        }
        
        return dictionary
    }
    
    public var jsonValue: String {
        do {
            let json = try NSJSONSerialization.dataWithJSONObject(self.dictionaryValue, options: [])
            if let str = NSString(data: json, encoding: NSUTF8StringEncoding) {
                return str as String
            }
        } catch {
            Logger.error("SmtpApi jsonValue: Error converting to JSON string.")
        }
        return "{}"
    }
    
    var hasSmtpApi: Bool {
        return self.dictionaryValue.count > 0
    }
    
    
    // MARK: INITIALIZATION
    //=========================================================================
    public init() {}
    
    
    // MARK: FUNCTIONS
    //=========================================================================
    
    /* addTo(_:name:)
    *
    * SUMMARY
    * Appends an email address to the `to` property. Allows an optional to name
    * to be specified.
    *
    * PARAMETERS
    * address       A string of the email address to add.
    * name          An optional string of the recipient's name.
    *
    * RETURNS
    * Nothing.
    *
    *=========================================================================*/
    
    public func addTo(address: String, name: String?) throws {
        var names: [String]?
        if let n = name {
            names = [n]
        }
        try self.addTos([address], names: names)
    }
    
    /* addTos(_:names:)
    *
    * SUMMARY
    * Appends an array of email addresses to the `to` property. Allows an
    * optional array of to names to be specified.
    *
    * PARAMETERS
    * addresses     An array of strings representing the email addresses to add.
    * names         An optional array of strings representing the names of the
    *               recipients.
    *
    * RETURNS
    * Nothing.
    *
    *=========================================================================*/
    
    public func addTos(addresses: [String], names: [String]?) throws {
        if self.to == nil {
            self.to = []
        }
        
        if (self.to!).count + addresses.count > 10000 {
            throw SmtpApiErrors.TooManyRecipients
        }
        
        if let toNames = names {
            if addresses.count == toNames.count {
                for (index, name) in toNames.enumerate() {
                    let email = addresses[index]
                    self.to!.append("\(name) <\(email)>")
                }
            } else {
                throw SmtpApiErrors.NumberOfRecipientNamesMismatch
            }
        } else {
            self.to! += addresses
        }
    }
    
    /* setTos(_:names:)
    *
    * SUMMARY
    * Resets the `to` property to the passed array of email addresses. Allows
    * an optional array of to names to be specified.
    *
    * PARAMETERS
    * addresses     An array of strings representing the email addresses to
    *               reset the `to` property to.
    * names         An optional array of strings representing the names of the
    *               recipients.
    *
    * RETURNS
    * Nothing.
    *
    *=========================================================================*/
    
    public func setTos(addresses: [String], names: [String]?) throws {
        self.to = []
        try self.addTos(addresses, names: names)
    }
    
    /* addSubstitution(_:values:)
    *
    * SUMMARY
    * Adds the array of values for the given key to the `sub` property.
    *
    * PARAMETERS
    * key       A string of the substitution tag.
    * values    An array of strings representing the substitution values.
    *
    * RETURNS
    * Nothing.
    *
    *=========================================================================*/
    
    public func addSubstitution(key: String, values: [String]) {
        if self.sub == nil {
            self.sub = [:]
        }
        
        self.sub![key] = values
    }
    
    /* addSection(_:value:)
    *
    * SUMMARY
    * Adds a section tag and value.
    *
    * PARAMETERS
    * key       A string representing th key to be replaced.
    * value     A string representing the value to replace the key with.
    *
    * RETURNS
    * Nothing.
    *
    *=========================================================================*/
    
    public func addSection(key: String, value: String) {
        if self.section == nil {
            self.section = [:]
        }
        
        self.section![key] = value
    }
    
    /* addUniqueArgument(_:value:)
    *
    * SUMMARY
    * Adds a key-value pair to the unique arguments.
    *
    * PARAMETERS
    * key       A string for the unique argument key.
    * value     A string for the unique arugment value.
    *
    * RETURNS
    * Nothing.
    *
    *=========================================================================*/
    
    public func addUniqueArgument(key: String, value: String) {
        if self.unique_args == nil {
            self.unique_args = [:]
        }
        
        self.unique_args![key] = value
    }
    
    /* addCategory(_:)
    *
    * SUMMARY
    * Adds a category to the category array.
    *
    * PARAMETERS
    * category      A string representing the category to add.
    *
    * RETURNS
    * Nothing.
    *
    *=========================================================================*/
    
    public func addCategory(category: String) throws {
        try self.addCategories([category])
    }
    
    /* addCategories(_:)
    *
    * SUMMARY
    * Appends an array of categories to the category property.
    *
    * PARAMETERS
    * categories    An array of categories to add.
    *
    * RETURNS
    * Nothing.
    *
    *=========================================================================*/
    
    public func addCategories(categories: [String]) throws {
        if self.category == nil {
            self.category = []
        }
        
        if self.category!.count + categories.count > 10 {
            throw SmtpApiErrors.TooManyCategories
        }
        
        self.category! += categories
    }
    
    /* addFilter(_:setting:value:)
    *
    * SUMMARY
    * Adds a value for a given setting for a given filter (app).
    *
    * PARAMETERS
    * filter    The filter to modify. Uses the SendGridFilter enum.
    * setting   The name of the setting
    * value     The value to set for the given setting.
    *
    * RETURNS
    * Nothing.
    *
    *=========================================================================*/
    
    public func addFilter(filter: SendGridFilter, setting: String, value: Any) throws {
        if self.filters == nil {
            self.filters = [:]
        }
        
        if let apps = self.filters {
            var settings = [String:AnyObject]()
            if let app = apps[filter.description] as? [String:AnyObject] {
                if let s = app["settings"] as? [String:AnyObject] {
                    settings = s
                }
            }
            
            if let val = value as? Int {
                settings[setting] = NSNumber(integer: val)
            } else if let val = value as? String {
                settings[setting] = val
            } else {
                throw SmtpApiErrors.InvalidFilterValueType
            }
            
            let app: [String:AnyObject] = ["settings":settings]
            self.filters?[filter.description] = app
        }
        
    }
    
    /* setSendAt(_:)
    *
    * SUMMARY
    * Sets the send_at property, which specifies a time to send the email at.
    *
    * PARAMETERS
    * date      An NSDate object representing when to send the message.
    *
    * RETURNS
    * Nothing.
    *
    *=========================================================================*/
    
    public func setSendAt(date: NSDate) throws {
        try self.verifyScheduleDate(date)
        
        self.send_at = Int(date.timeIntervalSince1970)
    }
    
    /* setSendEachAt(_:)
    *
    * SUMMARY
    * Sets a date to send each individual copy at (for each recipient).
    *
    * PARAMETERS
    * dates     An Array of NSDate objects indicating when to send the message.
    *
    * RETURNS
    * Nothing.
    *
    *=========================================================================*/
    
    public func setSendEachAt(dates: [NSDate]) throws {
        if self.send_each_at == nil {
            self.send_each_at = []
        }
        
        for date in dates {
            try self.verifyScheduleDate(date)
            self.send_each_at?.append(Int(date.timeIntervalSince1970))
        }
    }
    
    /* setAsmGroup(_:)
    *
    * SUMMARY
    * Assigns the email an Advanced Suppression Management group.
    *
    * PARAMETERS
    * id    The ID of the ASM group.
    *
    * RETURNS
    * Nothing.
    *
    *=========================================================================*/
    
    public func setAsmGroup(id: Int) {
        self.asm_group_id = id
    }
    
    /* setIpPool(_:)
    *
    * SUMMARY
    * Specifies the IP Pool to send a message over.
    *
    * PARAMETERS
    * pool      A string indicating the name of the pool to send over.
    *
    * RETURNS
    * Nothing.
    *
    *=========================================================================*/
    
    public func setIpPool(pool: String) {
        self.ip_pool = pool
    }
    
    
    // MARK: CONVENIENCE FUNCTIONS
    //=========================================================================
    
    /* verifyScheduleDate(_:)
    *
    * SUMMARY
    * Verifies that the NSDate being used for scheduling is in the valid time
    * frame.
    *
    * PARAMETERS
    * date      An NSDate object representing when to send a message.
    *
    *=========================================================================*/
    
    func verifyScheduleDate(date: NSDate) throws {
        if date.timeIntervalSinceNow <= 0 {
            throw SmtpApiErrors.ScheduledDateInPast(date)
        } else if date.timeIntervalSinceNow > (72 * 60 * 60) {
            throw SmtpApiErrors.ScheduledDateTooDistant(date)
        }
    }
    
}