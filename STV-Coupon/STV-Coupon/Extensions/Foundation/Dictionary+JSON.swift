//
//  Dictionary+JSON.swift
//  STV-Coupon
//
//  Created by devWill on 2019/09/21.
//  Copyright © 2019 devWill. All rights reserved.
//

import Foundation

extension Dictionary {
    
    var prettyPrintedJsonString: String {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: self, options: [.prettyPrinted])
            return String(bytes: jsonData, encoding: .utf8) ?? "JSON Covert Failre."
        } catch {
            return "JSON Covert Failre."
        }
    }
}
