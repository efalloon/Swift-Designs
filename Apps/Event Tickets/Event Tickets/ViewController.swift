//
//  ViewController.swift
//  Event Tickets
//
//  Created by Euan Traynor on 17/11/21.
//

import UIKit

class EventsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var eventImageView: UIImageView!
    @IBOutlet weak var eventLabel: UILabel!
}

class EventTableViewCell: UITableViewCell {
    @IBOutlet weak var groupingBackdrop: UIView!
    @IBOutlet weak var eventImage: UIImageView!
    @IBOutlet weak var eventNameLabel: UILabel!
    @IBOutlet weak var eventDateLabel: UILabel!
    @IBOutlet weak var gradientView: GradientView!
}

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.tag = 2
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 75, right: 0)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return upcomingEvents.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EventsCollectionViewCell", for: indexPath) as! EventsCollectionViewCell
        
        let item = upcomingEvents[indexPath.row]
        
        cell.eventImageView.image = UIImage(named: item.image)
        if item.transparent == false {
            cell.eventImageView.layer.cornerRadius = cell.eventImageView.frame.height / 2
            cell.eventImageView.layer.cornerCurve = .continuous
        } else {
            cell.eventImageView.layer.cornerRadius = 0
        }
        cell.eventLabel.text = item.title
        
        cell.layer.cornerRadius = 25
        cell.layer.cornerCurve = .continuous
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: 115)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 25, bottom: 0, right: 25)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentEvents.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventTableViewCell", for: indexPath) as! EventTableViewCell
        
        let item = currentEvents[indexPath.row]
        
        cell.gradientView.backgroundColor = .clear
        cell.eventNameLabel.text = item.title.capitalized
        cell.eventDateLabel.text = item.date.capitalized
        cell.eventImage.image = UIImage(named: "\(indexPath.row + 1)")
        cell.groupingBackdrop.layer.cornerRadius = 25
        cell.groupingBackdrop.layer.cornerCurve = .continuous
        cell.groupingBackdrop.clipsToBounds = true
        
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 390
    }
//    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
//        if scrollView.tag == 2 {
//            var indexPos = Int(Double(scrollView.contentOffset.y / (425 / 2)).rounded(.down))
////            indexPos = indexPos.rounded(.down)
//            print(scrollView.contentOffset.y / (425 / 2))
//            print(indexPos)
//            if indexPos >= currentEvents.count {
//                indexPos = currentEvents.count - 1
//            } else if indexPos < 0 {
//                indexPos = 0
//            }
//
//            self.tableView.scrollToRow(at: IndexPath(row: indexPos, section: 0), at: .top, animated: true)
//        }
//    }
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
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.clear.cgColor, UIColor.black.withAlphaComponent(0.35).cgColor, UIColor.black.withAlphaComponent(0.75).cgColor]
    }
}
