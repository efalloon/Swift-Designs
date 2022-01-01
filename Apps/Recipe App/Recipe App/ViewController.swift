//
//  ViewController.swift
//  Recipe App
//
//  Created by Euan Traynor on 1/1/2022.
//

import UIKit

class FoodTagCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var gradientBackdrop: GradientView!
    @IBOutlet weak var titleLabel: UILabel!
}
let foodTags: Array<String> = ["All", "Sushi", "Burger", "Pizza", "Mexican", "Vietnamese", "Christmas"]
var currentSelectedFoodTag: Int = 0

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITextFieldDelegate {

    @IBOutlet weak var bookmarkButtonBackdrop: UIView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var placeholderRecipeBackdrop: UIView!
    @IBOutlet weak var placeholderRecipeImageView: UIImageView!
    @IBOutlet weak var searchFieldBackdrop: UIView!
    @IBOutlet weak var filterButtonBackdrop: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBAction func presentRecipeAction(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "RecipeInspectionViewController") as! RecipeInspectionViewController
        presentDetail(vc)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        UITextField.appearance().keyboardAppearance = UIKeyboardAppearance.dark
        
        searchFieldBackdrop.layer.cornerRadius = 12.5
        searchFieldBackdrop.layer.cornerCurve = .continuous
        filterButtonBackdrop.layer.cornerRadius = 12.5
        filterButtonBackdrop.layer.cornerCurve = .continuous
        
        searchFieldBackdrop.layer.shadowColor = UIColor.black.cgColor
        searchFieldBackdrop.layer.shadowOpacity = 0.01
        searchFieldBackdrop.layer.shadowOffset = .zero
        searchFieldBackdrop.layer.shadowRadius = 15
        
        placeholderRecipeBackdrop.layer.cornerRadius = 27.5
        placeholderRecipeBackdrop.layer.cornerCurve = .continuous
        placeholderRecipeBackdrop.clipsToBounds = true
        
        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterialDark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = bookmarkButtonBackdrop.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        bookmarkButtonBackdrop.addSubview(blurEffectView)
        bookmarkButtonBackdrop.sendSubviewToBack(blurEffectView)
        bookmarkButtonBackdrop.backgroundColor = .clear
        
        bookmarkButtonBackdrop.layer.cornerRadius = 17.5
        bookmarkButtonBackdrop.layer.cornerCurve = .continuous
        bookmarkButtonBackdrop.clipsToBounds = true
        
        searchTextField.delegate = self
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
//        view.addGestureRecognizer(tapGesture)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {   //delegate method
        textField.resignFirstResponder()
        textField.text = ""
        return true
    }
//    @objc func hideKeyboard() {
//        view.endEditing(true)
//    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return foodTags.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FoodTagCollectionViewCell", for: indexPath) as! FoodTagCollectionViewCell
        
        cell.titleLabel.text = foodTags[indexPath.row]
        if indexPath.row == currentSelectedFoodTag {
            cell.titleLabel.textColor = .white
            cell.gradientBackdrop.alpha = 1
        } else {
            cell.titleLabel.textColor = .placeholderText
            cell.gradientBackdrop.alpha = 0
        }
        
        cell.contentView.layer.cornerRadius = 12.5
        cell.contentView.layer.cornerCurve = .continuous
        cell.contentView.clipsToBounds = true
        
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOpacity = 0.015
        cell.layer.shadowOffset = .zero
        cell.layer.shadowRadius = 15
        
        cell.clipsToBounds = false
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
        currentSelectedFoodTag = indexPath.row
        collectionView.reloadData()
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: foodTags[indexPath.item].size(withAttributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16, weight: .semibold)]).width + 70, height: 45)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 15
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
        gradientLayer.colors = [UIColor(hexString: "#33BC66").cgColor, UIColor(hexString: "#7EDD6F").cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
    }
}
@IBDesignable public class FadeGradientView: UIView {
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
        gradientLayer.colors = [UIColor(white: 0.98, alpha: 0).cgColor, UIColor(white: 0.98, alpha: 0.5).cgColor, UIColor(white: 0.98, alpha: 1).cgColor, UIColor(white: 0.98, alpha: 1).cgColor]
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

extension UIViewController {

    func presentDetail(_ viewControllerToPresent: UIViewController) {
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = CATransitionType.push
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        transition.subtype = CATransitionSubtype.fromRight
        self.view.window!.layer.add(transition, forKey: kCATransition)

        present(viewControllerToPresent, animated: false)
    }

    func dismissDetail() {
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = CATransitionType.push
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        transition.subtype = CATransitionSubtype.fromLeft
        self.view.window!.layer.add(transition, forKey: kCATransition)

        dismiss(animated: false)
    }
}
