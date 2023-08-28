//
//  CustomCollectionView.swift
//  CollectionWithoutSB
//
//  Created by (^ㅗ^)7 iMac on 2023/08/23.
//

import UIKit

final class CustomCollectionView: UICollectionView {
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        self.translatesAutoresizingMaskIntoConstraints = false
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
