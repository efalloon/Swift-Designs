//
//  NavigationViewController.swift
//  Event Tickets
//
//  Created by Euan Traynor on 23/11/2021.
//

import UIKit

let navItems: Array<String> = ["house", "magnifyingglass", "ticket", "person"]

class NavigationCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var iconImageView: UIImageView!
}

class NavigationViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var navigationBackdrop: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationBackdrop.layer.cornerRadius = 20
        navigationBackdrop.layer.cornerCurve = .continuous
//        collectionView.isScrollEnabled = false
        collectionView.isScrollEnabled = false
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return navItems.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NavigationCollectionViewCell", for: indexPath) as! NavigationCollectionViewCell
        
        cell.iconImageView.image = UIImage(systemName: navItems[indexPath.row])
//        cell.backgroundColor = .red
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 65, height: 65)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return (collectionView.frame.width - CGFloat(navItems.count * 65) - 30) / CGFloat(navItems.count - 1)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
    }
}
