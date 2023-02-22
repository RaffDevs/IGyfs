//
//  GiffScreen.swift
//  IGyfs
//
//  Created by Rafael Veronez Dias on 21/02/23.
//

import UIKit

class GiffScreen: UIView {
    private var giffCollectionView: GiffCollectionView = GiffCollectionView()
    
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
        setupElements()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configCollectionView(delegate: UICollectionViewDelegate, datasource: UICollectionViewDataSource) {
        giffCollectionView.setupCollectionViewDelegate(delegate: delegate, datasource: datasource)
    }
    
    private func setupElements() {
        addSubview(giffCollectionView.collection)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            giffCollectionView.collection.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            giffCollectionView.collection.leadingAnchor.constraint(equalTo: leadingAnchor),
            giffCollectionView.collection.trailingAnchor.constraint(equalTo: trailingAnchor),
            giffCollectionView.collection.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
}
