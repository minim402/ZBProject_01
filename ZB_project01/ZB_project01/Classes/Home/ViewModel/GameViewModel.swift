//
//  GameViewModel.swift
//  ZB_project01
//
//  Created by tcl on 2022/8/23.
//

import UIKit
import HandyJSON

class GameViewModel: NSObject {
    lazy var games: [GameModel] = [GameModel]()
    
}

extension GameViewModel{
    func requestdata(finishCallBack: @escaping()->()){
        //http://capi.douyucdn.cn/api/v1/getColumnDetail?shortName=game
        NetWorkTools.requestData(type: .GET, url: "http://capi.douyucdn.cn/api/v1/getColumnDetail") { [unowned self] responderResult in
            if let json = try? JSONSerialization.jsonObject(with: responderResult as! Data) {
                
                let jsonDic = json as! Dictionary<String,Any>
                let arr = jsonDic["data"] as! Array<Dictionary<String, Any>>
                for data in arr {
                    if let data = JSONDeserializer<GameModel>.deserializeFrom(dict: data){
                        self.games.append(data)
                    }
                }
                finishCallBack()
            }
        }
    }
}
