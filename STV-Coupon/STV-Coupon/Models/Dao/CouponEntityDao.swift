//
//  CouponEntityDao.swift
//  STV-Coupon
//
//  Created by devWill on 2019/09/21.
//  Copyright © 2019 devWill. All rights reserved.
//

import UIKit
import RealmSwift

final class CouponEntityDao {
    
    static let dao = RealmDaoHelper<CouponEntity>()
    
    static func add(objects: [Coupon]) {
        let keys = objects.map { $0.couponID }
        
        // すでに保存されているRealmモデルを取得して、そのprimaryKeyのSetを得る
        let storedKeys = Set(
            dao.findAll().filter("couponID IN %@", keys).map { $0.couponID })
        
        // すでに保存されているRealmモデルのprimaryKeyに一致しないオブジェクトを選択する
        let newObjects = objects.filter { !storedKeys.contains($0.couponID) }
        
        var couponList = [CouponEntity]()
        
        for object in newObjects {
            let coupon = CouponEntity(coupon: object)
            couponList.append(coupon)
        }
        
        dao.add(objects: couponList)
    }
    
    static func add(object: Coupon) {
        
        let coupon = CouponEntity(coupon: object)
        
        dao.add(object: coupon)
    }
    
    static func update(object: CouponData) {
        
        dao.update(object: CouponEntity( coupon: object))
    }
    
    static func deleteAll() {
        dao.deleteAll()
    }
    
    static func findByID(couponID: Int) -> CouponData? {
        guard let object = dao.findFirst(key: couponID as AnyObject) else {
            return nil
        }
        return CouponData(coupon: object)
    }
    
    static func findAll() -> [CouponData] {
        
        var couponList = [CouponData]()
        let sortProperties = [
            SortDescriptor(keyPath: "fromExpire", ascending: true),
            SortDescriptor(keyPath: "priceDown", ascending: true)
        ]
        let coupons = dao.findAll().sorted(by: sortProperties)
        
        for object in coupons {
            let coupon = CouponData(coupon: object)
            couponList.append(coupon)
        }
        return couponList
    }
}
