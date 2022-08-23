//
//  UIBarButtomItem_exstension.swift
//  ZB_project01
//
//  Created by tcl on 2022/8/15.
//

import UIKit

extension UIBarButtonItem{
    //扩展构造函数有两点要求：1、只能扩展便利函数，即以关键字convenience开头  2、必须要调用一个设计函数，且只能用self调用
    
    convenience init(imagePath: String, highLightImagePath: String = "", size: CGSize = CGSize(width: 0,height: 0)){
        let bnt = UIButton()
        
        bnt.setImage(UIImage(named: imagePath), for: .normal)
        if(highLightImagePath != ""){
            bnt.setImage(UIImage(named: highLightImagePath), for: .highlighted)
        }
        
        if(size == CGSize(width: 0,height: 0)){
            bnt.sizeToFit()
        }
        else{
            bnt.frame = CGRect(origin: CGPoint(x: 0,y: 0), size: size)
        }
        self.init(customView:bnt)
    }
    
    
}
