//
//  Coupon.swift
//  STV-Coupon
//
//  Created by devWill on 2019/09/21.
//  Copyright © 2019 devWill. All rights reserved.
//

import Foundation

struct Coupon: Codable {
    var couponID: String
    var priceDown: Int
    var fromExpire: String
    var toExpire: String
}
