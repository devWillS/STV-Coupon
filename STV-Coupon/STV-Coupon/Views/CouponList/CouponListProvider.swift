//
//  CouponListProvider.swift
//  STV-Coupon
//
//  Created by devWill on 2019/09/21.
//  Copyright © 2019 devWill. All rights reserved.
//

import UIKit

final class CouponListProvider: NSObject {
    var couponList = [CouponData]()
}

///UICollectionViewDataSource
extension CouponListProvider: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        couponList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CouponCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.coupon = couponList[indexPath.row]
        return cell
    }
}
