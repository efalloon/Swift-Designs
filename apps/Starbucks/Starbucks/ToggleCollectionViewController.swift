//
//  ToggleCollectionViewController.swift
//  Starbucks
//
//  Created by Euan Traynor on 31/12/2021.
//

import UIKit

class ToggleCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var toggleLabel: UILabel!
}
let toggleItemsArray: Array<String> = ["Menu", "Previous", "Favourites"]
var currentToggleIndex: Int = 0

class ToggleCollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return toggleItemsArray.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ToggleCollectionViewCell", for: indexPath) as! ToggleCollectionViewCell
        
        cell.toggleLabel.text = toggleItemsArray[indexPath.row]
        
        if indexPath.row == currentToggleIndex {
            cell.backgroundColor = UIColor(hexString: "#D4E9E2")
            cell.toggleLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        } else {
            cell.backgroundColor = UIColor.black.withAlphaComponent(0.015)
            cell.toggleLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        }
        
        cell.layer.cornerRadius = cell.frame.height / 2
        cell.layer.cornerCurve = .continuous
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
        if indexPath.row != currentToggleIndex {
            currentToggleIndex = indexPath.row
            collectionView.reloadData()
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: toggleItemsArray[indexPath.item].size(withAttributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14, weight: .semibold)]).width + 30, height: 35)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
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
