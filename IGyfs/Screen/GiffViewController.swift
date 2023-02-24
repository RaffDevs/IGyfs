//
//  GiffViewController.swift
//  IGyfs
//
//  Created by Rafael Veronez Dias on 21/02/23.
//

import UIKit

class GiffViewController: UIViewController {
    private var giffScreen: GiffScreen?
    private var giffViewModel: GiffViewModel = GiffViewModel.shared
    
    override func loadView() {
        giffScreen = GiffScreen()
        view = giffScreen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        giffViewModel.delegate(delegate: self)
        giffScreen?.configCollectionView(delegate: self, datasource: self)
        giffViewModel.getTrendingGiffs()
        
    }
    
}

extension GiffViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return giffViewModel.giffs.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GiffCollectionViewCell.identifier, for: indexPath) as? GiffCollectionViewCell
        
        if indexPath.row == collectionView.numberOfSections {
            cell?.setupCell(giff: nil, isCellAction: true)
        } else {
            cell?.setupCell(giff: giffViewModel.giffs[indexPath.row])
        }
                
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSize = UIScreen.main.bounds.width/2.3 - 3

        return CGSize(width: itemSize, height: itemSize)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: GiffHeaderCollectionView.identifier, for: indexPath) as? GiffHeaderCollectionView
        
        return header ?? UICollectionReusableView()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 100)

    }
    
}

extension GiffViewController: GiffViewModelProtocol {
    func success() {
        print(#function)
        self.giffScreen?.reloadCollectionViewData()

    }
    
    func error() {
        print(#function)
    }
    
    func reloadSearchGiffs() {
        self.giffScreen?.reloadCollectionViewData()
    }
    
    
}
