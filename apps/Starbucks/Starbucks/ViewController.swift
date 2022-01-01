//
//  ViewController.swift
//  Starbucks
//
//  Created by Euan Traynor on 31/12/2021.
//

import UIKit
import Hero

var currentSelectedCoffeeIndex: Int? = nil

struct CoffeeItem {
    let title: String
    let imageName: String
}
let coffeeArray: [CoffeeItem] = [CoffeeItem(title: "Mocha Cookie Crumble", imageName: "Mocha-Cookie-Crumble-Frappuccino-2"), CoffeeItem(title: "Smores Frappuccino", imageName: "sbx20190429-summer-menu-smores-frappuccino.png-2")]

class CoffeeCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var coffeeImageView: UIImageView!
    @IBOutlet weak var coffeeNameLabel: UILabel!
    @IBOutlet weak var backdropView: UIView!
}

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var featuredCoffeeBackdrop: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        profileImageView.layer.cornerRadius = profileImageView.frame.height / 2
        profileImageView.layer.cornerCurve = .continuous
        profileImageView.clipsToBounds = true
        
        featuredCoffeeBackdrop.layer.cornerRadius = 25
        featuredCoffeeBackdrop.layer.cornerCurve = .continuous
        featuredCoffeeBackdrop.clipsToBounds = true
        
        collectionView.clipsToBounds = false
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return coffeeArray.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CoffeeCollectionViewCell", for: indexPath) as! CoffeeCollectionViewCell
        
        let item = coffeeArray[indexPath.row]
        
        cell.backdropView.layer.cornerRadius = 25
        cell.backdropView.layer.cornerCurve = .continuous
        
        cell.backdropView.backgroundColor = .white
        cell.backdropView.layer.shadowColor = UIColor.black.cgColor
        cell.backdropView.layer.shadowOpacity = 0.05
        cell.backdropView.layer.shadowOffset = CGSize(width: -20, height: 20)
        cell.backdropView.layer.shadowRadius = 20
        
        cell.coffeeImageView.image = UIImage(named: item.imageName)
        cell.coffeeImageView.hero.id = "coffee-index-\(indexPath.row)"
        cell.coffeeNameLabel.text = item.title.capitalized
        
        cell.clipsToBounds = false
        cell.backdropView.clipsToBounds = false
        cell.contentView.clipsToBounds = false
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        currentSelectedCoffeeIndex = indexPath.row
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "CoffeeInspectionViewController") as! CoffeeInspectionViewController
        self.present(vc, animated: true, completion: nil)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 25, bottom: 0, right: 25)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 300)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 25
    }
}

