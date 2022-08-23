//
//  AnchorModel.swift
//  ZB_project01
//
//  Created by tcl on 2022/8/18.
//

import HandyJSON
class AnchorModel: HandyJSON{
    //房间号
    var room_id: String = ""
    
    //显示的图片
    var vertical_src: String = ""
    
    //所用设备
    var isVertical: Int = 0
    
    //房间名
    var room_name: String = ""
    
    //昵称
    var nickname: String = ""
    
    //在线人数
    var online:Int = 0
    
    //所在城市
    var anchor_city = ""
    required init(){
        
    }
}
