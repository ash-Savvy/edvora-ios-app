//
//  Constant.swift
//  Edvora
//
//  Created by TeCh_SavVy on 18/04/22.
//


import SwiftUI


let windowFrame = UIApplication.shared.delegate!.window!!.frame

let onePixel = 1.0 / UIScreen.main.scale

let window = UIApplication.shared.delegate!.window!!

let keyWindow = UIApplication.shared.connectedScenes
        .filter({$0.activationState == .foregroundActive})
        .map({$0 as? UIWindowScene})
        .compactMap({$0})
        .first?.windows
        .filter({$0.isKeyWindow}).first

let deviceID = UIDevice.current.identifierForVendor!.uuidString

let hepticGenerator = UINotificationFeedbackGenerator()
let screenWidth = UIScreen.main.bounds.width
let screenHeight = UIScreen.main.bounds.height


typealias WebServiceCompletionHandler = (_ status:Bool, _ message:String?, _ responseObject:AnyObject?, _ error:NSError?) -> ()

struct Constants {
    
    //The API's base URL

    static let baseUrl = "https://assessment.api.vweb.app/"
   
    //The parameters (Queries) that we're gonna use
    
    
    struct EndPoint {
        static let rides = "rides"
        static let user = "user"
    }
    
    //The header fields
    enum HttpHeaderField: String {
        case authentication = "Authorization"
        case contentType = "Content-Type"
        case acceptType = "Accept"
        case acceptEncoding = "Accept-Encoding"
    }
    
    //The content type (JSON)
    enum ContentType: String {
        case json = "application/json"
        case formData = "form-data"
    }
}
