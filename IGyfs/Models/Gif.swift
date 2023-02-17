//
//  Gif.swift
//  IGyfs
//
//  Created by Rafael Veronez Dias on 16/02/23.
//

import Foundation

struct Gif {
    let id: String
    let title: String
    let url: String
    let mediaUrl: String
    let isFavorite: Bool = false
    
    
    func transformToGifFrom(gyphyGifData rawGif: GifEntity) -> Gif {
        return Gif(
            id: rawGif.id,
            title: rawGif.title,
            url: rawGif.url,
            mediaUrl: rawGif.images.fixed_height.url
        )
    }
}
