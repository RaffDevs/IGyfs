//
//  GifEntity.swift
//  IGyfs
//
//  Created by Rafael Veronez Dias on 16/02/23.
//

import Foundation

struct GifEntity: Codable {
    let id: String
    let url: String
    let title: String
    let images: GifImage
}
