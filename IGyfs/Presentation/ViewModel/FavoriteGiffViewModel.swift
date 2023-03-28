//
//  FavoriteGiffViewModel.swift
//  IGyfs
//
//  Created by Rafael Veronez Dias on 21/03/23.
//

import Foundation
import UIKit

protocol FavoriteGiffViewModelProtocol: AnyObject {
    func show(viewController: UIViewController)
    func success()
    func error()
}


class FavoriteGiffViewModel: NSObject {
    static let shared: FavoriteGiffViewModel = FavoriteGiffViewModel()
    
    private let giffDatabase: GiffDatabase = GiffDatabase.shared
    
    private let favoriteGiffScreen: FavoriteGiffScreen = FavoriteGiffScreen()
    
    private var favoriteGiffList: [Giff] = []
    
    private weak var delegate: FavoriteGiffViewModelProtocol?
    
    public var favoriteGiffs: [Giff] {
        favoriteGiffList
    }
    
    public func delegate(delegate: FavoriteGiffViewModelProtocol) {
        self.delegate = delegate
    }
    
    
    public func getFavoriteGiffs() {
        let giffs = giffDatabase.getFavoriteGiffs(context: contextNS)
        
        if !giffs.isEmpty {
            favoriteGiffList.removeAll()
            favoriteGiffList.append(contentsOf: giffs.map({ favGiff in
                Giff.transformToGiffFrom(favoriteGiff: favGiff!)
                }))
            self.delegate?.success()
        }
    }
    
    public func showCurrentGiff(viewController: UIViewController) {
        self.delegate?.show(viewController: viewController)
    }
}
