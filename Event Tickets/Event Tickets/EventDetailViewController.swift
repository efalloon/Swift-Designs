//
//  EventDetailViewController.swift
//  Event Tickets
//
//  Created by Euan Traynor on 30/12/2021.
//

import UIKit

class EventDetailViewController: UIViewController {

    @IBOutlet weak var locationBackdropView: UIView!
    @IBOutlet weak var backBackdropView: UIView!
    @IBOutlet weak var gradientView: GradientViewBackdropBlend!
    @IBOutlet weak var navigationBackdrop: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationBackdrop.layer.cornerRadius = 20
        navigationBackdrop.layer.cornerCurve = .continuous
        
        backBackdropView.layer.cornerRadius = 20
        backBackdropView.layer.cornerCurve = .continuous
        locationBackdropView.layer.cornerRadius = 20
        locationBackdropView.layer.cornerCurve = .continuous
    }
    
//    override var preferredStatusBarStyle: UIStatusBarStyle {
//        .lightContent
//    }
}

@IBDesignable public class GradientViewBackdropBlend: UIView {
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
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.clear.cgColor, UIColor(red: 241/255, green: 241/255, blue: 241/255, alpha: 0.35).cgColor, UIColor(red: 241/255, green: 241/255, blue: 241/255, alpha: 0.85).cgColor, UIColor(red: 241/255, green: 241/255, blue: 241/255, alpha: 1.0).cgColor]
    }
}
