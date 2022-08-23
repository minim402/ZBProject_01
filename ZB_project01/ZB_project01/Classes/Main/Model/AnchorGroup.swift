//
//  AnchorGroup.swift
//  ZB_project01
//
//  Created by tcl on 2022/8/18.
//

import HandyJSON
class AnchorGroup: HandyJSON{
    
    var room_list: [AnchorModel] = [AnchorModel]() 
    var tag_name: String = ""
    var icon_url: String = "home_header_normal"
    required init(){
        
    }
}
