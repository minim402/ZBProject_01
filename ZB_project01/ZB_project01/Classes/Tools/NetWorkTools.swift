//
//  NetWorkTools.swift
//  ZB_project01
//
//  Created by tcl on 2022/8/18.
//
//封装第三方网络请求库，减少对第三方库的依赖，方便在第三方库不能使用时对代码进行修改

import UIKit
import Alamofire
import Kingfisher

//定义枚举类型请求方法
enum MethodType {
    case GET
    case POST
}

class NetWorkTools {
    
    class func requestData(type: MethodType,url: String,parametes: [String : String]? = nil,finishedCallback: @escaping( _ responderResult:AnyObject)->()){
        
        let method = type == .GET ? HTTPMethod.get : HTTPMethod.post
        
        AF.request(url, method: method, parameters: parametes, encoder: .urlEncodedForm).responseData { response in
            if let data = response.data {
               finishedCallback(data as AnyObject)
            }
            else
            {
                print(response.error as Any)
            }
            
        }
        
    }
}

//MARK: -封装Kingfisher 网络图片请求库
extension NetWorkTools {
    class func loadWebImage(urlString: String,defaultImage: String,imageView: UIImageView){
        let url = URL(string: urlString)
        let image = UIImage(named: defaultImage)
        imageView.kf.setImage(with: url, placeholder: image)
    }
    
}
