//
//  HomeViewController.swift
//  DiaryApp
//
//  Created by (^ㅗ^)7 iMac on 2023/08/28.
//

import UIKit

private enum Const {
    static let itemSize = CGSize(width: 300, height: 550)
    static let itemSpacing = 46.0

    static var insetX: CGFloat {
        (UIScreen.main.bounds.width - Self.itemSize.width) / 2.0
    }

    static var collectionViewContentInset: UIEdgeInsets {
        UIEdgeInsets(top: 40, left: Self.insetX, bottom: 10, right: Self.insetX)
    }
}

class HomeViewController: UIViewController {
    private let collectionView = CustomCollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureCollectionView()
        configureLayout()
        addSearchBar()
    }

    private let collectionViewFlowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = Const.itemSize
        layout.minimumLineSpacing = Const.itemSpacing
        layout.minimumInteritemSpacing = 0
        return layout
    }()

    private func configureCollectionView() {
        collectionView.register(HomeFeedCell.self, forCellWithReuseIdentifier: HomeFeedCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self

        collectionView.isScrollEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = true
        collectionView.backgroundColor = .clear
        collectionView.clipsToBounds = true
        collectionView.register(HomeFeedCell.self, forCellWithReuseIdentifier: HomeFeedCell.identifier)
        collectionView.isPagingEnabled = false
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.contentInset = Const.collectionViewContentInset
        collectionView.decelerationRate = .fast

        collectionView.collectionViewLayout = collectionViewFlowLayout
    }

    private func configureLayout() {
        view.addSubview(collectionView)

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }

    private func addSearchBar() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        searchController.navigationItem.hidesSearchBarWhenScrolling = true
        navigationItem.searchController = searchController
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeFeedCell.identifier, for: indexPath) as? HomeFeedCell else { return UICollectionViewCell() }
        cell.backgroundColor = .systemOrange
        cell.layer.cornerRadius = 20
        return cell
    }
}

extension HomeViewController: UICollectionViewDelegate {}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func scrollViewWillEndDragging(
        _ scrollView: UIScrollView,
        withVelocity velocity: CGPoint,
        targetContentOffset: UnsafeMutablePointer<CGPoint>
    ) {
        let scrolledOffsetX = targetContentOffset.pointee.x + scrollView.contentInset.left
        let cellWidth = Const.itemSize.width + Const.itemSpacing
        let index = round(scrolledOffsetX / cellWidth)
        targetContentOffset.pointee = CGPoint(x: index * cellWidth - scrollView.contentInset.left, y: scrollView.contentInset.top)
    }
}
