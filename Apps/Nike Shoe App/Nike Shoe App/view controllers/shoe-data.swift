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
    Shoe(name: "Nike Air Zoom G.T. Run", price: "$175.00", primaryImage: "air-zoom-gt-run", inspectImages: ["air-zoom-gt-run-2", "air-zoom-gt-run-4", "air-zoom-gt-run-5", "air-zoom-gt-run-1"], sizes: [
        ShoeSize(size: 40, available: true), ShoeSize(size: 40.5, available: false), ShoeSize(size: 41, available: false), ShoeSize(size: 42, available: true), ShoeSize(size: 42.5, available: true), ShoeSize(size: 43, available: false), ShoeSize(size: 44, available: true), ShoeSize(size: 45, available: true), ShoeSize(size: 46, available: true), ShoeSize(size: 47.5, available: true), ShoeSize(size: 48, available: true), ShoeSize(size: 48.5, available: false), ShoeSize(size: 49, available: false)
    ], liked: false, description: "Recommended for players that look for cushion and impact protection."),
    Shoe(name: "Nike Kyrie 4", price: "$136.00", primaryImage: "kyrie-4", inspectImages: ["kyrie-4-1", "kyrie-4-2", "kyrie-4-3", "kyrie-4-4"], sizes: [
        ShoeSize(size: 41, available: false), ShoeSize(size: 42, available: true), ShoeSize(size: 42.5, available: true), ShoeSize(size: 43, available: true), ShoeSize(size: 44, available: true), ShoeSize(size: 45, available: true), ShoeSize(size: 46, available: false), ShoeSize(size: 47.5, available: false), ShoeSize(size: 48, available: true), ShoeSize(size: 48.5, available: true), ShoeSize(size: 49, available: true)
    ], liked: false, description: "Affordable, well-rounded basketball shoe."),
    Shoe(name: "Nike Kyrie Low 2", price: "$154.00", primaryImage: "kyrie-low-2", inspectImages: ["kyrie-low-2-1", "kyrie-low-2-2", "kyrie-low-2-3", "kyrie-low-2-4"], sizes: [
        ShoeSize(size: 42, available: true), ShoeSize(size: 42.5, available: false), ShoeSize(size: 43, available: true), ShoeSize(size: 44, available: true), ShoeSize(size: 45, available: true), ShoeSize(size: 46, available: true)
    ], liked: false, description: "Works best for narrow-footers looking for a good allrounder with responsive cushioning."),
    Shoe(name: "Nike Mamba Instinct", price: "$125.00", primaryImage: "mamba-instinct", inspectImages: ["mamba-instinct-1", "mamba-instinct-2", "mamba-instinct-3"], sizes: [
        ShoeSize(size: 40, available: true), ShoeSize(size: 40.5, available: true), ShoeSize(size: 41, available: true), ShoeSize(size: 42, available: true), ShoeSize(size: 42.5, available: true), ShoeSize(size: 43, available: false), ShoeSize(size: 44, available: true), ShoeSize(size: 45, available: false), ShoeSize(size: 46, available: true)
    ], liked: false, description: "Meant for quick guards who want a light shoe."),
    Shoe(name: "Nike Zoom Freak 1", price: "$83.00", primaryImage: "zoom-freak-1", inspectImages: ["zoom-freak-1-1", "zoom-freak-1-2", "zoom-freak-1-3", "zoom-freak-1-4"], sizes: [
        ShoeSize(size: 40, available: true), ShoeSize(size: 40.5, available: true), ShoeSize(size: 41, available: true), ShoeSize(size: 42, available: false), ShoeSize(size: 42.5, available: false)
    ], liked: false, description: "Very low-to-the-ground feeling with very firm forefoot-cushioning."),
    Shoe(name: "Nike PG1", price: "$160.00", primaryImage: "pg-1", inspectImages: ["pg-1-1", "pg-1-2", "pg-1-3", "pg-1-4"], sizes: [
        ShoeSize(size: 42.5, available: true), ShoeSize(size: 43, available: false), ShoeSize(size: 44, available: true), ShoeSize(size: 45.5, available: true), ShoeSize(size: 46, available: true), ShoeSize(size: 47, available: false), ShoeSize(size: 48, available: false)
    ], liked: false, description: "Works best for guards with regular or narrow feet."),
    Shoe(name: "Nike Lebron 15 Low", price: "$153.00", primaryImage: "lebron-15-low", inspectImages: ["lebron-15-low-1", "lebron-15-low-2", "lebron-15-low-3", "lebron-15-low-4"], sizes: [
        ShoeSize(size: 46, available: true), ShoeSize(size: 47.5, available: true), ShoeSize(size: 48, available: true), ShoeSize(size: 48.5, available: false), ShoeSize(size: 49, available: false), ShoeSize(size: 49.5, available: true), ShoeSize(size: 50, available: false), ShoeSize(size: 51, available: false)
    ], liked: false, description: "Great shoe for explosive and heavier players."),
]
