//
//  ViewController.swift
//  FirebaseDemo
//
//  Created by aluno on 17/09/20.
//  Copyright © 2020 CESAR School. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

class ViewController: UIViewController {
    
    @IBOutlet weak var guadLogin: GIDSignInButton!
    @IBOutlet weak var labelLogin: UILabel!
    @IBOutlet weak var titulo: UILabel!
    
    var userName : String?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        GIDSignIn.sharedInstance().presentingViewController = self
        GIDSignIn.sharedInstance().delegate = self
        
        // ...

            labelLogin.text = getLogin()
            titulo.text = "ÚLTIMO LOGIN"
        

        
    }
        
        
    func getLogin() -> String{
        let preferences = UserDefaults.standard
        if preferences.string(forKey: "login_token") != nil{
            let login_token = preferences.string(forKey: "login_token")
            return login_token!
        } else {
            return ""
        }
    }

}

extension ViewController: GIDSignInDelegate{
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let userName = user?.profile.name {
            saveLastLogin(loginToken: userName)
        }
    }
    
    func saveLastLogin(loginToken: String?){
        let preferences = UserDefaults.standard
        print("saveLoginToken : \(loginToken!)")
        preferences.set(loginToken, forKey: "login_token")
        // Checking the preference is saved or not
        didSave(preferences: preferences)
        labelLogin.text = loginToken
    }
    
    func didSave(preferences: UserDefaults){
        let didSave = preferences.synchronize()
        if !didSave{
            print("Preferences could not be saved!")
        }
    }
}
