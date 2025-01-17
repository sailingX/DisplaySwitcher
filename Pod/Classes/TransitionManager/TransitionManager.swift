//
//  TransitionManager.swift
//  YALLayoutTransitioning
//
//  Created by Roman on 23.02.16.
//  Copyright © 2016 Yalantis. All rights reserved.
//

import UIKit

private let finishTransitionValue = 1.0

@objc open class TransitionManager: NSObject {
    
    fileprivate let duration: TimeInterval
    fileprivate let collectionView: UICollectionView
    fileprivate let destinationLayout: UICollectionViewLayout
    fileprivate let layoutState: LayoutState
    fileprivate var transitionLayout: TransitionLayout!
    fileprivate var updater: CADisplayLink!
    fileprivate var startTime: TimeInterval!
    
    public init(
        duration: TimeInterval,
        collectionView: UICollectionView,
        destinationLayout: UICollectionViewLayout,
        layoutState: LayoutState
    ) {
        self.collectionView = collectionView
        self.destinationLayout = destinationLayout
        self.layoutState = layoutState
        self.duration = duration
    }
    
    open func startInteractiveTransition() {
        collectionView.isUserInteractionEnabled = true
        transitionLayout = collectionView.startInteractiveTransition(to: destinationLayout) { success, finish in
            if success && finish {
                self.collectionView.reloadData()
                self.collectionView.isUserInteractionEnabled = false
            }
            } as? TransitionLayout
        transitionLayout.layoutState = layoutState
        createUpdaterAndStart()
    }
    
}

fileprivate extension TransitionManager {
    
    func createUpdaterAndStart() {
        startTime = CACurrentMediaTime()
        updater = CADisplayLink(target: self, selector: #selector(updateTransitionProgress))
        updater.preferredFramesPerSecond = 1
        updater.add(to: .current, forMode: .common)
    }
    
    @objc func updateTransitionProgress() {
        var progress = (updater.timestamp - startTime) / duration
        progress = min(1, progress)
        progress = max(0, progress)
        transitionLayout.transitionProgress = CGFloat(progress)
        
        transitionLayout.invalidateLayout()
        if progress == finishTransitionValue {
            collectionView.finishInteractiveTransition()
            updater.invalidate()
        }
    }
    
}
