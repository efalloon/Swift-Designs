//
//  CoffeeInspectionViewController.swift
//  Starbucks
//
//  Created by Euan Traynor on 31/12/2021.
//

import UIKit
import Hero

struct PaperCupSize {
    let title: String
    let reductionValue: CGFloat
}
let paperCups: [PaperCupSize] = [PaperCupSize(title: "Short", reductionValue: 30), PaperCupSize(title: "Tall", reductionValue: 20), PaperCupSize(title: "Grande", reductionValue: 10), PaperCupSize(title: "Venti", reductionValue: 0)]
var paperCupSelectionIndex: Int = 2

class PaperCupSizeCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var cupLabel: UILabel!
    @IBOutlet weak var cupImageView: UIImageView!
    @IBOutlet weak var cupImageViewTopConstraint: NSLayoutConstraint!
}

class CoffeeInspectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var panelBackdrop: UIView!
    @IBOutlet weak var quantitySubtractButton: UIButton!
    @IBOutlet weak var quantityAddButton: UIButton!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var coffeeImageView: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var tallyCount: Int = 1
    @IBAction func subtractAction(_ sender: Any) {
        if tallyCount != 1 {
            let generator = UIImpactFeedbackGenerator(style: .light)
            generator.impactOccurred()
            tallyCount -= 1
            quantityLabel.text = "\(tallyCount)"
        }
    }
    @IBAction func addAction(_ sender: Any) {
        if tallyCount != 12 {
            let generator = UIImpactFeedbackGenerator(style: .light)
            generator.impactOccurred()
            tallyCount += 1
            quantityLabel.text = "\(tallyCount)"
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        coffeeImageView.image = UIImage(named: coffeeArray[currentSelectedCoffeeIndex!].imageName)
        coffeeImageView.hero.id = "coffee-index-\(currentSelectedCoffeeIndex!)"
        
        quantitySubtractButton.layer.cornerRadius = quantitySubtractButton.frame.height / 2
        quantitySubtractButton.layer.cornerCurve = .continuous
        quantityAddButton.layer.cornerRadius = quantityAddButton.frame.height / 2
        quantityAddButton.layer.cornerCurve = .continuous
        addButton.layer.cornerRadius = addButton.frame.height / 2
        addButton.layer.cornerCurve = .continuous
        
        panelBackdrop.layer.cornerRadius = 50
        panelBackdrop.layer.cornerCurve = .continuous
        panelBackdrop.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        collectionView.isScrollEnabled = false
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeDown.direction = .down
        self.view.addGestureRecognizer(swipeDown)
    }
    
    @objc func handleGesture(gesture: UISwipeGestureRecognizer) {
       if gesture.direction == .right || gesture.direction == .down {
            dismiss(animated: true, completion: nil)
       }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
          return .lightContent
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return paperCups.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PaperCupSizeCollectionViewCell", for: indexPath) as! PaperCupSizeCollectionViewCell
        
        let item = paperCups[indexPath.row]
        
        cell.cupImageViewTopConstraint.constant = item.reductionValue
        
        cell.cupLabel.text = item.title.capitalized
        
        cell.cupLabel.layer.cornerRadius = cell.cupLabel.frame.height / 2
        cell.cupLabel.layer.cornerCurve = .continuous
        cell.cupLabel.clipsToBounds = true
        
        if indexPath.row == paperCupSelectionIndex {
            cell.cupLabel.backgroundColor = UIColor(hexString: "#183C32")
            cell.cupLabel.textColor = .white
        } else {
            cell.cupLabel.backgroundColor = .clear
            cell.cupLabel.textColor = .black
        }
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
        paperCupSelectionIndex = indexPath.row
        collectionView.reloadData()
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width - CGFloat((paperCups.count - 1) * 10)) / CGFloat(paperCups.count), height: 175)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
}
