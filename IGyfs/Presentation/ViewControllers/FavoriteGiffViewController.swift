//
//  FavoriteGiffViewController.swift
//  IGyfs
//
//  Created by Rafael Veronez Dias on 13/03/23.
//

import UIKit

class FavoriteGiffViewController: UIViewController {
    private var favoriteGiffScreen: FavoriteGiffScreen?
    private let giffDatabase: GiffDatabase = GiffDatabase.shared
    private let favoriteGiffViewModel: FavoriteGiffViewModel = FavoriteGiffViewModel.shared
    
    override func loadView() {
        favoriteGiffScreen = FavoriteGiffScreen()
        view = favoriteGiffScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favoriteGiffViewModel.delegate(delegate: self)
        favoriteGiffScreen?.configCollectionView(delegate: self, datasource: self)
        favoriteGiffViewModel.getFavoriteGiffs()

    }
    
}

extension FavoriteGiffViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favoriteGiffViewModel.favoriteGiffs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavoriteGiffCollectionViewCell.identifier, for: indexPath) as? FavoriteGiffCollectionViewCell
        
        print("DADOS \(favoriteGiffViewModel.favoriteGiffs)")
        
        cell?.setupCell(giff: favoriteGiffViewModel.favoriteGiffs[indexPath.row])
                
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSize = UIScreen.main.bounds.width/2.3 - 3

        return CGSize(width: itemSize, height: itemSize)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 100)

    }
}

extension FavoriteGiffViewController: FavoriteGiffViewModelProtocol {
    func success() {
        print(#function)
        self.favoriteGiffScreen?.reloadCollectionViewData()
    }
    
    func error() {
        print(#function)
    }
    
    
}
