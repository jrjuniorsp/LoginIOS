//
//  MessageUtil.swift
//  LoginIOS
//
//  Created by Jair Rillo Junior on 12/29/15.
//  Copyright © 2015 Jair Rillo Junior. All rights reserved.
//

import UIKit

class MessageUtil: NSObject {
    
    static func showMessage(title title: String, withMessage message:String, into viewController: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        let alertAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alert.addAction(alertAction)
        viewController.presentViewController(alert, animated: true, completion: nil)
    }

}
