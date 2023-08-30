//
//  DiaryListCell.swift
//  DiaryApp
//
//  Created by (^ㅗ^)7 iMac on 2023/08/29.
//

import SnapKit
import UIKit

class DiaryListCell: UICollectionViewCell {
    static let identifier = "DiaryListCell"

    let collectionView = CustomCollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    private let collectionViewFlowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 40, height: 40)
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 2
        layout.estimatedItemSize = .zero
        return layout
    }()

    private let stackView = CustomStackView(frame: .zero)
    private let labelStackView = CustomStackView(frame: .zero)

    lazy var diaryTitleLabel = CustomLabel(frame: .zero)
    lazy var startDayLabel = CustomLabel(frame: .zero)
    lazy var endDayLabel = CustomLabel(frame: .zero)
    private let spaceLabel = CustomLabel(frame: .zero)

    lazy var progressView: UIProgressView = {
        let view = UIProgressView()
        view.translatesAutoresizingMaskIntoConstraints = false
        /// progress 배경 색상
        view.trackTintColor = .lightGray
        /// progress 진행 색상
        view.progressTintColor = .systemBlue
        view.progress = 0.5
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupLayout()
        configureCollectionView()
    }

    private func setupUI() {
        stackView.axis = .vertical
        stackView.backgroundColor = .systemOrange
        stackView.distribution = .fillProportionally
        stackView.spacing = 0

        labelStackView.axis = .horizontal
        labelStackView.backgroundColor = .systemBlue
        labelStackView.distribution = .fillProportionally

        diaryTitleLabel.font = .systemFont(ofSize: 20, weight: .bold)

        startDayLabel.adjustsFontSizeToFitWidth = true

        spaceLabel.text = " ~ "

        endDayLabel.adjustsFontSizeToFitWidth = true
        endDayLabel.textAlignment = .center

        collectionView.backgroundColor = .systemRed
    }

    private func setupLayout() {
        contentView.addSubview(collectionView)

        collectionView.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide).inset(12)
            make.bottom.equalTo(contentView.safeAreaLayoutGuide).inset(10)
            make.leading.equalTo(contentView.safeAreaLayoutGuide).inset(25)
            make.trailing.equalTo(contentView.safeAreaLayoutGuide).inset(210)
            make.width.height.equalTo(50)
        }

        contentView.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.trailing.bottom.equalTo(contentView.safeAreaLayoutGuide).inset(20)
            make.leading.equalTo(collectionView.snp.trailing).offset(10)
        }

        [diaryTitleLabel, progressView, labelStackView].forEach {
            stackView.addArrangedSubview($0)
        }

        progressView.snp.makeConstraints { make in
            make.bottom.equalTo(labelStackView.snp.top).offset(-5)
            make.height.equalTo(15)
        }

        labelStackView.snp.makeConstraints { make in
            make.height.equalTo(20)
        }

        [startDayLabel, spaceLabel, endDayLabel].forEach {
            labelStackView.addArrangedSubview($0)
        }
    }

    private func configureCollectionView() {
        collectionView.register(DiaryListThumbnailCell.self, forCellWithReuseIdentifier: DiaryListThumbnailCell.identifier)
        collectionView.dataSource = self

        collectionView.isScrollEnabled = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = true
        collectionView.backgroundColor = .clear
        collectionView.clipsToBounds = true
        collectionView.isPagingEnabled = false
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.contentInset = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 5)
        collectionView.decelerationRate = .fast

        collectionView.collectionViewLayout = collectionViewFlowLayout
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DiaryListCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DiaryListThumbnailCell.identifier, for: indexPath) as? DiaryListThumbnailCell else { return UICollectionViewCell() }
        cell.backgroundColor = .systemGreen
        cell.layer.cornerRadius = 5
        cell.thumbNailImage.image = UIImage(systemName: "bell")
        return cell
    }
}

extension DiaryListCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let interItemSpacing: CGFloat = 10
        let padding: CGFloat = 10
        let width = (collectionView.bounds.width - interItemSpacing * 3 - padding * 2) / 3
        let height = width
        return CGSize(width: width, height: height)
    }
}
