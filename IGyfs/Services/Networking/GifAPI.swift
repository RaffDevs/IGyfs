//
//  GiffService.swift
//  IGyfs
//
//  Created by Rafael Veronez Dias on 16/02/23.
//

import Foundation

class GifAPI {
    private static let baseURL = "https://api.giphy.com/v1/gifs/trending?api_key=VRKeEOYSevFpO1MZBIIo8eQr2P5ahRPr&limit=25&rating=g"
    
    private static let configuration: URLSessionConfiguration = {
        let config = URLSessionConfiguration.default
        config.httpAdditionalHeaders = ["Content-Type": "application/json"]
        config.timeoutIntervalForRequest = 10.0
        config.httpMaximumConnectionsPerHost = 5
        
        return config
    }()
    
    private let session = URLSession(configuration: configuration)
    
    func getGifs() {
        guard let url = URL(string: GifAPI.baseURL) else { return }
        
        let task = session.dataTask(with: url) {(data: Data?, response: URLResponse?, error: Error?) in
            if error == nil {
                guard let response = response as? HTTPURLResponse else { return }
                
                if response.statusCode == 200 {
                    guard let data = data else { return }
                    
                    do {
                        let gyphyData = try JSONDecoder().decode(GyphyEntity.self, from: data)
                        print(gyphyData.data)

                    } catch {
                        print("Erro ao converter gifs: \(error)")
                    }
                } else {
                    print("O servidor respondeu algo diferente do esperado: \n statusCode: \(response.statusCode)")
                }
                
            } else {
                print("Um erro ocorreu \(String(describing: error?.localizedDescription))")
            }
        }
        
        task.resume()
    }
}
