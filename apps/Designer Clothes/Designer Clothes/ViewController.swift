//
//  ViewController.swift
//  Designer Clothes
//
//  Created by Euan Traynor on 1/1/2022.
//

import UIKit

struct ProductItem {
    let title: String
    let price: String
}
let products: [ProductItem] = [
    ProductItem(title: "Logo Sport Sweat", price: "480"), ProductItem(title: "Wmns Loop Sneakers", price: "625"), ProductItem(title: "Small Falabella Tote", price: "1,160"), ProductItem(title: "Puffer Colorblock", price: "223")
]

class ProductCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
}

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCollectionViewCell", for: indexPath) as! ProductCollectionViewCell
        
        cell.productImageView.image = UIImage(named: "item-\(indexPath.row + 1)")
        cell.nameLabel.text = products[indexPath.row].title.capitalized
        cell.priceLabel.text = "$\(products[indexPath.row].price)"
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth: CGFloat = (collectionView.frame.width - 3) / 2
        let scaleValue: Float = Float(cellWidth / 185) //default size is 185x315 (wxh)
        return CGSize(width: (collectionView.frame.width - 3) / 2, height: CGFloat(315 * scaleValue))
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 30, right: 0)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 3
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
}

