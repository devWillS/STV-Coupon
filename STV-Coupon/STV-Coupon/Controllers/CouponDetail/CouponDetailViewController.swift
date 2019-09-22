//
//  CouponDetailViewController.swift
//  STV-Coupon
//
//  Created by devWill on 2019/09/21.
//  Copyright © 2019 devWill. All rights reserved.
//

import UIKit

protocol CouponDetailViewControllerDelegate: class {
    func tappedCloseButton()
    func panDown(panGesture: UIPanGestureRecognizer, scrollView: UIScrollView)
    func reloadData()
}

class CouponDetailViewController: UIViewController {
    var delegate: CouponDetailViewControllerDelegate?
    var coupon = CouponData() {
        didSet {
            setCoupon()
        }
    }
    
    private var isDescriptionViewHidden = true {
        didSet {
            textGroupView.isHidden = isDescriptionViewHidden
            dontUseNowView.isHidden = isDescriptionViewHidden
            
            if isDescriptionViewHidden {
                descriptionView.backgroundColor = R.color.themeTransculed()
            } else {
                if #available(iOS 13.0, *) {
                    descriptionView.backgroundColor = .systemBackground
                } else {
                    descriptionView.backgroundColor = .white
                }
            }
        }
    }
    
    @IBOutlet weak private var coupontTilteLabel: UILabel!
    @IBOutlet weak private var expiredTitleLabel: UILabel!
    @IBOutlet weak private var expiredLabel: UILabel!
    @IBOutlet weak private var descriptionView: UIView!
    @IBOutlet weak private var textGroupView: UIView!
    @IBOutlet weak private var confirmTitleLabel: UILabel!
    @IBOutlet weak private var confirmMessageLabel: UILabel!
    @IBOutlet weak private var confirmDescriptionLabel: UILabel!
    @IBOutlet weak private var useView: UIView!
    @IBOutlet weak private var useButton: UIButton!
    @IBOutlet weak private var dontUseNowView: UIView!
    @IBOutlet weak private var dontUseNowButton: UIButton!
    @IBOutlet weak private var descriptionLabel: UILabel!
    
    
    
    @IBAction func didTapCloseButton(_ sender: UIButton) {
        delegate?.tappedCloseButton()
    }
    @IBAction func tappedUseButton(_ sender: UIButton) {
        if isDescriptionViewHidden {
            isDescriptionViewHidden = false
        } else {
            useCoupon()
        }
    }
    @IBAction func tappedDontUseNowButton(_ sender: UIButton) {
        isDescriptionViewHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
}

///Private Method
extension CouponDetailViewController {
    private func setupView() {
        
        descriptionView.layer.cornerRadius = 25
        descriptionView.layer.masksToBounds = true
        
        confirmMessageLabel.layer.borderColor = UIColor.red.cgColor
        confirmMessageLabel.layer.borderWidth = 1
        confirmMessageLabel.layer.cornerRadius = 10
        
        confirmTitleLabel.text = R.string.localizable.confirmTitleLabelText()
        confirmMessageLabel.text = R.string.localizable.confirmMessageLabelText()
        confirmDescriptionLabel.text = R.string.localizable.confirmDescriptionLabelText()
        
        
        useButton.layer.cornerRadius = 10
        useButton.setTitle(R.string.localizable.useButtonText(), for: .normal)
        dontUseNowButton.setTitle(R.string.localizable.dontUseNowButtonText(), for: .normal)
        
        descriptionLabel.text = R.string.localizable.descriptionLabelText()
        
        isDescriptionViewHidden = true
    }
    
    private func useCoupon() {
        coupon.used = Date().toString(.slashYearToSec)
        CouponEntityDao.update(object: coupon)
        setCoupon()
        delegate?.reloadData()
    }
    
    private func setCoupon() {
        isDescriptionViewHidden = true
        coupontTilteLabel.text = R.string.localizable.priceDownText(coupon.priceDown.commaSeparated())
        
        if coupon.used.isEmpty {
            descriptionView.isHidden = false
            
            expiredTitleLabel.textAlignment = .left
            expiredTitleLabel.text = R.string.localizable.expiredTitleText()
            expiredTitleLabel.font = UIFont.systemFont(ofSize: expiredTitleLabel.font.pointSize)
            
            expiredLabel.text = coupon.getExpiredDateString()
            expiredLabel.font = UIFont.boldSystemFont(ofSize: expiredTitleLabel.font.pointSize)

        } else {
            descriptionView.isHidden = true
            
            expiredTitleLabel.textAlignment = .center
            expiredTitleLabel.text = R.string.localizable.expiredTitleUsedText()
            expiredTitleLabel.font = UIFont.boldSystemFont(ofSize: expiredTitleLabel.font.pointSize)
            
            expiredLabel.text = coupon.used
            expiredLabel.font = UIFont.systemFont(ofSize: expiredTitleLabel.font.pointSize)
        }
    }
}
