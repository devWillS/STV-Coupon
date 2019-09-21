//
//  UICollectionView+DequeueReusable.swift
//  STV-Coupon
//
//  Created by devWill on 2019/09/21.
//  Copyright © 2019 devWill. All rights reserved.
//

import UIKit

extension UICollectionView {
    
    func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
        return dequeueReusableCell(withReuseIdentifier: T.identifier, for: indexPath) as! T
    }
    
    func dequeueReusableHeader<T: UICollectionReusableView>(for indexPath: IndexPath) -> T {
        return dequeueReusableSupplementaryView(
            ofKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: T.identifier,
            for: indexPath) as! T
    }
}
