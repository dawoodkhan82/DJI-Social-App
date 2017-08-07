//
//  ProfileViewController.swift
//  DJI Social
//
//  Created by Dawood Khan on 6/5/17.
//  Copyright © 2017 DJI. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet var profilePictureView: UIImageView!
    @IBOutlet var nameTextField: UITextField!
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ProfileViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        let tapPhoto = UITapGestureRecognizer(target: self, action: #selector(ProfileViewController.selectPhoto))
        profilePictureView.addGestureRecognizer(tapPhoto)
        self.nameTextField.delegate = self;
        //NotificationCenter.default.addObserver(self, selector: #selector(self.setUpProfile), name: .UIApplicationWillEnterForeground, object: nil)
        //imagePicker.delegate = self
        if (nameTextField.text?.isEmpty)! {
            nameTextField.text = "Tap to enter name"
        }
    }
    
    func selectPhoto(tap: UITapGestureRecognizer) {
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
    }
    
    override func viewDidAppear(_ animated: Bool) {
        AppUtility.lockOrientation(.portrait, andRotateTo: .portrait)
        setUpProfile()
        if (profilePictureView.image == nil) {
            profilePictureView.image = #imageLiteral(resourceName: "tap profile")
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        AppUtility.lockOrientation(.all)
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    public func setUpProfile() {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        if (delegate.profilePictureURL != nil) {
            let data = try? Data(contentsOf: delegate.profilePictureURL!)
            let profilePicture = UIImage(data: data!)
            profilePictureView.image = profilePicture
            
            let delegate = UIApplication.shared.delegate as! AppDelegate
            nameTextField.text = delegate.fullName
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            profilePictureView.contentMode = .scaleAspectFit
            profilePictureView.image = pickedImage
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
