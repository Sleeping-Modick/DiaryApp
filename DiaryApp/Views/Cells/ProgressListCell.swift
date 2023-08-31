//
//  ProgressListCell.swift
//  DiaryApp
//
//  Created by (^ㅗ^)7 iMac on 2023/08/31.
//

import SnapKit
import UIKit

class ProgressListCell: UICollectionViewCell {
    static let identifier = "ProgressListCell"
    
    lazy var imageView = CustomImageView(frame: .zero)
    lazy var weatherImageView = CustomImageView(frame: .zero)
    lazy var descriptionLabel = CustomLabel(frame: .zero)
    
    private let collectionView = CustomCollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    private let collectionViewFlowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 50, height: 20)
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 2
        layout.estimatedItemSize = .zero
        return layout
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCell()
        setupLayout()
        configureCollectionView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureCell() {
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 20
        imageView.backgroundColor = .systemBrown
        
        descriptionLabel.backgroundColor = .white
        descriptionLabel.font = .systemFont(ofSize: 15, weight: .regular)
        descriptionLabel.numberOfLines = 3
        descriptionLabel.textAlignment = .left
        descriptionLabel.adjustsFontSizeToFitWidth = false
        
        weatherImageView.contentMode = .scaleAspectFit
        weatherImageView.layer.cornerRadius = weatherImageView.bounds.size.width / 2
        weatherImageView.backgroundColor = .purple
    }
    
    private func setupLayout() {
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.top.leading.bottom.equalTo(contentView)
            make.width.equalTo(imageView.snp.height)
        }
        
        contentView.addSubview(weatherImageView)
        weatherImageView.snp.makeConstraints { make in
            make.leading.equalTo(imageView.snp.trailing).offset(10)
            make.top.equalTo(contentView).inset(5)
            make.width.height.equalTo(30)
        }
        
        contentView.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { make in
            make.leading.equalTo(imageView.snp.trailing).offset(10)
            make.trailing.equalTo(contentView).inset(10)
            make.top.equalTo(weatherImageView.snp.bottom).offset(5)
            make.bottom.equalTo(contentView).inset(10)
        }
        
        contentView.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(contentView).inset(5)
            make.trailing.equalTo(contentView).inset(10)
            make.bottom.equalTo(descriptionLabel.snp.top).offset(5)
            make.leading.equalTo(weatherImageView.snp.trailing).offset(5)
        }
    }
    
    private func configureCollectionView() {
        collectionView.register(ProgressTagCell.self, forCellWithReuseIdentifier: ProgressTagCell.identifier)
        collectionView.dataSource = self

        collectionView.isScrollEnabled = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = true
        collectionView.backgroundColor = .clear
        collectionView.clipsToBounds = true
        collectionView.isPagingEnabled = false
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.contentInset = UIEdgeInsets(top: 5, left: 5, bottom: 15, right: 5)
        collectionView.decelerationRate = .fast

        collectionView.collectionViewLayout = collectionViewFlowLayout
    }
}

extension ProgressListCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProgressTagCell.identifier, for: indexPath) as? ProgressTagCell else { return UICollectionViewCell() }
        cell.tagTitleLabel.text = "Hi"
        cell.backgroundColor = .systemYellow
        cell.layer.cornerRadius = 5
        return cell
    }
}
