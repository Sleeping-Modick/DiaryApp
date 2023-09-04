//
//  ProgressListViewController.swift
//  DiaryApp
//
//  Created by (^ㅗ^)7 iMac on 2023/08/28.
//

import Kingfisher
import SnapKit
import UIKit

class ProgressListViewController: UIViewController {
    private let collectionView = CustomCollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())

    var postList = [Post]()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureCollectionView()
        configureLayout()
    }

    override func viewWillAppear(_ animated: Bool) {
        firebaseOperation()
    }

    private let collectionViewFlowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = Const.itemSize
        layout.minimumLineSpacing = Const.itemSpacing
        layout.minimumInteritemSpacing = 0
        return layout
    }()

    private func firebaseOperation() {
        FirestoreManager().getPostData { post in
            post?.forEach { _ in
                guard let post = post else { return }
                self.postList = post

                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }
    }

    private func configureCollectionView() {
        collectionView.register(ProgressListCell.self, forCellWithReuseIdentifier: ProgressListCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self

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
            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-10)
        }
    }
}

extension ProgressListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return postList.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = postList[indexPath.row]
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProgressListCell.identifier, for: indexPath) as? ProgressListCell else { return UICollectionViewCell() }
        if let image = item.image {
            cell.imageView.kf.setImage(with: URL(string: image))
        }
        cell.weatherImageView.image = UIImage(systemName: "sun.max")
        cell.descriptionLabel.text = item.content
        cell.tagValue = [item.tag]
        cell.backgroundColor = .systemRed
        cell.layer.cornerRadius = 20
        return cell
    }
}

extension ProgressListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let interItemSpacing: CGFloat = 10
        let padding: CGFloat = 10
        let width = (collectionView.bounds.width - interItemSpacing * 3 - padding * 2)
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
