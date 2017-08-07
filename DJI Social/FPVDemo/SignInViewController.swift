//
//  SignInViewController.swift
//  DJI Social
//
//  Created by Dawood Khan on 5/28/17.
//  Copyright © 2017 DJI. All rights reserved.
//

import UIKit
import Google
import GoogleSignIn
import FacebookLogin
import FacebookCore

class SignInViewController: UIViewController, GIDSignInUIDelegate {
    
    @IBOutlet var guestButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        roundedButton()
        
        GIDSignIn.sharedInstance().uiDelegate = self
        //Uncomment to automatically sign in the user.
        GIDSignIn.sharedInstance().signInSilently()
        
        let loginButton = LoginButton(readPermissions: [ .publicProfile ])
        loginButton.frame.size.height = 35
        loginButton.frame.size.width = 245
        loginButton.center = view.center
        view.addSubview(loginButton)
        //Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if (GIDSignIn.sharedInstance().hasAuthInKeychain() || (AccessToken.current != nil)) {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "tabBarController")
            self.present(controller, animated: true, completion: nil)
        }
    }
    
    func roundedButton() {
        guestButton.layer.cornerRadius = 10
        guestButton.clipsToBounds = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    @IBAction func didTapSignOut(sender: AnyObject) {
//        GIDSignIn.sharedInstance().signOut()
//    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
