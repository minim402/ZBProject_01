//
//  RecommenViewModel.swift
//  ZB_project01
//
//  Created by tcl on 2022/8/18.
//
//发送网络请求的ViewModel

import UIKit
import HandyJSON

class RecommenViewModel: NSObject {
    
    lazy var recommenAnchorGroup: [AnchorGroup] = [AnchorGroup]()
    lazy var cycleModes: [CycleViewModel] = [CycleViewModel]()
    private lazy var anchorGroup: AnchorGroup = AnchorGroup()
    private lazy var anchorPrettyGroup: AnchorGroup = AnchorGroup()
    
}

//MARK: -发送网络请求
extension RecommenViewModel{
    
    //  请求推荐数据
    func requestData(finishCallback:@escaping()->()){
        
        let parameters = ["limit" : "4", "offset" : "0", "time" : NSDate.getCurrentTime()]
        
        //创建group
        let group = DispatchGroup()
        
        //1、请求第一份推荐数据
        group.enter()
        NetWorkTools.requestData(
            type: .GET,
            url: "http://capi.douyucdn.cn/api/v1/getbigDataRoom",
            parametes: ["time" : NSDate.getCurrentTime()]) { [unowned self] responderResult in
                if let json = try? JSONSerialization.jsonObject(with: responderResult as! Data){
                    let jsonDic = json as! Dictionary<String, Any>
                    let Arr: Array = jsonDic["data"] as! Array<Dictionary<String, Any>>
                    for data in Arr{
                        
                        if let anchor = JSONDeserializer<AnchorModel>.deserializeFrom(dict: data as? Dictionary){
                            self.anchorGroup.room_list.append(anchor)
                            self.anchorGroup.tag_name = "热门"
                            self.anchorGroup.icon_url = "home_header_hot"
                            
                        }
                    }
                }
                group.leave()
            }
        
        
        //2、请求第二部分颜值数据
        group.enter()
        NetWorkTools.requestData(
            type: .GET,
            url: "http://capi.douyucdn.cn/api/v1/getVerticalRoom",
            parametes: parameters) { [self] responderResult in
                if let json = try? JSONSerialization.jsonObject(with: responderResult as! Data){
                    let jsonDic = json as! Dictionary<String, Any>
                    let Arr: Array = jsonDic["data"] as! Array<Dictionary<String, Any>>
                    for data in Arr{
                        
                        if let anchorPretty = JSONDeserializer<AnchorModel>.deserializeFrom(dict: data as? Dictionary){
                            anchorPrettyGroup.room_list.append(anchorPretty)
                            anchorPrettyGroup.tag_name = "颜值"
                            anchorPrettyGroup.icon_url = "home_header_phone"
                            
                        }
                    }
                }
                group.leave()
        }
       
        
        //3、请求之后的所有数据
        group.enter()
        NetWorkTools.requestData(
            type: .GET,
            url: "http://capi.douyucdn.cn/api/v1/getHotCate",
            parametes: parameters) { responderResult in
                
                if let json = try? JSONSerialization.jsonObject(with: responderResult as! Data){
                //1、先取出数组 2、再做解析
                    let jsonDic = json as! Dictionary<String, Any>
                    let Arr: Array = jsonDic["data"] as! Array<Dictionary<String, Any>>
                    for data in Arr{
                        if let anchorGroup = JSONDeserializer<AnchorGroup>.deserializeFrom(dict: data as? Dictionary){
                            self.recommenAnchorGroup.append(anchorGroup)
                            
                        }
                    }
                }
                group.leave()
            }
        
        //对请求到的数据进行排序
        group.notify(queue: DispatchQueue.main) {
            self.recommenAnchorGroup.insert(self.anchorPrettyGroup, at: 0)
            self.recommenAnchorGroup.insert(self.anchorGroup, at: 0)
            
            finishCallback()
        }
    }
    
    //请求无限轮博数据
    func requestCycleData(finishCallback:@escaping()->()){
        NetWorkTools.requestData(type: .GET, url: "http://www.douyutv.com/api/v1/slide/6", parametes: ["version" : "2.300"]) { responderResult in
            if let json = try? JSONSerialization.jsonObject(with: responderResult as! Data){
                let jsonDic = json as! Dictionary<String, Any>
                let Arr: Array = jsonDic["data"] as! Array<Dictionary<String, Any>>
                
                for data in Arr{
                    if let cycleViewData = JSONDeserializer<CycleViewModel>.deserializeFrom(dict: data as Dictionary){
                        self.cycleModes.append(cycleViewData)
                    }
                }
                finishCallback()
            }
        }
        
    }


}
