//
//  GifImages.swift
//  IGyfs
//
//  Created by Rafael Veronez Dias on 16/02/23.
//

import Foundation

struct GifImage: Codable {
    struct FixedHeight: Codable {
        let url: String
    }
    
    
    let fixed_height: FixedHeight
    
    
}


