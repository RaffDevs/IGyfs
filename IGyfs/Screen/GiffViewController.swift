//
//  GiffViewController.swift
//  IGyfs
//
//  Created by Rafael Veronez Dias on 21/02/23.
//

import UIKit

class GiffViewController: UIViewController {
    private var giffScreen: GiffScreen?
    private var giffViewModel: GiffViewModel = GiffViewModel()
    
    override func loadView() {
        giffScreen = GiffScreen()
        view = giffScreen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        giffViewModel.getTrendingGiffs()
        giffScreen?.configCollectionView(delegate: self, datasource: self)
        
    }
    
}

extension GiffViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return giffViewModel.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GiffCollectionViewCell.identifier, for: indexPath) as? GiffCollectionViewCell
        
        cell?.setupCell(number: giffViewModel.items[indexPath.row])
        
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.width / 2.1, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: GiffHeaderCollectionView.identifier, for: indexPath) as? GiffHeaderCollectionView
        
        return header ?? UICollectionReusableView()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 100)

    }
    
}
