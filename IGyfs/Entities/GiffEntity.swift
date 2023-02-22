//
//  GiffEntity.swift
//  IGyfs
//
//  Created by Rafael Veronez Dias on 21/02/23.
//

import Foundation

struct GiffEntity: Codable {
    let id: String
    let url: String
    let title: String
    let images: GifImage
}
