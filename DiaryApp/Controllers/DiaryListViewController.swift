//
//  DiaryListViewController.swift
//  DiaryApp
//
//  Created by (^ㅗ^)7 iMac on 2023/08/28.
//

import SnapKit
import UIKit

class DiaryListViewController: UIViewController {
    private let collectionView = CustomCollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureCollectionView()
        configureLayout()
    }

    private let collectionViewFlowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = Const.itemSize
        layout.minimumLineSpacing = Const.itemSpacing
        layout.minimumInteritemSpacing = 0
        return layout
    }()

    private func configureCollectionView() {
        collectionView.register(DiaryListCell.self, forCellWithReuseIdentifier: DiaryListCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self

        collectionView.isScrollEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = true
        collectionView.backgroundColor = .clear
        collectionView.clipsToBounds = true
        collectionView.isPagingEnabled = false
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.contentInset = Const.collectionViewContentInset
        collectionView.decelerationRate = .fast

        collectionView.collectionViewLayout = collectionViewFlowLayout
    }

    private func configureLayout() {
        view.addSubview(collectionView)

        collectionView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

extension DiaryListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DiaryListCell.identifier, for: indexPath) as? DiaryListCell else { return UICollectionViewCell() }
        cell.diaryTitleLabel.text = "Hello World"
        cell.startDayLabel.text = "2023.08.30"
        cell.endDayLabel.text = "2023.09.30"

        cell.backgroundColor = .systemPink
        cell.collectionView.backgroundColor = .systemBlue
        cell.collectionView.layer.cornerRadius = 10
        cell.layer.cornerRadius = 20
        return cell
    }
}

extension DiaryListViewController: UICollectionViewDelegate {}

extension DiaryListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let interItemSpacing: CGFloat = 10
        let padding: CGFloat = 10
        let width = (collectionView.bounds.width - interItemSpacing * 3 - padding * 2)
        print("### \(width)")
        let height = width / 3
        return CGSize(width: width, height: height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}
