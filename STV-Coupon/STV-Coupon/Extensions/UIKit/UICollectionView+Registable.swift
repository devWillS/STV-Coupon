//
//  UICollectionView+Registable.swift
//  STV-Coupon
//
//  Created by devWill on 2019/09/21.
//  Copyright © 2019 devWill. All rights reserved.
//

import UIKit
protocol CollectionViewNibRegistrable where Self: UICollectionViewCell {
    
    /// CollectionViewにNibを登録する
    ///
    /// - Parameter collectionView: 登録先のCollectionView
    static func register(collectionView: UICollectionView)
}

extension CollectionViewNibRegistrable {
    
    static func register(collectionView: UICollectionView) {
        let nib = UINib(nibName: identifier, bundle: Bundle(for: self))
        collectionView.register(nib, forCellWithReuseIdentifier: identifier)
    }
}
