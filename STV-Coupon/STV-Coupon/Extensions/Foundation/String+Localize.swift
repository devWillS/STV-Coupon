//
//  String+Localize.swift
//  STV-Coupon
//
//  Created by devWill on 2019/09/21.
//  Copyright © 2019 devWill. All rights reserved.
//

import Foundation

extension String {
    
    func localized() -> String {
        return NSLocalizedString(self, comment: "")
    }
    
    func localized(parameter: Int) -> String {
        return String(format: NSLocalizedString(self, comment: ""), parameter)
    }
    
    func localized(parameter: String) -> String {
        return String(format: NSLocalizedString(self, comment: ""), parameter)
    }
}
