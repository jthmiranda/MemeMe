//
//  MemeDetailViewController.swift
//  MemeMe1.0
//
//  Created by Jonathan Miranda on 5/6/20.
//  Copyright © 2020 Jonathan Miranda. All rights reserved.
//

import UIKit

class MemeDetailViewController: UIViewController {
    
    var image: UIImage?
    
    @IBOutlet weak var imageDetail: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let img = image {
            imageDetail.image = img
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
     
}
