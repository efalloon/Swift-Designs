//
//  ShoeInspectionViewController.swift
//  Nike Shoe App
//
//  Created by Euan Traynor on 16/11/21.
//

import Hero
import UIKit

class ShoeGalleryCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var shoeImageView: UIImageView!
}

class ShoeInspectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var primaryImageView: UIImageView!
    @IBOutlet weak var primaryImageBackdrop: UIView!
    @IBOutlet weak var shoeNameLabel: UILabel!
    @IBOutlet weak var shoePriceLabel: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBAction func returnButtonAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        primaryImageView.heroID = shoesArray[selectedPreviewIndex!].primaryImage
        primaryImageView.image = UIImage(named: shoesArray[selectedPreviewIndex!].primaryImage)
        
        primaryImageBackdrop.heroID = "backdropPreview-\(selectedPreviewIndex!)"
        primaryImageBackdrop.layer.cornerRadius = 50
        primaryImageBackdrop.layer.cornerCurve = .continuous
        primaryImageBackdrop.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        
        shoeNameLabel.heroID = "name-\(shoesArray[selectedPreviewIndex!].primaryImage)"
        shoeNameLabel.text = shoesArray[selectedPreviewIndex!].name
        shoePriceLabel.heroID = "price-\(shoesArray[selectedPreviewIndex!].primaryImage)"
        shoePriceLabel.text = shoesArray[selectedPreviewIndex!].price
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShoeGalleryCollectionViewCell", for: indexPath) as! ShoeGalleryCollectionViewCell
        
//        cell.shoeImageView.image = UIImage(named: <#T##String#>)
        
        return cell
    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return
//    }
}
