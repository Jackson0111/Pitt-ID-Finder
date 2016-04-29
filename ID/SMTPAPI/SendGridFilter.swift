//
//  SendGridFilter.swift
//  SMTPAPI
//
//  Created by Scott Kawai on 10/17/15.
//  Copyright © 2015 SendGrid. All rights reserved.
//

import Foundation

public enum SendGridFilter: CustomStringConvertible {
    case BCC
    case BypassListManagement
    case ClickTracking
    case DKIM
    case DomainKeys
    case Footer
    case ForwardSpam
    case GoogleAnalytics
    case Gravatar
    case OpenTracking
    case SpamCheck
    case SubscriptionTracking
    case LegacyTemplates
    case TemplateEngine
    
    public var description: String {
        switch self {
        case BCC:                   return "bcc"
        case BypassListManagement:  return "bypass_list_management"
        case ClickTracking:         return "clicktrack"
        case DKIM:                  return "dkim"
        case DomainKeys:            return "domainkeys"
        case Footer:                return "footer"
        case ForwardSpam:           return "forwardspam"
        case GoogleAnalytics:       return "ganalytics"
        case Gravatar:              return "gravatar"
        case OpenTracking:          return "opentrack"
        case SpamCheck:             return "spamcheck"
        case SubscriptionTracking:  return "subscriptiontrack"
        case LegacyTemplates:       return "template"
        case TemplateEngine:        return "templates"
        }
    }
}