//
//  ShoeInspectionViewController.swift
//  Nike Shoe App
//
//  Created by Euan Traynor on 16/11/21.
//

import Hero
import UIKit

class PagingCollectionViewCell: UICollectionViewCell {}

class ShoeGalleryCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var shoeImageView: UIImageView!
}

var galleryIndexPosition: Int = 0

class ShoeInspectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var data: Shoe? = nil
    
    @IBOutlet weak var primaryImageBackdrop: UIView!
    @IBOutlet weak var shoeNameLabel: UILabel!
    @IBOutlet weak var shoePriceLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    //paging control strip
    @IBOutlet weak var pagingCollectionView: UICollectionView!
    
    @IBAction func returnButtonAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        data = shoesArray[selectedPreviewIndex!]
        
        primaryImageBackdrop.heroID = "backdropPreview-\(selectedPreviewIndex!)"
        primaryImageBackdrop.layer.cornerRadius = 50
        primaryImageBackdrop.layer.cornerCurve = .continuous
        primaryImageBackdrop.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        
        shoeNameLabel.heroID = "name-\(data!.primaryImage)"
        shoeNameLabel.text = data!.name
        shoePriceLabel.heroID = "price-\(data!.primaryImage)"
        shoePriceLabel.text = data!.price
        
        collectionView.isPagingEnabled = true
        collectionView.tag = 0
        
        pagingCollectionView.tag = 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 0 {
            return data!.inspectImages.count + 1
        } else if collectionView.tag == 1 {
            return data!.inspectImages.count + 1
        }
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView.tag == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShoeGalleryCollectionViewCell", for: indexPath) as! ShoeGalleryCollectionViewCell
            if indexPath.row == 0 {
                cell.shoeImageView.heroID = data!.primaryImage
                cell.shoeImageView.image = UIImage(named: data!.primaryImage)
            } else {
                cell.shoeImageView.image = UIImage(named: data!.inspectImages[indexPath.row - 1])
            }
            return cell
        } else if collectionView.tag == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PagingCollectionViewCell", for: indexPath) as! PagingCollectionViewCell
            
            if indexPath.row == galleryIndexPosition {
                cell.backgroundColor = .black
            } else {
                cell.backgroundColor = UIColor(white: 0.85, alpha: 1)
            }
            cell.layer.cornerRadius = cell.frame.height / 2
            cell.layer.cornerCurve = .continuous
            
            return cell
        }
        return UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView.tag == 0 {
            return CGSize(width: view.frame.width, height: 150)
        } else if collectionView.tag == 1 {
            if indexPath.row == galleryIndexPosition {
                return CGSize(width: 22.5, height: 5)
            } else {
                return CGSize(width: 10, height: 5)
            }
        }
        return CGSize(width: 50, height: 50)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView.tag == 0 {
            return 0
        } else if collectionView.tag == 1 {
            return 9
        }
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView.tag == 1 {
            let totalWidth: CGFloat = (CGFloat(data!.inspectImages.count) * (10 + 9)) + 22.5
            let insetValue: CGFloat = (view.frame.width - totalWidth) / 2

            return UIEdgeInsets(top: 0, left: insetValue, bottom: 0, right: insetValue)
        }
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
//    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//        <#code#>
//    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        galleryIndexPosition = Int(ceil(scrollView.contentOffset.x / scrollView.frame.size.width))
        pagingCollectionView.reloadData()
    }
}

extension UICollectionView {
    func scrollToNearestVisibleCollectionViewCell() {
        self.decelerationRate = UIScrollView.DecelerationRate.fast
        let visibleCenterPositionOfScrollView = Float(self.contentOffset.x + (self.bounds.size.width / 2))
        var closestCellIndex = -1
        var closestDistance: Float = .greatestFiniteMagnitude
        for i in 0..<self.visibleCells.count {
            let cell = self.visibleCells[i]
            let cellWidth = cell.bounds.size.width
            let cellCenter = Float(cell.frame.origin.x + cellWidth / 2)

            // Now calculate closest cell
            let distance: Float = fabsf(visibleCenterPositionOfScrollView - cellCenter)
            if distance < closestDistance {
                closestDistance = distance
                closestCellIndex = self.indexPath(for: cell)!.row
            }
        }
        if closestCellIndex != -1 {
            self.scrollToItem(at: IndexPath(row: closestCellIndex, section: 0), at: .centeredHorizontally, animated: true)
        }
    }
}
