//
//  GiffViewModel.swift
//  IGyfs
//
//  Created by Rafael Veronez Dias on 21/02/23.
//

import Foundation
import AlamofireImage

protocol GiffViewModelProtocol: AnyObject {
    func success(giffs: [Giff]?, isNewSearch: Bool)
    func error()
    func show(viewController: UIViewController)
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
                    let giffs = gyphyData.map({gyphyEntity in
                        Giff.transformToGifFrom(gyphyGifData: gyphyEntity)
                    })
                    self.listGiffs.append(contentsOf: giffs)
                    self.delegate?.success(giffs: giffs, isNewSearch: false)
                    
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
                    let giffs = gyphyData.map({gyphyEntity in
                        Giff.transformToGifFrom(gyphyGifData: gyphyEntity)
                    })
                    self.listGiffs.removeAll()
                    self.listGiffs.append(contentsOf: giffs)
                    self.delegate?.success(giffs: giffs, isNewSearch: true)
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
                    let giffs = gyphyData.map({gyphyEntity in
                        Giff.transformToGifFrom(gyphyGifData: gyphyEntity)
                    })
                    self.listGiffs.removeAll()
                    self.listGiffs.append(contentsOf: giffs)
                    self.delegate?.success(giffs: giffs, isNewSearch: true)
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
    
    func showCurrentGiff(viewController: UIViewController) {
        self.delegate?.show(viewController: viewController)
    }
}
