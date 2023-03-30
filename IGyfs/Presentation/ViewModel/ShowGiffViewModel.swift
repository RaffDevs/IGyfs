//
//  ShowGiffViewModel.swift
//  IGyfs
//
//  Created by Rafael Veronez Dias on 24/02/23.
//

import Foundation
import CoreData
import NotificationBannerSwift

protocol ShowGiffViewModelProtocol: AnyObject {
    func success(giff: Giff?)
    func shareGiff(giff: Data)
    func dismissShowGiffModal()
    func failure()
}

protocol ShowGiffEvents: AnyObject {
    func toogleLikeButton(toggle: Bool)
    func showBanner(message: String, style: BannerStyle)
}

protocol ShowGiffUpdateProtocol: AnyObject {
    func updateData()
}


class ShowGiffViewModel {
    static let shared = ShowGiffViewModel()
    
    private let giffService: GiffService = GiffService.shared
    private let giffDatabase: GiffDatabase = GiffDatabase.shared
    private weak var delegate: ShowGiffViewModelProtocol?
    private weak var events: ShowGiffEvents?
    private weak var update: ShowGiffUpdateProtocol?
    
    private var currentGiff: Giff?
    private var giffData: Data?
    
    private init() {}
    
    public func delegate(delegate: ShowGiffViewModelProtocol) {
        self.delegate = delegate
    }
    
    public func registerEvents(events: ShowGiffEvents) {
        self.events = events
    }
    
    public func registerUpdate(update: ShowGiffUpdateProtocol) {
        self.update = update
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
                self.getFavoriteGiffById()
                self.giffData = data
                completion(data)
            } else {
                print(error!.localizedDescription)
            }
        }
    }
    
    private func getFavoriteGiffById() {
        let result = giffDatabase.getFavoriteGiffById(context: contextNS, id: currentGiff!.id)
        
        if (!result.isEmpty) {
            if result[0] != nil {
                self.events?.toogleLikeButton(toggle: true)
            }
            
        } else {
            self.events?.toogleLikeButton(toggle: false)
        }
        
                
    }
    
    public func shareGiff() {
        if let data = giffData {
            self.delegate?.shareGiff(giff: data)

        }
    }
    
    public func saveGiffAsFavorite() {
        if currentGiff != nil {
            let result = giffDatabase.getFavoriteGiffById(context: contextNS, id: currentGiff!.id)
            
            if result.isEmpty {
                giffDatabase.saveFavoriteGiff(giff: currentGiff!, context: contextNS)
                self.events?.toogleLikeButton(toggle: true)
                self.events?.showBanner(message: "Giff salvo nos favoritos!", style: .success)
            } else {
                giffDatabase.removeGiffFromFavorite(id: currentGiff!.id, context: contextNS) { success, error in
                    if (success) {
                        print("Removeu com sucesso!")
                        self.events?.toogleLikeButton(toggle: false)
                        self.delegate?.dismissShowGiffModal()
                        self.update?.updateData()
                        self.events?.showBanner(message: "Giff removido dos favoritos", style: .success)

                    } else {
                        print("Erro ao deletar item \(error!.localizedDescription)")
                    }
                }
                
            }
        }
    }
    
    
}
    
    
    

