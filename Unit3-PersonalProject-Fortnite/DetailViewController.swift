//
//  DetailViewController.swift
//  Unit3-PersonalProject-Fortnite
//
//  Created by Liubov Kaper  on 1/5/20.
//  Copyright © 2020 Luba Kaper. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
    
    
    @IBOutlet weak var rarityLabel: UILabel!
    
    var shopItem: Item?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        
        
    }
    
    func updateUI() {
        guard let item = shopItem else {
            fatalError("check prepare for segue")
        }
        
        navigationItem.title = "SHOP"
        view.backgroundColor = .black
        nameLabel.text = item.name
        nameLabel.textColor = .systemBlue
        priceLabel.text = "Price: \(item.vBucks.description)"
        priceLabel.textColor = .white
        rarityLabel.text = "Rarity: \(item.rarity)"
        rarityLabel.textColor = .white
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
    
    
}
