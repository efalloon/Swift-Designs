//
//  ViewController.swift
//  Transport App
//
//  Created by Euan Traynor on 1/1/2022.
//

import UIKit

class MapTagCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var tagLabel: UILabel!
    @IBOutlet weak var tickImageViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var tickImageViewRightConstraint: NSLayoutConstraint!
}
let mapTags: [String] = ["Scoot", "Bike", "Drive", "Eat", "Flowers", "Gifts"]
var currentSelectedMapTag: Int? = nil

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mapTags.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MapTagCollectionViewCell", for: indexPath) as! MapTagCollectionViewCell
        
        cell.tagLabel.text = mapTags[indexPath.row]
        
        if currentSelectedMapTag != nil && indexPath.row == currentSelectedMapTag {
            cell.backgroundColor = UIColor(hexString: "#191919")
            cell.tickImageViewRightConstraint.constant = 8
            cell.tickImageViewWidthConstraint.constant = 18
            cell.tagLabel.textColor = .white
        } else {
            cell.backgroundColor = UIColor(hexString: "#DBDBDB")
            cell.tickImageViewRightConstraint.constant = 0
            cell.tickImageViewWidthConstraint.constant = 0
            cell.tagLabel.textColor = UIColor(hexString: "#191919")
        }
        
        cell.layer.cornerRadius = cell.frame.height / 2
        cell.layer.cornerCurve = .continuous
        cell.clipsToBounds = true
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if currentSelectedMapTag != indexPath.row {
            currentSelectedMapTag = indexPath.row
            collectionView.reloadData()
        } else {
            currentSelectedMapTag = nil
            collectionView.reloadData()
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if currentSelectedMapTag != nil && indexPath.row == currentSelectedMapTag {
            return CGSize(width: mapTags[indexPath.item].size(withAttributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14, weight: .regular)]).width + 50, height: 32)
        }
        return CGSize(width: mapTags[indexPath.item].size(withAttributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14, weight: .regular)]).width + 30, height: 32)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
}

extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}
