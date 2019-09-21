//
//  CouponListViewController.swift
//  STV-Coupon
//
//  Created by devWill on 2019/09/21.
//  Copyright © 2019 devWill. All rights reserved.
//

import UIKit

class CouponListViewController: UIViewController {
    var controller: CouponListController = CouponListController()
    let dataSource: CouponListProvider = CouponListProvider()
    
    var couponDetail = CouponDetailViewController()
    var topSafeAreaHeight: CGFloat = 0
    var isCouponDetailExpanded: Bool = false
    let overlayView = UIView()
    private var couponDetailMargin: CGFloat = -0.1
    
    private let itemsPerRow: CGFloat = 1
    
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var couponListCollectionView: UICollectionView!
    @IBOutlet weak private var noCouponView: UIView!
    @IBOutlet weak private var noCouponLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupCouponDetail()
        
        controller.delegate = self
        controller.fetchCoupons()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        topSafeAreaHeight = self.view.safeAreaInsets.top
    }
}

///Private Method
extension CouponListViewController {
    private func setupView() {
        titleLabel.text = "titleLabelText".localized()
        
        couponListCollectionView.dataSource = dataSource
        couponListCollectionView.delegate = self
        CouponCell.register(collectionView: couponListCollectionView)
        
        noCouponView.isHidden = true
        noCouponLabel.text = "noCouponText".localized()
    }
    
    private func setupCouponDetail() {
        overlayView.backgroundColor = .black
        overlayView.alpha = 0.0
        self.navigationController?.view.addSubview(overlayView)
        
        // menuViewControllerの設定
        let menuStoryboard = UIStoryboard(name: "CouponDetail", bundle: nil)
        couponDetail = menuStoryboard.instantiateViewController(withIdentifier: "CouponDetailViewController") as! CouponDetailViewController
        self.couponDetail.view.frame = CGRect(x: 0, y: self.view.bounds.height, width:self.view.bounds.width, height: UIScreen.main.bounds.height)
        self.view.addSubview(self.couponDetail.view)
        self.couponDetail.delegate = self
        self.couponDetail.didMove(toParent: self)
        
        configureGestures()
    }
    
    // ジェスチャーの設定
    private func configureGestures() {
        let swipeGesture = UIPanGestureRecognizer(target: self, action: #selector(didSwipe(sender:)))
        self.couponDetail.view.addGestureRecognizer(swipeGesture)
    }
    
    // CouponDetailスワイプ時
    @objc private func didSwipe(sender: UIPanGestureRecognizer) {
        let velocity: CGPoint = sender.velocity(in: view)
        let move: CGPoint = sender.translation(in: view)
        let y: CGFloat = 0
        let alpha: CGFloat = 0.5
        
        swipeAnimation(state: sender.state, move: move, velocity: velocity, y: y, alpha: alpha)
    }
    
    private func swipeAnimation(state: UIGestureRecognizer.State, move: CGPoint, velocity: CGPoint, y: CGFloat, alpha: CGFloat) {
        // 移動量を取得する。
        var y: CGFloat = y
        var alpha: CGFloat = alpha
        
        // 画面表示を更新する。
        self.view.layoutIfNeeded()
        
        // 位置の制約に垂直方向の移動量を加算する。
        y += move.y
        alpha -= (move.y / self.view.bounds.height) / 2
        
        if(y < topSafeAreaHeight){
            y = topSafeAreaHeight
            alpha = 0.5
        }
        
        // ドラッグ中の処理
        if state == UIGestureRecognizer.State.changed {
            self.couponDetail.view.frame = CGRect(x: 0, y: y, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            overlayView.alpha = alpha
        }
        
        // ドラッグ終了時の処理
        if state == UIGestureRecognizer.State.ended ||
            state == UIGestureRecognizer.State.cancelled {
            
            if velocity.y > 1000 {
                toggleCoupon()
                return
            }
            if(y - couponDetailMargin > view.frame.size.height * 2 / 5) {
                // ドラッグの距離が画面幅の2/5に満たない場合はビューを画面外に戻す。
                UIView.animate(withDuration: 0.3,animations: {
                    y = UIScreen.main.bounds.height
                    self.couponDetail.view.frame = CGRect(x: 0, y: y, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                    self.overlayView.alpha = 0.0
                    self.isCouponDetailExpanded = false
                },completion:nil)
            } else {
                // ドラッグの距離が画面幅の2/5以上の場合はそのままビューを表示する。
                UIView.animate(withDuration: 0.3,animations: {
                    y = 0.0
                    self.couponDetail.view.frame = CGRect(x: 0, y: y, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                    self.overlayView.alpha = 0.5
                    self.isCouponDetailExpanded = true
                },completion:nil)
            }
            
            couponDetailMargin = -0.1
        }
    }
    
    // クーポン詳細の表示/非表示
    func toggleCoupon() {
        isCouponDetailExpanded = !isCouponDetailExpanded
        let y: CGFloat = (isCouponDetailExpanded) ? 0.0 : UIScreen.main.bounds.height
        
        UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseInOut, animations: {
            self.couponDetail.view.frame = CGRect(x: 0, y: y, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            self.overlayView.alpha = (self.isCouponDetailExpanded) ? 0.5 : 0.0
        }, completion: nil)
    }
}


extension CouponListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        couponDetail.coupon = dataSource.couponList[indexPath.row]
        toggleCoupon()
    }
}

extension CouponListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellSize: CGFloat = collectionView.bounds.width * 0.9
        return CGSize(width: cellSize, height: cellSize * 225 / 300)
    }
}

extension CouponListViewController: CouponListControllerDelegate {
    func deliveredCouponList(couponList: [CouponData]) {
        if couponList.isEmpty {
            noCouponView.isHidden = false
        } else {
            noCouponView.isHidden = true
            dataSource.couponList = couponList
        }
        couponListCollectionView.reloadData()
    }
}

extension CouponListViewController: CouponDetailViewControllerDelegate {
    func tappedCloseButton() {
        toggleCoupon()
    }
    
    func panDown(panGesture: UIPanGestureRecognizer, scrollView: UIScrollView) {
        if couponDetailMargin < 0 {
            couponDetailMargin = scrollView.contentOffset.y
        }
        let velocity: CGPoint = panGesture.velocity(in: scrollView)
        let move: CGPoint = panGesture.translation(in: scrollView)
        let y: CGFloat = -couponDetailMargin
        let alpha: CGFloat = 0.5
        swipeAnimation(state: panGesture.state, move: move, velocity: velocity, y: y, alpha: alpha)
    }
    
    func reloadData() {
        let couponList = controller.getCouponList()
        if couponList.isEmpty {
            noCouponView.isHidden = false
        } else {
            noCouponView.isHidden = true
            dataSource.couponList = couponList
        }
        couponListCollectionView.reloadData()
    }
}
