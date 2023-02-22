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
}

class GiffViewModel {
    private var giffService: GiffService = GiffService()
    private var listGiffs: [Giff] = []
    private weak var delegate: GiffViewModelProtocol?
    
    public func delegate(delegate: GiffViewModelProtocol) {
        self.delegate = delegate
    }
    
    public var giffs: [Giff] {
        listGiffs
    }
    
    
    func getTrendingGiffs() {
        giffService.getTrendingGiffs { data, error in
            if error == nil {
                if let gyphyData = data?.data {
                    for item in gyphyData {
                        self.listGiffs.append(Giff.transformToGifFrom(gyphyGifData: item))
                    }
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
