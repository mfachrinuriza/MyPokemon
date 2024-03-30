//
//  BaseService.swift
//  core
//
//  Created by Muhammad Fachri Nuriza on 15/02/24.
//

import Alamofire

open class BaseService: NSObject {
    open lazy var HOST_URL: String = {
        if let path = Bundle.main.path(forResource: "Info", ofType: "plist") {
            let dictionary = NSDictionary(contentsOfFile: path)
            return dictionary!["HOST_URL"] as! String
        } else {
            return ""
        }
    }()
    
    open func showRequestData(data: Data) {
        let stringRequest = String(data: data, encoding: String.Encoding.utf8)
        Logger.printLog("stringRequest :: \(stringRequest!)")
    }
    
    open func showResponseData(data: Data?) {
        if data != nil {
            let json = try? JSONSerialization.jsonObject(with: data!, options: []) as? [String : Any]
            Logger.printLog(json)
            
            if json == nil {
                let string = String(data: data!, encoding: .utf8)
                Logger.printLog("Failed Show Response Data")
                Logger.printLog(string)
            }
        }
    }
    
    open func getHeaders() -> HTTPHeaders {
        var request = URLRequest(url: URL(string: self.HOST_URL)!)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        return request.headers
    }
}
