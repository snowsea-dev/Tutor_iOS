//
//  ApiConnector.swift
//  School
//
//  Created by Admin User on 4/21/17.
//  Copyright © 2017 snowsea. All rights reserved.
//

import Foundation
import ACProgressHUD_Swift
import Alamofire

protocol ResponseDelegate {
    func response(_: DataResponse<Any>)
}

class ApiConnector {
    let baseUrl = "https://tshiamo.herokuapp.com/api/"
    // let baseUrl = "http://192.168.1.115:1337/api/"
    var credentials: String = ""
    
    func setCredentials(email: String, password: String) {
        
        let basic = "\(email):\(password)"
        let data = basic.data(using: String.Encoding.utf8)
        credentials = "Basic \(data!.base64EncodedString())"
        
    }
    
    func get(api: String, id: String, token: String, parameters: Parameters?, delegate: ResponseDelegate) {
        
        let apiUrl = baseUrl + api
        let headers: HTTPHeaders = [
            "id": id,
            "x-access-token": token
        ]
        
        Alamofire.request(apiUrl, method: .get, parameters: parameters, headers: headers)
            .validate()
            .responseJSON(completionHandler: delegate.response)
    }
    
    func postWithCredential(api: String, parameters: Parameters?, delegate: ResponseDelegate) {

        let apiUrl = baseUrl + api
        let headers: HTTPHeaders = [
            "Authorization": credentials
        ]
        
        Alamofire.request(apiUrl, method: .post, parameters: parameters, headers: headers)
            .validate()
            .responseJSON(completionHandler: delegate.response)

    }
    	
	
    func post(api: String, parameters: Parameters?, delegate: ResponseDelegate) {

        let apiUrl = baseUrl + api
        
        Alamofire.request(apiUrl, method: .post, parameters: parameters)
            .validate()
            .responseJSON(completionHandler: delegate.response)
    }
    
    func post(api: String, id: String, token: String, parameters: Parameters?, delegate: ResponseDelegate) {
        
        let apiUrl = baseUrl + api
        let headers: HTTPHeaders = [
            "id": id,
            "x-access-token": token
        ]
        
        Alamofire.request(apiUrl, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .validate()
            .responseJSON(completionHandler: delegate.response)
    }
}
