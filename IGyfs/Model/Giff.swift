//
//  Giff.swift
//  IGyfs
//
//  Created by Rafael Veronez Dias on 21/02/23.
//

import Foundation

struct Giff {
    let id: String
    let title: String
    let url: String
    let mediaUrl: String
    let isFavorite: Bool = false
    
    
    static func transformToGifFrom(gyphyGifData rawGif: GiffEntity) -> Giff {
        return Giff(
            id: rawGif.id,
            title: rawGif.title,
            url: rawGif.url,
            mediaUrl: rawGif.images.fixed_height.url
        )
    }
}
