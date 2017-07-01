//
//  CustomAnimationViewController.swift
//  Gemini
//
//  Created by shoheiyokoyama on 2017/07/01.
//  Copyright © 2017年 CocoaPods. All rights reserved.
//

import UIKit
import Gemini

final class CustomAnimationViewController: UIViewController {
    @IBOutlet weak var collectionView: GeminiCollectionView! {
        didSet {
            let nib = UINib(nibName: cellIdentifier, bundle: nil)
            collectionView.register(nib, forCellWithReuseIdentifier: cellIdentifier)
            collectionView.delegate   = self
            collectionView.dataSource = self
            collectionView.gemini
                .customAnimation()
                .translation(y: 50)
                .rotationAngle(y: 10)
//                .ease(.easeOutQuart)
                .shadowEffect(.fadeIn)
                .maxShadowAlpha(0.4)
        }
    }

    fileprivate let cellIdentifier = "MyCollectionViewCell"

    static func make() -> CustomAnimationViewController {
        let storyboard = UIStoryboard(name: "CustomAnimationViewController", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "CustomAnimationViewController") as! CustomAnimationViewController
        return viewController
    }
}

//MARK: - UIScrollViewDelegate
extension CustomAnimationViewController {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        collectionView.adaptGeminiAnimation()
    }
}

//MARK: - UICollectionViewDelegate
extension CustomAnimationViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let cell = cell as? GeminiCell {
            self.collectionView.adaptGeminiAnimation(to: cell)
        }
    }
}

//MARK: - UICollectionViewDataSource
extension CustomAnimationViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! MyCollectionViewCell
        self.collectionView.adaptGeminiAnimation(to: cell)
        return cell
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension CustomAnimationViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width - 100, height: collectionView.bounds.height - 200)
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