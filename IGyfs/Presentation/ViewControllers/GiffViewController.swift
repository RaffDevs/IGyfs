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
    private var canShowButton = false

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
        return giffViewModel.giffs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GiffCollectionViewCell.identifier, for: indexPath) as? GiffCollectionViewCell
        
        if indexPath.row == giffViewModel.giffs.count {
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
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentOffset = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let collectionViewHeight = scrollView.frame.size.height
        let visibleHeight = scrollView.bounds.height
        
        if (giffViewModel.giffs.count > 0 && currentOffset >= (contentHeight - collectionViewHeight)) {
            if !canShowButton {
                print("Mostrar")
                giffScreen?.showButton(show: true)
                canShowButton = true
            }
        } else if (currentOffset <= (contentHeight - visibleHeight) / 1.1) {
            if canShowButton {
                print("Não mostrar")
                giffScreen?.showButton(show: false)
                canShowButton = false
            }
        }
    }
    
}

extension GiffViewController: GiffViewModelProtocol {

    func show(viewController: UIViewController) {
        present(viewController, animated: true)
    }
    
    func success(giffs: [Giff]?, isNewSearch: Bool) {
        print(#function)
        
        if isNewSearch {
            giffScreen?.reloadCollectionViewData()
        } else {
            guard let collectionView = self.giffScreen?.giffCollectionView.collection else { return }
            let newCellCount = giffs?.count ?? 0
            let newItemsCount = collectionView.numberOfItems(inSection: 0) + newCellCount
            var indexPaths: [IndexPath] = []
            
            for index in collectionView.numberOfItems(inSection: 0)..<newItemsCount {
                let indexPath = IndexPath(item: index, section: 0)
                indexPaths.append(indexPath)
            }
            
            collectionView.performBatchUpdates {
                collectionView.insertItems(at: indexPaths)
            }
        }
        
        
        
        
//        self.giffScreen?.reloadCollectionViewData()
    }
    
    
    func error() {
        print(#function)
    }
    
    
}
