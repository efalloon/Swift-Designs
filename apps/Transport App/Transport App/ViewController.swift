//
//  ViewController.swift
//  Transport App
//
//  Created by Euan Traynor on 1/1/2022.
//

import UIKit

var searchFieldActive: BooleanLiteralType = false

struct SearchLocationItem {
    let title, location: String
    let iconName: String
}
let defaultSearchValues: Array<SearchLocationItem> = [SearchLocationItem(title: "Select among your favourite places", location: "...like Office", iconName: "heart"), SearchLocationItem(title: "Choose a location on the map", location: "...or share live location", iconName: "pin")]
let recentSearches: Array<SearchLocationItem> = [SearchLocationItem(title: "Office: 404 Ventures", location: "353 Semillion blv. San Francisco", iconName: "buildings"), SearchLocationItem(title: "Home", location: "41 Zinfandel str. Mountain View", iconName: "home"), SearchLocationItem(title: "Leila’s home", location: "524 North Sparrow rd. Sonoma", iconName: "heart"), SearchLocationItem(title: "GainFit Sports", location: "88 Harrison str. San Jose", iconName: "store")]

class SearchLocationTableViewCell: UITableViewCell {
    @IBOutlet weak var iconBackdrop: UIView!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var locationTitleLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
}

class MapTagCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var tagLabel: UILabel!
    @IBOutlet weak var tickImageViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var tickImageViewRightConstraint: NSLayoutConstraint!
}
let mapTags: Array<String> = ["Scoot", "Bike", "Drive", "Eat", "Flowers", "Gifts"]
var currentSelectedMapTag: Int? = 1

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var tableViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var textFieldBackdrop: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.isScrollEnabled = false
        tableViewHeightConstraint.constant = CGFloat(72 * defaultSearchValues.count)
        tableView.layer.cornerRadius = 2
        tableView.clipsToBounds = true
        textFieldBackdrop.layer.cornerRadius = 2
        
        UITextField.appearance().keyboardAppearance = UIKeyboardAppearance.dark
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        searchFieldActive = true
        tableView.reloadData()
        tableView.isScrollEnabled = true
        if tableViewBottomConstraint.constant <= 30 {
            UIView.animate(withDuration: 1, animations: { [self] in
                tableViewHeightConstraint.constant = CGFloat(72 * recentSearches.count)
                tableViewBottomConstraint.constant += 225
                view.layoutIfNeeded()
            }, completion: nil)
        }
   }
   @objc func keyboardWillHide(notification: NSNotification) {
       UIView.animate(withDuration: 1, animations: { [self] in
           tableViewHeightConstraint.constant = CGFloat(72 * defaultSearchValues.count)
           tableViewBottomConstraint.constant = 27
           view.layoutIfNeeded()
       }, completion: nil)
       searchFieldActive = false
       tableView.reloadData()
       tableView.isScrollEnabled = false
       textField.text = ""
   }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {   //delegate method
       textField.resignFirstResponder()
       return true
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchFieldActive {
            return recentSearches.count
        }
        return defaultSearchValues.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchLocationTableViewCell", for: indexPath) as! SearchLocationTableViewCell
        
        var item: SearchLocationItem? = nil
        if searchFieldActive {
            item = recentSearches[indexPath.row]
        } else {
            item = defaultSearchValues[indexPath.row]
        }
        
        cell.iconBackdrop.layer.cornerRadius = cell.iconBackdrop.frame.height / 2
        cell.iconBackdrop.layer.cornerCurve = .continuous
        cell.iconImageView.image = UIImage(named: item!.iconName)
        cell.locationTitleLabel.text = item!.title
        cell.locationLabel.text = item!.location
        
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72
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
