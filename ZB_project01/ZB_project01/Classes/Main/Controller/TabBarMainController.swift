//
//  TabBarMainController.swift
//  ZB_project01
//
//  Created by tcl on 2022/8/15.
//

import UIKit

class TabBarMainController: UITabBarController {
    
    let VCs = [HomeController(),LiveController(),FollowController(),ProfileController()]
    let titles = ["首页","直播","关注","我的"]
    let unSelectedIcon = ["btn_home_normal","btn_column_normal","btn_live_normal","btn_user_normal"]
    let selectedIcon = ["btn_home_selected","btn_column_selected","btn_live_selected","btn_user_selected"]
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.tabBar.backgroundColor = UIColor.white
        for index in 0..<titles.count {
            let vc = VCs[index]
            if(index == 0){
                let nav = UINavigationController(rootViewController: vc)
                nav.tabBarItem.title = titles[index]
                nav.tabBarItem.image = UIImage(named: unSelectedIcon[index])
                nav.tabBarItem.selectedImage = UIImage(named: selectedIcon[index])?.withRenderingMode(.alwaysOriginal)
                addChild(nav)
            }
            else{
                vc.tabBarItem.title = titles[index]
                vc.tabBarItem.image = UIImage(named: unSelectedIcon[index])
                vc.tabBarItem.selectedImage = UIImage(named: selectedIcon[index])?.withRenderingMode(.alwaysOriginal)
                addChild(vc)
            }
        }
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}
