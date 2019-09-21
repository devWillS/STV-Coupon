//
//  DateFormatter.swift
//  STV-Coupon
//
//  Created by devWill on 2019/09/21.
//  Copyright © 2019 devWill. All rights reserved.
//

import Foundation

enum DateFormater: String {
    case year = "yyyy"
    case month = "MM"
    case day = "d"
    case hour = "HH"
    case min = "mm"
    case sec = "ss"
    case dayOfWeek = "EEE"
    
    case yearDay = "yyyyMMdd"
    
    case yearToMonth = "yyyy年MM月"
    case yearToDay = "yyyy年MM月dd日"
    case yearToMin = "yyyy年MM月dd日 HH:mm"
    case yearToSec = "yyyy年MM月dd日 HH:mm:ss"
    case yearToDayOfWeek = "yyyy年MM月dd日 (EEE)"

    case hypenYearToDay = "yyyy-MM-dd"
    case hypenYearToMin = "yyyy-MM-dd HH:mm"
    case hypenYearToSec = "yyyy-MM-dd HH:mm:ss"
    
    case slashYearToDay = "yyyy/MM/dd"
    case slashYearToMin = "yyyy/MM/dd HH:mm"
    case slashYearToSec = "yyyy/MM/dd HH:mm:ss"
    case monthToDayToWeekDay = "MMMd日 (E)"
    case monthToDay = "MM月dd日"
    case monthToSec = "MM月dd日 HH:mm:ss"
    
    case hourToMin = "HH:mm"
    case hourToSec = "HH:mm:ss"
    case hourToDayOfWeek = "HH:mm:ss EEE"
}
