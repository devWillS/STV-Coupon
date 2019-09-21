//
//  Result.swift
//  STV-Coupon
//
//  Created by devWill on 2019/09/21.
//  Copyright © 2019 devWill. All rights reserved.
//

import Foundation

struct CouponResult: Codable {
    var returnCode: String
    var couponCount: Int
    var couponList: [Coupon]
}
