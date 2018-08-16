//
//  DateUtils.swift
//
//
//  Created by Wesley Gomes on 23/06/16.
//  Copyright © 2016 Wesley Gomes. All rights reserved.
//

import Foundation

enum DateFormatterEnum: String {
    
    ///yyyy-MM-dd
    case usDate = "yyyy-MM-dd"
    
    ///yyyy-MM-dd HH:mm:ss
    case usDateAndTime = "yyyy-MM-dd HH:mm:ss"
    
    ///dd/MM/yyyy
    case brDateShort = "dd/MM/yyyy"
    
    ///MM/dd/yyyy
    case brDateShortInvertedMonth = "MM/dd/yyyy"
    
    ///dd/MM/yyyy HH:mm:ss
    case brDateTimeShort = "dd/MM/yyyy HH:mm"
    
    ///E, d MMM yyyy
    case brDateExtensive = "E, d MMM yyyy"
    
    ///dd/MM HH:mm //12/17 10:25
    case br_ddMM_HHmm = "dd/MM HH:mm"
    
    ///"2017-05-12T17:33:05.883Z"
    case iso8601 = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
    
    ///12
    case dayNumeric = "dd"
    
    ///05
    case monthNumeric = "MM"
    
    ///2018
    case yearNumeric = "yyyy"
    
    ///Fri, 10:30
    case dayAbbreviatedAndTime = "E, HH:mm"
    
    ///Mon, Tue || Seg, Ter
    case dayAbbreviated = "E"
    
    ///Friday, 10:30
    case dayFullAndTime = "EEEE, HH:mm"
    
    ///Monday, Tuesday
    case dayFull = "EEEE"
    
    ///16:35
    case H24TimeFormat = "HH:mm"
}

class DateUtils {
    
    static func string(from date: Date, formatter: DateFormatterEnum) -> String {
        let tmpFormatter = DateFormatter()
        tmpFormatter.dateFormat = formatter.rawValue
        
        return tmpFormatter.string(from: date)
    }
    
    static func date(from string: String, formatterOfDateString: DateFormatterEnum) -> Date? {
        let tmpFormatter = DateFormatter()
        tmpFormatter.dateFormat = formatterOfDateString.rawValue
        
        return tmpFormatter.date(from: string)
    }
    
}


