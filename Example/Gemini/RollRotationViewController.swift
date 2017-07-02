//
//  RollRotationViewController.swift
//  Gemini
//
//  Created by shoheiyokoyama on 2017/06/25.
//  Copyright © 2017年 CocoaPods. All rights reserved.
//

import UIKit
import Gemini

final class RollRotationViewController: UIViewController {

    @IBOutlet fileprivate weak var collectionView: GeminiCollectionView! {
        didSet {
            let nib = UINib(nibName: cellIdentifier, bundle: nil)
            collectionView.register(nib, forCellWithReuseIdentifier: cellIdentifier)
            collectionView.delegate   = self
            collectionView.dataSource = self
            collectionView.gemini
                .rollRotationAnimation()
                .rollEffect(rotationEffect)
                .scale(0.7)
        }
    }

    fileprivate let cellIdentifier = "MyCollectionViewCell"
    private(set) var rotationEffect: GeminiRollRotationEffect = .rollUp
    private(set) var scrollDirection: UICollectionViewScrollDirection = .horizontal

    static func make(with scrollDirection: UICollectionViewScrollDirection, effect: GeminiRollRotationEffect) -> RollRotationViewController {
        let storyboard = UIStoryboard(name: "RollRotationViewController", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "RollRotationViewController") as! RollRotationViewController
        viewController.rotationEffect = effect
        viewController.scrollDirection = scrollDirection
        return viewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = scrollDirection
            collectionView.collectionViewLayout = layout
        }
    }
}

//MARK: - UIScrollViewDelegate
extension RollRotationViewController {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        collectionView.animateVisibleCells()
    }
}

//MARK: - UICollectionViewDelegate
extension RollRotationViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let cell = cell as? GeminiCell {
            self.collectionView.animateCell(cell)
        }
    }
}

//MARK: - UICollectionViewDataSource
extension RollRotationViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! MyCollectionViewCell
        self.collectionView.animateCell(cell)
        return cell
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension RollRotationViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width - 30, height: collectionView.bounds.height - 30)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
