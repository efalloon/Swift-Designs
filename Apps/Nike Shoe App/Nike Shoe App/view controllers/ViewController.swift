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
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var shoppingCartBackdrop: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        shoppingCartBackdrop.layer.cornerRadius = shoppingCartBackdrop.frame.height / 2
        shoppingCartBackdrop.layer.cornerCurve = .continuous
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
        
        cell.backdrop.heroID = "backdropPreview-\(indexPath.row)"
        cell.backdrop.layer.cornerRadius = 35
        cell.backdrop.layer.cornerCurve = .continuous
        
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedPreviewIndex = indexPath.row
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ShoeInspectionViewController") as! ShoeInspectionViewController
        self.present(vc, animated: true, completion: nil)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 265
    }
}

