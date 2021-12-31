//
//  ViewController.swift
//  CarbonMail
//
//  Created by Euan Traynor on 31/12/2021.
//

import UIKit

var currentNavIndex: Int = 0

struct NavItem {
    let imageName: String
    let colour: UIColor
}
let navigationItems: Array<NavItem> = [NavItem(imageName: "Folder", colour: UIColor(hexString: "#4265D6")), NavItem(imageName: "Gear", colour: UIColor(hexString: "#F2AC20")), NavItem(imageName: "Activity", colour: UIColor(hexString: "#FF0000"))]

class NavigationCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var navigationImageView: UIImageView!
}

class SubscriptionTableViewCell: UITableViewCell {
    @IBOutlet weak var backdropView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var linkLabel: UILabel!
    @IBOutlet weak var gradientBackdrop: GradientView!
    @IBOutlet weak var trashBackdrop: UIView!
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var tallyHeaderLabel: UILabel!
    @IBOutlet weak var percentileBackdrop: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var noDataMessageBackdrop: UIView!
    @IBOutlet weak var navigationCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tallyHeaderLabel.text = "Subscriptions (\(subscriptionItemArray.count))"
        
        percentileBackdrop.layer.cornerRadius = 8
        percentileBackdrop.layer.cornerCurve = .continuous
        
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 85, right: 0)
        
        navigationCollectionView.isScrollEnabled = false
        
        noDataMessageBackdrop.isHidden = true
        noDataMessageBackdrop.alpha = 0
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
          return .lightContent
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subscriptionItemArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SubscriptionTableViewCell", for: indexPath) as! SubscriptionTableViewCell
        
        let item = subscriptionItemArray[indexPath.row]
        
        cell.backdropView.layer.cornerRadius = 16
        cell.backdropView.layer.cornerCurve = .continuous
        
        cell.trashBackdrop.layer.cornerRadius = 8
        cell.trashBackdrop.layer.cornerCurve = .continuous
        
        cell.titleLabel.text = item.title.capitalized
        cell.linkLabel.text = item.link.lowercased()
        
        cell.backdropView.clipsToBounds = true
        cell.selectionStyle = .none
        return cell
    }
    
    //this action needs to be removed and the trash button instead will use the following action/s
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        subscriptionItemArray.remove(at: indexPath.row)
        tallyHeaderLabel.text = "Subscriptions (\(subscriptionItemArray.count))"
        tableView.deleteRows(at: [IndexPath(row: indexPath.row, section: 0)], with: .automatic)
        
        if subscriptionItemArray.count == 0 {
            noDataMessageBackdrop.isHidden = false
            UIView.animate(withDuration: 0.5, animations: {
                self.noDataMessageBackdrop.alpha = 1
            }, completion: nil)
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 84
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NavigationCollectionViewCell", for: indexPath) as! NavigationCollectionViewCell
        
        let item = navigationItems[indexPath.row]
        
        cell.navigationImageView.image = UIImage(named: item.imageName)
        
        if indexPath.row == currentNavIndex {
            UIView.animate(withDuration: 0.25, animations: {
                cell.navigationImageView.tintColor = item.colour
                cell.backgroundColor = item.colour.withAlphaComponent(0.2)
            }, completion: nil)
        } else {
            cell.navigationImageView.tintColor = UIColor(hexString: "#A0A0A0")
            cell.backgroundColor = .clear
        }
        
        cell.layer.cornerRadius = 8
        cell.layer.cornerCurve = .continuous
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        currentNavIndex = indexPath.row
        collectionView.reloadData()
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width - CGFloat((navigationItems.count - 1) * 5)) / CGFloat(navigationItems.count), height: 45)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

@IBDesignable public class GradientView: UIView {
    override open class var layerClass: AnyClass {
        return CAGradientLayer.classForCoder()
    }
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureGradientLayer()
    }
    public override init(frame: CGRect) {
        super.init(frame: frame)
        configureGradientLayer()
    }

    func configureGradientLayer() {
        let gradientLayer = layer as! CAGradientLayer
        gradientLayer.colors =  [UIColor.white.withAlphaComponent(0), UIColor.white.withAlphaComponent(0), UIColor.white, UIColor.white].map{$0.cgColor}
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
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
