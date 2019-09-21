//
//  String+toDate.swift
//  STV-Coupon
//
//  Created by devWill on 2019/09/21.
//  Copyright © 2019 devWill. All rights reserved.
//

import Foundation

extension String {
    
    func toDate(_ dateFormat: DateFormater) -> Date?  {
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "ja_JP") as Locale?
        dateFormatter.timeStyle = .short
        dateFormatter.dateStyle = .short
        dateFormatter.dateFormat = dateFormat.rawValue
        
        return dateFormatter.date(from: self)
    }
}
