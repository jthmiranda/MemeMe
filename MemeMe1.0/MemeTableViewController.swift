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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .done, target: self, action: #selector(MemeTableViewController.showMemeEditor))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.memeTableView.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.memes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemeCell") as! MemeCellView
        let meme = self.memes[(indexPath as NSIndexPath).row]
        
        cell.memeImageView.image = meme.memedImage
        cell.topText.text = meme.topText
        cell.bottonText.text = meme.bottomText
        
        return cell
    }
 
//    @objc func showMemeEditor() {
//        let memeEditorControler = self.storyboard?.instantiateViewController(identifier: "MemeEditor") as! MemeEditorViewController
//        present(memeEditorControler, animated: true)
//    }
}
