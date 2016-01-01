//
//  LoginService.swift
//  LoginIOS
//
//  Created by Jair Rillo Junior on 1/1/16.
//  Copyright © 2016 Jair Rillo Junior. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class LoginService: NSObject {
    
    func authenticateUser(user: User, successCallback: (jsonResult: JSON) -> Void, errorCallback: (errorMessage: String) -> Void) {
        Alamofire.request(.POST,
            "https://jr-login.herokuapp.com/users/authenticate/",
            parameters: ["username" : user.username!, "password": user.password!])
            .responseJSON { response in
                //Check if the URL is correct
                if (response.result.isSuccess) {
                    //Transform the result in JSON Object
                    let jsonResult = JSON(response.result.value!)
                    //Check the HTTP Status Code
                    if (response.response!.statusCode != 200) {
                        errorCallback(errorMessage: jsonResult["errorMessage"].stringValue)
                    } else {
                        successCallback(jsonResult: jsonResult)
                    }
                } else {
                    errorCallback(errorMessage: "The server is unreachable. Try again later")
                }
        }
    }

}
