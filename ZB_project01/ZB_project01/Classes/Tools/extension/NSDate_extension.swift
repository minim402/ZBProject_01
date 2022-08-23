//
//  NSData_extension.swift
//  ZB_project01
//
//  Created by tcl on 2022/8/18.
//

import UIKit

extension NSDate{
    class func getCurrentTime() -> String{
        let date = NSDate()
        let n = Int(date.timeIntervalSince1970)
        return "\(n)"
    }
}
