//
//  FavoriteGiffCollectionView.swift
//  IGyfs
//
//  Created by Rafael Veronez Dias on 20/03/23.
//

import UIKit

class FavoriteGiffCollectionView: UIView {

    lazy var collection: UICollectionView = {
        let collectionLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionLayout.scrollDirection = .vertical
        collectionLayout.minimumInteritemSpacing = 3
        collectionLayout.minimumLineSpacing = 5
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 25, bottom: 0, right: 25)
        collectionView.register(FavoriteGiffCollectionViewCell.self, forCellWithReuseIdentifier: FavoriteGiffCollectionViewCell.identifier)
        collectionView.backgroundColor = .black
        
        return collectionView
    }()
    
    
    func setupCollectionViewDelegate(delegate: UICollectionViewDelegate, datasource: UICollectionViewDataSource) {
        collection.delegate = delegate
        collection.dataSource = datasource
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
