//
//  ViewController.swift
//  Nike Shoe App
//
//  Created by Euan Traynor on 16/11/21.
//

import Hero
import UIKit

var selectedPreviewIndex: Int? = nil

class ShoePreviewTableViewCell: UITableViewCell {
    @IBOutlet weak var backdrop: UIView!
    @IBOutlet weak var shoeImageView: UIImageView!
    @IBOutlet weak var shoeNameLabel: UILabel!
    @IBOutlet weak var shoePriceLabel: UILabel!
    @IBOutlet weak var likeButtonImageView: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    @IBAction func likeButtonAction(_ sender: UIButton) {
        if shoesArray[sender.tag].liked == false {
            shoesArray[sender.tag].liked = true
        } else {
            shoesArray[sender.tag].liked = false
        }
        NotificationCenter.default.post(name: NSNotification.Name("refreshTable"), object: nil)

    }
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var shoppingCartBackdrop: UIView!
    @IBOutlet weak var secondaryNavigationBarBackdrop: UIView!
    @IBOutlet weak var secondaryNavigationBarBackdropHeightConstraint: NSLayoutConstraint!
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        shoppingCartBackdrop.layer.cornerRadius = shoppingCartBackdrop.frame.height / 2
        shoppingCartBackdrop.layer.cornerCurve = .continuous
        
//        secondaryNavigationBarBackdrop.layer.masksToBounds = true
//        secondaryNavigationBarBackdrop.layer.cornerRadius = 35
//        secondaryNavigationBarBackdrop.layer.cornerCurve = .continuous
//        secondaryNavigationBarBackdrop.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        
        NotificationCenter.default.addObserver(self, selector: #selector(refreshTable(notification:)), name: NSNotification.Name(rawValue: "refreshTable"), object: nil)
    }
    
    @objc func refreshTable(notification: NSNotification) {
        tableView.reloadData()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoesArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShoePreviewTableViewCell", for: indexPath) as! ShoePreviewTableViewCell
        
        let item = shoesArray[indexPath.row]
        
        cell.shoeImageView.heroID = item.primaryImage
        cell.shoeImageView.image = UIImage(named: item.primaryImage)
        cell.shoeNameLabel.heroID = "name-\(item.primaryImage)"
        cell.shoeNameLabel.text = item.name.capitalized
        cell.shoePriceLabel.heroID = "price-\(item.primaryImage)"
        cell.shoePriceLabel.text = item.price
        
        cell.likeButton.tag = indexPath.row
        if item.liked == true {
            UIView.transition(with: cell.likeButtonImageView, duration: 0.25, options: .transitionCrossDissolve, animations: {
                cell.likeButtonImageView.image = UIImage(systemName: "heart.fill")
            }, completion: nil)
        } else {
            UIView.transition(with: cell.likeButtonImageView, duration: 0.25, options: .transitionCrossDissolve, animations: {
                cell.likeButtonImageView.image = UIImage(systemName: "heart")
            }, completion: nil)
        }
        
        cell.backdrop.heroID = "backdropPreview-\(indexPath.row)"
        cell.backdrop.layer.cornerRadius = 35
        cell.backdrop.layer.cornerCurve = .continuous
        
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
        selectedPreviewIndex = indexPath.row
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ShoeInspectionViewController") as! ShoeInspectionViewController
        self.present(vc, animated: true, completion: nil)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 265
    }
    
    var secondaryNavHidden: BooleanLiteralType = false
    private var lastContentOffset: CGFloat = 0
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (self.lastContentOffset > scrollView.contentOffset.y) {
            // move up
            if secondaryNavHidden == true {
                let newHeight = 115 - (scrollView.contentOffset.y / 3)
                if 0...115 ~= (scrollView.contentOffset.y / 3) {
                    secondaryNavigationBarBackdropHeightConstraint.constant = newHeight
                } else if (scrollView.contentOffset.y / 3) < 0 {
                    secondaryNavHidden = false
                }
            }
        }
        else if (self.lastContentOffset < scrollView.contentOffset.y) {
           // move down
            let newHeight = 115 - (scrollView.contentOffset.y / 3)
            if 0...115 ~= (scrollView.contentOffset.y / 3) {
                secondaryNavigationBarBackdropHeightConstraint.constant = newHeight
            } else if (scrollView.contentOffset.y / 3) > 115 {
                secondaryNavHidden = true
            }
        }
        self.lastContentOffset = scrollView.contentOffset.y
    }
//    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//        if scrollView.contentOffset.y <= (115 / 2) {
//            scrollView.setContentOffset(.zero, animated: true)
//        } else if scrollView.contentOffset.y > (115 / 2) {
//            scrollView.setContentOffset(CGPoint(x: 0, y: 115), animated: true)
//        }
//    }
//    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
//        if (scrollView.contentOffset.y / 3) <= (115 / 2) {
//            secondaryNavigationBarBackdropHeightConstraint.constant = 0
////            scrollView.setContentOffset(.zero, animated: true)
//        } else if (scrollView.contentOffset.y / 3) > (115 / 2) {
//            secondaryNavigationBarBackdropHeightConstraint.constant = 115
////            scrollView.setContentOffset(CGPoint(x: 0, y: 115), animated: true)
//        }
//    }
}

