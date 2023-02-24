//
//  GiffService.swift
//  IGyfs
//
//  Created by Rafael Veronez Dias on 21/02/23.
//

import Foundation
import Alamofire
import AlamofireImage

enum GiffServiceError: Swift.Error {
    case fetchImageError(detail: String)
}

struct GiffParamters: Encodable {
    let key: String = "VRKeEOYSevFpO1MZBIIo8eQr2P5ahRPr"
    var limit: Int = 25
    var q: String? = nil
    var offset: Int = 0
    var lang: String = "en"
}

class GiffService {
    private let stringURL: String = "https://api.giphy.com/v1/gifs/"
    private var stringPathURL: String = "trending"
    private var paramters: GiffParamters = GiffParamters()

    static let shared: GiffService = GiffService()

    
    private init() {}
    
    func getMoreGiffs(completion: @escaping (GyphyDataEntity?, Error?) -> Void) {
        guard var url = URL(string: stringURL) else { return }
        paramters.offset += 25
        url.append(path: stringPathURL)

        AF.request(url, method: .get, parameters: paramters).validate().responseDecodable(of: GyphyDataEntity.self) { response in
            debugPrint(response)

            switch response.result {
                
            case .success(let success):
                print("Sucesso -> \(#function)")
                completion(success, nil)
            case .failure(let error):
                print("Falha -> \(#function)")
                completion(nil, error)
            }
        }
        
    }
    
    func getGiffById(id: String, completion: @escaping (GyphyDataEntity?, Error?) -> Void) {
        guard var url = URL(string: stringURL) else { return }
        stringPathURL = id
        url.append(path: stringPathURL)
        AF.request(url, method: .get, parameters: paramters).validate().responseDecodable(of: GyphyDataEntity.self) { response in
            debugPrint(response)
            
            switch response.result {
                
            case .success(let success):
                print("Sucesso -> \(#function)")
                completion(success, nil)
            case .failure(let error):
                print("Falha -> \(#function)")
                completion(nil, error)
            }
        }
    }
    
    func getTrendingGiffs(completion: @escaping (GyphyDataEntity?, Error?) -> Void) {
        guard var url = URL(string: stringURL) else { return }
        stringPathURL = "trending"
        url.append(path: stringPathURL)
        
        AF.request(url, method: .get, parameters: paramters).validate().responseDecodable(of: GyphyDataEntity.self) { response in
            debugPrint(response)
            
            switch response.result {
                
            case .success(let success):
                print("Sucesso -> \(#function)")
                completion(success, nil)
            case .failure(let error):
                print("Falha -> \(#function)")
                completion(nil, error)
            }
        }
    }
    
    func searchGiffs(search: String, completion: @escaping (GyphyDataEntity?, Error?) -> Void) {
        guard var url = URL(string: stringURL) else { return }
        stringPathURL = "search"
        url.append(path: stringPathURL)
        paramters.q = search
        
        AF.request(url, method: .get, parameters: paramters).validate().responseDecodable(of: GyphyDataEntity.self) { response in
            debugPrint(response)
            
            switch response.result {
                
            case .success(let success):
                print("Sucesso -> \(#function)")
                completion(success, nil)
            case .failure(let error):
                print("Falha -> \(#function)")
                completion(nil, error)
            }
        }
    }
    
    func getImageFromGiff(urlRaw: String, completion: @escaping (Data?, Error?) -> Void) {
        guard let url = URL(string: urlRaw) else { return }
        AF.request(url).responseImage { response in
            guard let data = response.data else { return completion(nil, GiffServiceError.fetchImageError(detail: "Erro ao buscar imagem")) }
            
            completion(data, nil)
        }
    }
}
