//
//  LoginViewController.swift
//  LoginIOS
//
//  Created by Jair Rillo Junior on 12/29/15.
//  Copyright © 2015 Jair Rillo Junior. All rights reserved.
//

import UIKit
import SwiftyJSON

class LoginViewController: UIViewController {
    
    var loginForm:LoginFormTableViewController?
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var lblLoading: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // ------- DO LOGIN METHODS ---------- //
    private func doLoginSuccess(jsonResult: JSON) -> Void {
        btnLogin.enabled = true;
        lblLoading.hidden = true;
        MessageUtil.showMessage(title: "Good News", withMessage: "Your credentials are OK. Welcome " + jsonResult["name"].stringValue, into: self)
    }
    
    private func doLoginFailure(errorMessage: String) -> Void {
        btnLogin.enabled = true;
        lblLoading.hidden = true;
        MessageUtil.showMessage(title: "Error", withMessage: errorMessage, into: self)
    }
    
    @IBAction func doLogin(sender: UIButton) {
        //Validation
        if (loginForm!.txtUsername.text!.isEmpty) {
            MessageUtil.showMessage(title: "Error", withMessage: "Please, type your Username", into: self)
            return;
        }
        if (loginForm!.txtPassword.text!.isEmpty) {
            MessageUtil.showMessage(title: "Error", withMessage: "Please, type your Password", into: self)
            return;
        }
        btnLogin.enabled = false;
        lblLoading.hidden = false;
        //Create the Model object
        let user = User()
        user.username = loginForm!.txtUsername.text!
        user.password = loginForm!.txtPassword.text!
        //Call the Service layer in a different thread
        let loginService = LoginService()
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            loginService.authenticateUser(user, successCallback: self.doLoginSuccess, errorCallback: self.doLoginFailure)
        }
    }
    
    // -- DO OPEN PRIVACY POLICY Methods ---- //
    
    @IBAction func doOpenPrivacyPolicy(sender: UIButton) {
        MessageUtil.showMessage(title: "Privacy Policy", withMessage: "Under Development !!", into: self)
    }


    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "loginSegue" {
            self.loginForm = segue.destinationViewController as? LoginFormTableViewController
        }
        
    }

}
