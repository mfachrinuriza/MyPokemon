//
//  FittedCollectionView.swift
//  core
//
//  Created by Muhammad Fachri Nuriza on 15/02/24.
//

import UIKit

public class FittedCollectionView: UICollectionView {
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    private func commonInit() {
        isScrollEnabled = false
    }

    public override var contentSize: CGSize {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }

    public override func reloadData() {
        super.reloadData()
        self.invalidateIntrinsicContentSize()
    }

    public override var intrinsicContentSize: CGSize {
        return contentSize
    }
}
