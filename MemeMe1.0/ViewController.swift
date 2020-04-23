//
//  ViewController.swift
//  MemeMe1.0
//
//  Created by Jonathan Miranda on 4/20/20.
//  Copyright © 2020 Jonathan Miranda. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    // MARK: - Properties
    
    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    
    @IBOutlet weak var topToolBar: UIToolbar!
    @IBOutlet weak var bottonToolbar: UIToolbar!
    
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var cancelButoon: UIBarButtonItem!
    
    // MARK: - Setting customs textfield attributes
    
    let memeTextAttribute: [NSAttributedString.Key: Any] = [
        NSAttributedString.Key.strokeColor: UIColor(named: "txtColor")!,
        NSAttributedString.Key.foregroundColor: UIColor(named: "strokeColor")!,
        NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSAttributedString.Key.strokeWidth: 5.0
    ]
    
    let textFieldMemeDelegate = TextFieldMemeDelegate()
    
    // MARK: - Life cycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        suscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubcribeFromKeyboardNotifications()
    }
    
    // MARK: - Invoking ImagePicker

    @IBAction func pickAnImage(_ sender: Any) {
        let imagePicker = configureImagePicker(.photoLibrary)
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    @IBAction func pickAnImageFromCamera(_ sender: Any) {
        let imagePicker = configureImagePicker(.camera)
        present(imagePicker, animated: true, completion: nil)
    }
    
    func configureImagePicker(_ source: UIImagePickerController.SourceType) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = source
        return imagePicker
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            imagePickerView.image = image
            shareButton.isEnabled = true
        }
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Managing keyboard notification
    
    func suscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func unsubcribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if self.bottomTextField.isEditing {
            view.frame.origin.y -= getKeyboardHeight(notification)
        }
        
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        if self.bottomTextField.isEditing {
            view.frame.origin.y = 0
        }
    }
    
    func getKeyboardHeight(_ notification: Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
    }
    
    // MARK: - Sharing meme action
    
    @IBAction func shareMeme(_ sender: Any) {
        
        let memedImage = generateMemedImage()
        
        let activity = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
        activity.completionWithItemsHandler = { activity, completed, returnItems, activityError in
            if completed {
                print("shared successful")
                self.save()
                return
            } else {
                print("shared cancelled")
            }
            if let activityError = activityError {
                print("there is a error: \(activityError.localizedDescription)")
            }
        }
        present(activity, animated: true)
        
        
    }
    
    
    @IBAction func cancelMeme(_ sender: Any) {
        configureUI()
    }
    
    
    func generateMemedImage() -> UIImage {
        
        
        self.topToolBar.isHidden = true
        self.bottonToolbar.isHidden = true
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        
        self.topToolBar.isHidden = false
        self.bottonToolbar.isHidden = false
        
        return memedImage
    }
    
    func save() {
            // Create the meme
        let memeImaged = generateMemedImage()
        let meme = Meme(topText: topTextField.text!, bottomText: bottomTextField.text!, originalImage: imagePickerView.image!, memedImage: memeImaged)
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        appDelegate.memes.append(meme)
        
    }
    
    // MARK: - Configuring UI
    
    func configureUI() {
        topTextField.defaultTextAttributes = memeTextAttribute
        bottomTextField.defaultTextAttributes = memeTextAttribute
        
        topTextField.text = "TOP"
        topTextField.delegate = textFieldMemeDelegate
        topTextField.textAlignment = .center
        
        
        bottomTextField.text = "BOTTOM"
        bottomTextField.delegate = textFieldMemeDelegate
        bottomTextField.textAlignment = .center
        
        imagePickerView.image = nil
        shareButton.isEnabled = false
    }
    
    
    
}






