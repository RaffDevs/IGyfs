//
//  FavoriteGiffViewModel.swift
//  IGyfs
//
//  Created by Rafael Veronez Dias on 21/03/23.
//

import Foundation

protocol FavoriteGiffViewModelProtocol: AnyObject {
    func success()
    func error()
}


class FavoriteGiffViewModel {
    static let shared: FavoriteGiffViewModel = FavoriteGiffViewModel()
    
    private let giffDatabase: GiffDatabase = GiffDatabase.shared
    
    private var favoriteGiffList: [Giff] = []
    
    private weak var delegate: FavoriteGiffViewModelProtocol?
    
    public var favoriteGiffs: [Giff] {
        favoriteGiffList
    }
    
    public func delegate(delegate: FavoriteGiffViewModelProtocol) {
        self.delegate = delegate
    }
    
    private init() {}
    
    public func getFavoriteGiffs() {
        let giffs = giffDatabase.getFavoriteGiffs(context: contextNS)
        
        if !giffs.isEmpty {
            favoriteGiffList.removeAll()
            favoriteGiffList.append(contentsOf: giffs.map({favGiff in
                Giff.transformToGiffFrom(favoriteGiff: favGiff!)
                })
            )
            self.delegate?.success()
        }
    }
}
