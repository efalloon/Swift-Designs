//
//  RecipeInspectionViewController.swift
//  Recipe App
//
//  Created by Euan Traynor on 1/1/2022.
//

import UIKit

struct Ingredient {
    let title: String
    let emoji: String
    let quantity: String
}
let recipeIngredients: Array<Ingredient> = [
    Ingredient(title: "Matcha", emoji: "🍵", quantity: "1 teaspoon"), Ingredient(title: "Rice Bowl", emoji: "🍙", quantity: "200 gr"), Ingredient(title: "Salmon", emoji: "🥩", quantity: "400 gr"), Ingredient(title: "Onion", emoji: "🧅", quantity: "100 gr"), Ingredient(title: "Other", emoji: "🍣", quantity: "unknown"), Ingredient(title: "Other", emoji: "🍣", quantity: "unknown"), Ingredient(title: "Other", emoji: "🍣", quantity: "unknown"), Ingredient(title: "Other", emoji: "🍣", quantity: "unknown"), Ingredient(title: "Other", emoji: "🍣", quantity: "unknown"), Ingredient(title: "Other", emoji: "🍣", quantity: "unknown"), Ingredient(title: "Other", emoji: "🍣", quantity: "unknown"), Ingredient(title: "Other", emoji: "🍣", quantity: "unknown")
]

class IngredientsTableViewCell: UITableViewCell {
    @IBOutlet weak var backdropView: UIView!
    @IBOutlet weak var emojiBackdrop: UIView!
    @IBOutlet weak var emojiLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
}

class RecipeInspectionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var moreButtonBackdrop: UIView!
    @IBOutlet weak var backArrowBackdrop: UIView!
    @IBOutlet weak var previewVideoBackdrop: UIView!
    @IBOutlet weak var previewVideoImageView: UIImageView!
    @IBOutlet weak var previewPlayBackdrop: UIView!
    @IBOutlet weak var startCookBackdrop: UIView!
    @IBOutlet weak var servingButtonBackdrop: GradientView!
    
    @IBAction func exitButtonAction(_ sender: Any) {
        dismissDetail()
    }
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        dismissDetail()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
        
        moreButtonBackdrop.layer.cornerRadius = moreButtonBackdrop.frame.height / 2
        moreButtonBackdrop.layer.cornerCurve = .continuous
        backArrowBackdrop.layer.cornerRadius = backArrowBackdrop.frame.height / 2
        backArrowBackdrop.layer.cornerCurve = .continuous
        
        previewVideoBackdrop.layer.cornerRadius = 27.5
        previewVideoBackdrop.layer.cornerCurve = .continuous
        previewVideoBackdrop.clipsToBounds = true
        
        startCookBackdrop.layer.cornerRadius = 27.5
        startCookBackdrop.layer.cornerCurve = .continuous
        startCookBackdrop.clipsToBounds = true
        
        servingButtonBackdrop.layer.cornerRadius = 12.5
        servingButtonBackdrop.layer.cornerCurve = .continuous
        servingButtonBackdrop.clipsToBounds = true
        
        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterialDark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = previewPlayBackdrop.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        previewPlayBackdrop.addSubview(blurEffectView)
        previewPlayBackdrop.sendSubviewToBack(blurEffectView)
        previewPlayBackdrop.backgroundColor = .clear
        
        previewPlayBackdrop.layer.cornerRadius = previewPlayBackdrop.frame.height / 2
        previewPlayBackdrop.layer.cornerCurve = .continuous
        previewPlayBackdrop.clipsToBounds = true
        
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 75, right: 0)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipeIngredients.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "IngredientsTableViewCell", for: indexPath) as! IngredientsTableViewCell
        
        let item = recipeIngredients[indexPath.row]
        
        cell.quantityLabel.text = item.quantity
        cell.titleLabel.text = item.title
        cell.emojiLabel.text = item.emoji
        
        cell.backdropView.layer.cornerRadius = 22.5
        cell.backdropView.layer.cornerCurve = .continuous
        
        cell.emojiBackdrop.layer.cornerRadius = 22.5
        cell.emojiBackdrop.layer.cornerCurve = .continuous
        
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 95
    }
}
