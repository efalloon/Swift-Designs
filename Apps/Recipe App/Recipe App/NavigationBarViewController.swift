//
//  NavigationBarViewController.swift
//  Recipe App
//
//  Created by Euan Traynor on 1/1/2022.
//

import UIKit

class NavigationBarCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var navImageView: UIImageView!
}
let navImageNames: Array<String> = ["house.fill", "bookmark.fill", "bag.fill", "person.fill"]
var currentNavIndex: Int = 0

class NavigationBarViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        collectionView.isScrollEnabled = false
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return navImageNames.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NavigationBarCollectionViewCell", for: indexPath) as! NavigationBarCollectionViewCell
        
        cell.navImageView.image = UIImage(systemName: navImageNames[indexPath.row])
        if indexPath.row == currentNavIndex {
            cell.navImageView.tintColor = .label
        } else {
            cell.navImageView.tintColor = .placeholderText
        }
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        currentNavIndex = indexPath.row
        collectionView.reloadData()
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 50, height: 50)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 35, bottom: 0, right: 35)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return ((collectionView.frame.width - 70) - CGFloat(50 * navImageNames.count)) / CGFloat(navImageNames.count - 1)
    }
}
