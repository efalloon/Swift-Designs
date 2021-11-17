//
//  ShoeInspectionViewController.swift
//  Nike Shoe App
//
//  Created by Euan Traynor on 16/11/21.
//

import Hero
import UIKit

class ShoeSizeCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var shoeSizeLabel: UILabel!
}

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
    
    //shoe size strip
    var selectedShoeSizeIndex: Int? = nil
    @IBOutlet weak var shoeSizeCollectionView: UICollectionView!
    
    @IBOutlet weak var shoppingCartButton: UIButton!
    @IBOutlet weak var likeButtonBackdrop: UIView!
    @IBOutlet weak var likeButtonImageView: UIImageView!
    
    @IBAction func returnButtonAction(_ sender: Any) {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
        dismiss(animated: true, completion: nil)
    }
    @IBAction func likeButtonAction(_ sender: Any) {
        if shoesArray[selectedPreviewIndex!].liked == false {
            likeButtonImageView.image = UIImage(systemName: "heart.fill")
            shoesArray[selectedPreviewIndex!].liked = true
        } else {
            likeButtonImageView.image = UIImage(systemName: "heart")
            shoesArray[selectedPreviewIndex!].liked = false
        }
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
        shoeSizeCollectionView.tag = 2
        
        shoppingCartButton.layer.cornerRadius = shoppingCartButton.frame.height / 2
        shoppingCartButton.layer.cornerCurve = .continuous
        
        likeButtonBackdrop.layer.cornerRadius = 15
        likeButtonBackdrop.layer.cornerCurve = .continuous
        likeButtonBackdrop.layer.borderWidth = 1
        likeButtonBackdrop.layer.borderColor = UIColor(white: 0.9, alpha: 1).cgColor
        
        if data!.liked == true {
            likeButtonImageView.image = UIImage(systemName: "heart.fill")
        } else {
            likeButtonImageView.image = UIImage(systemName: "heart")
        }
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
       swipeDown.direction = .down
       view.addGestureRecognizer(swipeDown)
    }
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case .right:
                print("Swiped right")
            case .down:
                let generator = UIImpactFeedbackGenerator(style: .light)
                generator.impactOccurred()
                dismiss(animated: true, completion: nil)
            case .left:
                print("Swiped left")
            case .up:
                print("Swiped up")
            default:
                break
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 0 || collectionView.tag == 1 {
            return data!.inspectImages.count + 1
        } else if collectionView.tag == 2 {
            return data!.sizes.count
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
        } else if collectionView.tag == 2 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShoeSizeCollectionViewCell", for: indexPath) as! ShoeSizeCollectionViewCell
            
            cell.shoeSizeLabel.text = String(data!.sizes[indexPath.row].size).replacingOccurrences(of: ".0", with: "").replacingOccurrences(of: ".", with: ",")
            
            if data!.sizes[indexPath.row].available == false {
                cell.backgroundColor = UIColor(white: 0.98, alpha: 1)
                cell.shoeSizeLabel.textColor = UIColor(white: 0.86, alpha: 1)
            } else if indexPath.row == selectedShoeSizeIndex {
                UIView.animate(withDuration: 0.25, animations: {
                    cell.backgroundColor = .black
                    cell.shoeSizeLabel.textColor = .white
                }, completion: nil)
            } else {
                cell.backgroundColor = UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1.0)
                cell.shoeSizeLabel.textColor = .black
            }
            
            cell.layer.cornerRadius = 15
            cell.layer.cornerCurve = .continuous
            
            return cell
        }
        return UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView.tag == 2 {
            if indexPath.row == selectedShoeSizeIndex {
                selectedShoeSizeIndex = nil
            } else {
                selectedShoeSizeIndex = indexPath.row
            }
            shoeSizeCollectionView.reloadData()
        }
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
        } else if collectionView.tag == 2 {
            return CGSize(width: 65, height: 72.5)
        }
        return CGSize(width: 50, height: 50)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView.tag == 2 {
            return 12.5
        }
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
        } else if collectionView.tag == 2 {
            return UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30)
        }
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
//    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//        <#code#>
//    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.tag == 0 {
            galleryIndexPosition = Int(ceil(scrollView.contentOffset.x / scrollView.frame.size.width))
            pagingCollectionView.reloadData()
        }
//        else if scrollView.tag == 2 {
//            if (scrollView.contentSize.width {
//                let generator = UIImpactFeedbackGenerator(style: .light)
//                generator.impactOccurred()
//            }
//            print(scrollView.contentOffset.x)
//        }
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
