//
//  GiffCollectionView.swift
//  IGyfs
//
//  Created by Rafael Veronez Dias on 21/02/23.
//



import UIKit

class GiffCollectionView: UIView {
    
    lazy var collection: UICollectionView = {
        let collectionLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionLayout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .red
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 3, bottom: 0, right: 3)
        collectionView.register(GiffCollectionViewCell.self, forCellWithReuseIdentifier: GiffCollectionViewCell.identifier)
        collectionView.register(GiffHeaderCollectionView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: GiffHeaderCollectionView.identifier)
        
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
