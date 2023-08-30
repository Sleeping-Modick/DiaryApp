//
//  HomeFeedCell.swift
//  DiaryApp
//
//  Created by (^ㅗ^)7 iMac on 2023/08/28.
//

import UIKit

final class HomeFeedCell: UICollectionViewCell {
    static let identifier = "HomeFeedCell"

    private let myView = CustomImageView(frame: .zero)
    private let weatherImage = CustomImageView(frame: .zero)

    let sizeWidth = 70.0

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.contentView.addSubview(self.myView)

        self.weatherImage.backgroundColor = .systemBlue
        self.weatherImage.layer.cornerRadius = CGFloat(self.sizeWidth / 2)

        self.myView.addSubview(self.weatherImage)

        NSLayoutConstraint.activate([
            self.myView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor),
            self.myView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor),
            self.myView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            self.myView.topAnchor.constraint(equalTo: self.contentView.topAnchor),

            self.weatherImage.trailingAnchor.constraint(equalTo: self.myView.trailingAnchor, constant: -30),
            self.weatherImage.bottomAnchor.constraint(equalTo: self.myView.bottomAnchor, constant: -30),
            self.weatherImage.heightAnchor.constraint(equalToConstant: self.sizeWidth),
            self.weatherImage.widthAnchor.constraint(equalToConstant: self.sizeWidth),
        ])
    }
}
