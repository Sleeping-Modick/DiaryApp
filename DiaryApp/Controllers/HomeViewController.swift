//
//  HomeViewController.swift
//  DiaryApp
//
//  Created by (^ㅗ^)7 iMac on 2023/08/28.
//

import Kingfisher
import SnapKit
import UIKit

enum Const {
    static let itemSize = CGSize(width: 300, height: 550)
    static let itemSpacing = 46.0
    
    static var insetX: CGFloat {
        (UIScreen.main.bounds.width - itemSize.width) / 2.0
    }
    
    static var collectionViewContentInset: UIEdgeInsets {
        UIEdgeInsets(top: 0, left: insetX, bottom: 0, right: insetX)
    }
}

class HomeViewController: UIViewController {
    private let collectionView = CustomCollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    var postList = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureCollectionView()
        configureLayout()
        addSearchBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        firebaseOperation()
    }
    
    private let collectionViewFlowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = Const.itemSize
        layout.minimumLineSpacing = Const.itemSpacing
        layout.minimumInteritemSpacing = 0
        return layout
    }()
    
    private func firebaseOperation() {
        FirestoreService().getPostData { post in
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

        collectionView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20)
        }
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
        return postList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = postList[indexPath.row]
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeFeedCell.identifier, for: indexPath) as? HomeFeedCell else { return UICollectionViewCell() }
        cell.backgroundColor = .systemOrange
        if let image = item.image {
            cell.myView.kf.setImage(with: URL(string: image))
        }
        
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 1
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
