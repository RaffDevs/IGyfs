//
//  GiffViewModel.swift
//  IGyfs
//
//  Created by Rafael Veronez Dias on 21/02/23.
//

import Foundation
import AlamofireImage

protocol GiffViewModelProtocol: AnyObject {
    func success()
    func error()
    func reloadSearchGiffs()
}

class GiffViewModel {
    static let shared:GiffViewModel = GiffViewModel()

    private var giffService: GiffService = GiffService.shared
    private var listGiffs: [Giff] = []
    private weak var delegate: GiffViewModelProtocol?
    
    private init() {}
    
    public func delegate(delegate: GiffViewModelProtocol) {
        self.delegate = delegate
    }
    
    public var giffs: [Giff] {
        listGiffs
    }
    
    func getMoreGiffs() {
        giffService.getMoreGiffs { data, error in
            if error == nil {
                if let gyphyData = data?.data {
                    self.listGiffs.append(contentsOf: gyphyData.map({ gyphyEntity in
                        Giff.transformToGifFrom(gyphyGifData: gyphyEntity)
                    }))
                    self.delegate?.reloadSearchGiffs()
                    
                }
            } else {
                print(error!.localizedDescription)
                self.delegate?.error()
            }
        }
    }
    
    func searchForGiffs(search: String) {
        giffService.searchGiffs(search: search) { data, error in
            if error == nil {
                if let gyphyData = data?.data {
                    self.listGiffs.removeAll()
                    self.listGiffs.append(contentsOf: gyphyData.map({ gyphyEntity in
                        Giff.transformToGifFrom(gyphyGifData: gyphyEntity)
                    }))
                    self.delegate?.reloadSearchGiffs()
                    
                }
            } else {
                print(error!.localizedDescription)
                self.delegate?.error()
            }
        }
    }
    
    
    func getTrendingGiffs() {
        giffService.getTrendingGiffs { data, error in
            if error == nil {
                if let gyphyData = data?.data {
                    self.listGiffs.removeAll()
                    self.listGiffs.append(contentsOf: gyphyData.map({ gyphyEntity in
                        Giff.transformToGifFrom(gyphyGifData: gyphyEntity)
                    }))
                    self.delegate?.success()
                }
                
            } else {
                print(error!.localizedDescription)
                self.delegate?.error()
            }
        }
    }
    
    func loadImageGiff(urlString: String, completion: @escaping (Data?) -> Void) {
        giffService.getImageFromGiff(urlRaw: urlString) { data, error in
            if error == nil {
                completion(data)
            } else {
                print(#function)
                print(error!.localizedDescription)
            }
        }
    }
}
