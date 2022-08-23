//
//  CycleViewModel.swift
//  ZB_project01
//
//  Created by tcl on 2022/8/22.
//

import UIKit
import HandyJSON
class CycleViewModel: HandyJSON {
    var title: String = ""
    var pic_url: String = ""
    var room: [AnchorModel] = [AnchorModel]()
    
    required init(){
        
    }
}
