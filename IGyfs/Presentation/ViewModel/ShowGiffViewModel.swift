//
//  ShowGiffViewModel.swift
//  IGyfs
//
//  Created by Rafael Veronez Dias on 24/02/23.
//

import Foundation

protocol ShowGiffViewModelProtocol: AnyObject {
    func success(giff: Giff?)
    func failure()
}

class ShowGiffViewModel {
    static let shared = ShowGiffViewModel()
    
    private let giffService: GiffService = GiffService.shared
    private weak var delegate: ShowGiffViewModelProtocol?
    
    private init() {}
    
    public func delegate(delegate: ShowGiffViewModelProtocol) {
        self.delegate = delegate
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
    
    
    

