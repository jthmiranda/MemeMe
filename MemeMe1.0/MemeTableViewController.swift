//
//  MemeTableViewController.swift
//  MemeMe1.0
//
//  Created by Jonathan Miranda on 4/28/20.
//  Copyright © 2020 Jonathan Miranda. All rights reserved.
//

import UIKit
                               
class MemeTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var memeTableView: UITableView!
    
    var memes: [Meme] {
        let appDelegate = UIApplication.shared.delegate
        let object = appDelegate as! AppDelegate
        return object.memes
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
        self.memeTableView.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.memes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemeCell") as! MemeCellView
        let meme = self.memes[(indexPath as NSIndexPath).row]
        
        cell.memeImageView.image = meme.originalImage
        cell.topText.text = meme.topText
        cell.bottonText.text = meme.bottomText
        
        cell.topImageText.attributedText = NSAttributedString(string: meme.topText, attributes: Meme.memeLabelAttribute)
//        cell.topImageText.textAlignment = .center
//        cell.topImageText.adjustsFontSizeToFitWidth = true
        cell.botoonImageText.attributedText = NSAttributedString(string: meme.bottomText, attributes: Meme.memeLabelAttribute)
//        cell.botoonImageText.textAlignment = .center
//        cell.botoonImageText.adjustsFontSizeToFitWidth = true
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "MemeDetailSegue", sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MemeDetailSegue" {
            let detailView = segue.destination as! MemeDetailViewController
            let row = (sender as! NSIndexPath).row
            let meme = self.memes[row]
            detailView.image = meme.memedImage
            
        }
    }
}
