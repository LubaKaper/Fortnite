//
//  DetailViewController.swift
//  Unit3-PersonalProject-Fortnite
//
//  Created by Liubov Kaper  on 1/5/20.
//  Copyright © 2020 Luba Kaper. All rights reserved.
//

import UIKit
import SafariServices

class DetailViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
    
    
    @IBOutlet weak var rarityLabel: UILabel!
    
    var shopItem: Item?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
       // createGradientView()
        
        
    }
    
    override func viewDidLayoutSubviews() {
           super.viewDidLayoutSubviews()
           
           createGradientView()
           
       }
    
    func updateUI() {
        //updateTime()
        guard let item = shopItem else {
            fatalError("check prepare for segue")
        }
        
        navigationItem.title = "SHOP"
        view.backgroundColor = .black
        nameLabel.text = item.name
        nameLabel.textColor = .systemBlue
        priceLabel.text = "Price: \(item.vBucks.description)"
        priceLabel.textColor = .systemBlue
        rarityLabel.text = "Rarity: \(item.rarity)"
        rarityLabel.textColor = .systemBlue
        imageView.getImage(with: item.imageUrl) { (result) in
            switch result {
            case .failure(let appError):
                print("error: \(appError)")
            case .success(let image):
                DispatchQueue.main.async {
                    self.imageView.image = image
                }
            }
        }
    }
    
  
    
    @IBAction func openURL(_ sender: UIButton) {
        guard let url = URL(string: "https://fnbr.co/shop") else {
            return
        }
        let safariVC = SFSafariViewController(url: url)
        present(safariVC, animated: true, completion: nil)
        safariVC.delegate = self
    }
    
    let gradient = CAGradientLayer()
    var gradientSet = [[CGColor]]()
    var currentGradient: Int = 0
    
    let colorOne = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).cgColor
    let colorTwo = #colorLiteral(red: 1, green: 0.1543237567, blue: 0, alpha: 1) .cgColor// #colorLiteral(red: 0.5405164957, green: 0.001436236314, blue: 0.5435551405, alpha: 1).cgColor
    let colorThree = #colorLiteral(red: 0, green: 1, blue: 0, alpha: 1).cgColor//#colorLiteral(red: 1, green: 0.3984297812, blue: 1, alpha: 1).cgColor
    let colorFour = #colorLiteral(red: 0, green: 0.789275229, blue: 1, alpha: 1).cgColor//#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1).cgColor
    
    func createGradientView() {
        gradientSet.append([colorOne, colorTwo])
        gradientSet.append([colorTwo, colorThree])
        gradientSet.append([colorThree, colorFour])
        gradientSet.append([colorFour, colorThree])
        gradientSet.append([colorThree, colorTwo])
        gradientSet.append([colorTwo, colorOne])
        
        gradient.frame = self.view.bounds
        gradient.colors = gradientSet[currentGradient]
        gradient.startPoint = CGPoint(x:0, y:1)
        gradient.endPoint = CGPoint(x:0, y:1)
        gradient.drawsAsynchronously = true
        
        self.view.layer.insertSublayer(gradient, at: 0)
        animateGradient()
    
    }
    func animateGradient() {
        // cycle through all the colors, feel free to add more to the set
        if currentGradient < gradientSet.count - 1 {
            currentGradient += 1
        } else {
            currentGradient = 0
        }
        
        // animate over 3 seconds
        let gradientChangeAnimation = CABasicAnimation(keyPath: "colors")
        gradientChangeAnimation.duration = 2.0
        gradientChangeAnimation.toValue = gradientSet[currentGradient]
        gradientChangeAnimation.fillMode = CAMediaTimingFillMode.forwards
        gradientChangeAnimation.isRemovedOnCompletion = false
        gradientChangeAnimation.delegate = self
        gradient.add(gradientChangeAnimation, forKey: "gradientChangeAnimation")
    }
    
    
}

extension DetailViewController: SFSafariViewControllerDelegate {
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
}

extension DetailViewController: CAAnimationDelegate {
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if flag {
            gradient.colors = gradientSet[currentGradient]
            animateGradient()
        }
    }
    
}
