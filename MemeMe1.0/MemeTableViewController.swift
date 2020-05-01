//
//  MemeTableViewController.swift
//  MemeMe1.0
//
//  Created by Jonathan Miranda on 4/28/20.
//  Copyright © 2020 Jonathan Miranda. All rights reserved.
//

import UIKit
                               
class MemeTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    
    let memes = ((UIApplication.shared.delegate) as! AppDelegate).memes
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .done, target: self, action: #selector(MemeTableViewController.showMemeEditor))
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.memes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemeCell")!
        let meme = self.memes[(indexPath as NSIndexPath).row]
        cell.textLabel?.text = meme.topText
        cell.detailTextLabel?.text = meme.bottomText
        return cell
    }
 
    @objc func showMemeEditor() {
        let memeEditorControler = self.storyboard?.instantiateViewController(identifier: "MemeEditor") as! MemeEditorViewController
        present(memeEditorControler, animated: true)
    }
}
