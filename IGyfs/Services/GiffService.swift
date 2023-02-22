//
//  GiffService.swift
//  IGyfs
//
//  Created by Rafael Veronez Dias on 21/02/23.
//

import Foundation
import Alamofire

class GiffService {
    func getTrendingGiffs(completion: @escaping (GyphyDataEntity?, Error?) -> Void) {
        let url: String =  "https://api.giphy.com/v1/gifs/trending?api_key=VRKeEOYSevFpO1MZBIIo8eQr2P5ahRPr&limit=25&rating=g"
        
        AF.request(url, method: .get).validate().responseDecodable(of: GyphyDataEntity.self) { response in
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
}
