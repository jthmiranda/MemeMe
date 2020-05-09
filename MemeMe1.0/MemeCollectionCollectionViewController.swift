//
//  MemeCollectionCollectionViewController.swift
//  MemeMe1.0
//
//  Created by Jonathan Miranda on 4/30/20.
//  Copyright © 2020 Jonathan Miranda. All rights reserved.
//

import UIKit

private let reuseIdentifier = "MemeCollectionCell"

class MemeCollectionCollectionViewController: UICollectionViewController {
    
    var memes: [Meme] {
        let appDelegate = UIApplication.shared.delegate
        let object = appDelegate as! AppDelegate
        return object.memes
    }

    @IBOutlet var memeCollectionView: UICollectionView!
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let space: CGFloat = 2.0
        let dimension = (view.frame.size.width - (2  * space)) / 3.0
        
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSize(width: dimension, height: dimension)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
        memeCollectionView.reloadData()
    }

    // MARK: UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MemeCollectionViewCell
    
        // Configure the cell
        let meme = memes[(indexPath as NSIndexPath).row]
        cell.memeImageView.image = meme.originalImage
        
        cell.topMemeText.attributedText = NSAttributedString(string: meme.topText, attributes: Meme.memeLabelAttribute)
        cell.topMemeText.textAlignment = .center
        cell.topMemeText.adjustsFontSizeToFitWidth = true
        
        cell.botomMemeText.attributedText = NSAttributedString(string: meme.bottomText, attributes: Meme.memeLabelAttribute)
        cell.botomMemeText.textAlignment = .center
        cell.botomMemeText.adjustsFontSizeToFitWidth = true
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = self.storyboard?.instantiateViewController(identifier: "MemeDetail") as! MemeDetailViewController
        let image = memes[(indexPath as NSIndexPath).row].memedImage
        controller.image = image
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
}
