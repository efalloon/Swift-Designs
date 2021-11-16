//
//  shoe-data.swift
//  Nike Shoe App
//
//  Created by Euan Traynor on 16/11/21.
//

import Foundation

struct Shoe {
    let name: String
    let price: String
    let primaryImage: String
    let inspectImages: Array<String>
    let sizes: Array<ShoeSize>
    let liked: BooleanLiteralType
    let description: String
}

struct ShoeSize {
    let size: Float
    let available: BooleanLiteralType
}

var shoesArray: Array<Shoe> = [
    Shoe(name: "Nike Air Zoom G.T. Run", price: "$175.00", primaryImage: "air-zoom-gt-run", inspectImages: [], sizes: [
        ShoeSize(size: 40, available: true), ShoeSize(size: 40.5, available: false), ShoeSize(size: 41, available: false), ShoeSize(size: 42, available: true), ShoeSize(size: 42.5, available: true), ShoeSize(size: 43, available: false), ShoeSize(size: 44, available: true), ShoeSize(size: 45, available: true), ShoeSize(size: 46, available: true), ShoeSize(size: 47.5, available: true), ShoeSize(size: 48, available: true), ShoeSize(size: 48.5, available: false), ShoeSize(size: 49, available: false)
    ], liked: false, description: "Recommended for players that look for cushion and impact protection."),
    Shoe(name: "Nike Kyrie 4", price: "$136.00", primaryImage: "kyrie-4", inspectImages: [], sizes: [
        ShoeSize(size: 41, available: false), ShoeSize(size: 42, available: true), ShoeSize(size: 42.5, available: true), ShoeSize(size: 43, available: true), ShoeSize(size: 44, available: true), ShoeSize(size: 45, available: true), ShoeSize(size: 46, available: false), ShoeSize(size: 47.5, available: false), ShoeSize(size: 48, available: true), ShoeSize(size: 48.5, available: true), ShoeSize(size: 49, available: true)
    ], liked: false, description: "Affordable, well-rounded basketball shoe."),
    Shoe(name: "Nike Kyrie Low 2", price: "$154.00", primaryImage: "kyrie-low-2", inspectImages: [], sizes: [
        ShoeSize(size: 42, available: true), ShoeSize(size: 42.5, available: false), ShoeSize(size: 43, available: true), ShoeSize(size: 44, available: true), ShoeSize(size: 45, available: true), ShoeSize(size: 46, available: true)
    ], liked: false, description: "Works best for narrow-footers looking for a good allrounder with responsive cushioning."),
    Shoe(name: "Nike Mamba Instinct", price: "$125.00", primaryImage: "mamba-instinct", inspectImages: [], sizes: [
        ShoeSize(size: 40, available: true), ShoeSize(size: 40.5, available: true), ShoeSize(size: 41, available: true), ShoeSize(size: 42, available: true), ShoeSize(size: 42.5, available: true), ShoeSize(size: 43, available: false), ShoeSize(size: 44, available: true), ShoeSize(size: 45, available: false), ShoeSize(size: 46, available: true)
    ], liked: false, description: "Meant for quick guards who want a light shoe."),
    Shoe(name: "Nike Zoom Freak 1", price: "$83.00", primaryImage: "zoom-freak-1", inspectImages: [], sizes: [
        ShoeSize(size: 40, available: true), ShoeSize(size: 40.5, available: true), ShoeSize(size: 41, available: true), ShoeSize(size: 42, available: false), ShoeSize(size: 42.5, available: false)
    ], liked: false, description: "Very low-to-the-ground feeling with very firm forefoot-cushioning."),
    Shoe(name: "Nike PG1", price: "$160.00", primaryImage: "pg-1", inspectImages: [], sizes: [
        ShoeSize(size: 42.5, available: true), ShoeSize(size: 43, available: false), ShoeSize(size: 44, available: true), ShoeSize(size: 45.5, available: true), ShoeSize(size: 46, available: true), ShoeSize(size: 47, available: false), ShoeSize(size: 48, available: false)
    ], liked: false, description: "Works best for guards with regular or narrow feet."),
    Shoe(name: "Nike Lebron 15 Low", price: "$153.00", primaryImage: "lebron-15-low", inspectImages: [], sizes: [
        ShoeSize(size: 46, available: true), ShoeSize(size: 47.5, available: true), ShoeSize(size: 48, available: true), ShoeSize(size: 48.5, available: false), ShoeSize(size: 49, available: false), ShoeSize(size: 49.5, available: true), ShoeSize(size: 50, available: false), ShoeSize(size: 51, available: false)
    ], liked: false, description: "Great shoe for explosive and heavier players."),
]
