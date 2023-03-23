//
//  ShowGiffViewModel.swift
//  IGyfs
//
//  Created by Rafael Veronez Dias on 24/02/23.
//

import Foundation
import CoreData

protocol ShowGiffViewModelProtocol: AnyObject {
    func success(giff: Giff?)
    func failure()
}


class ShowGiffViewModel {
    static let shared = ShowGiffViewModel()
    
    private let giffService: GiffService = GiffService.shared
    private let giffDatabase: GiffDatabase = GiffDatabase.shared
    private weak var delegate: ShowGiffViewModelProtocol?
    
    private var currentGiff: Giff?
    
    private init() {}
    
    public func delegate(delegate: ShowGiffViewModelProtocol) {
        self.delegate = delegate
    }
    
    public func setCurrentGiff(giff: Giff) {
        currentGiff = giff
    }
    
    public func getGiffById(id: String) {
        giffService.getGiffById(id: id) { data, error in
            if error == nil {
                if let gyphyData = data?.data {
                    self.delegate?.success(giff: Giff.transformToGifFrom(gyphyGifData: gyphyData[0]))
                }
                
            } else {
                print(error!.localizedDescription)
                self.delegate?.failure()
            }
            }
        }
    
    public func loadImageGiff(urlString: String, completion: @escaping (Data?) -> Void) {
        giffService.getImageFromGiff(urlRaw: urlString) { data, error in
            if error == nil {
                completion(data)
            } else {
                print(#function)
                print(error!.localizedDescription)
            }
        }
    }
    
    public func saveGiffAsFavorite() {
        if currentGiff != nil {
            giffDatabase.saveFavoriteGiff(giff: currentGiff!, context: contextNS)
        }
    }
    
    
}
    
    
    

