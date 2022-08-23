//
//  HomeController.swift
//  ZB_project01
//
//  Created by tcl on 2022/8/15.
//

import UIKit

private let kTitleBarH: CGFloat = 40

class HomeController: UIViewController {
    
    // MARK: - 懒加载属性
    lazy var childVCs: [UIViewController] = {[weak self] in
        var VCS = [UIViewController]()
        VCS.append(RecommendViewController())
        VCS.append(GameViewController())
        for index in 0..<2 {
            let vc = UIViewController()
            vc.view.frame = (self?.view.frame)!
            if(index == 0){
                vc.view.backgroundColor = UIColor.purple
            }
            else if(index == 1){
                vc.view.backgroundColor = UIColor.red
            }
            else if(index == 2){
                vc.view.backgroundColor = UIColor.blue
            }
            else{
                vc.view.backgroundColor = UIColor.green
            }
            VCS.append(vc)
        }
        return VCS
    }()
    lazy var homePageTitleView: PageTitleView = {[weak self] in
        let titleViewFram = CGRect(x: 0, y: kNavigationBarH, width: kScreenW, height: kTitleBarH)
        let titles = ["推荐","游戏","娱乐","趣玩"]
        let pageTitleView = PageTitleView(frame: titleViewFram, titiles: titles)
        pageTitleView.delegate = self!
        return pageTitleView
    }()
    
    lazy var homePageContentView: PageContentView = {[weak self] in
        let homePageContentViewFrame = CGRect(x: 0, y: kNavigationBarH+kTitleBarH, width: kScreenW, height: (self?.view.frame.height)! - (kNavigationBarH+kTitleBarH+kTabBarH))
        let homePageContentView = PageContentView(frame: homePageContentViewFrame, childVCs: childVCs, parentVC: self!)
        homePageContentView.delegate = self!
        return homePageContentView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Do any additional setup after loading the view.
        setUI()
        
    }
    
}

//尽量使用extension对单独的模块进行划分

//设置homeController UI界面
extension HomeController{
    private func setUI(){
        setNavigationBar()
        self.view.addSubview(homePageTitleView)
        self.view.addSubview(homePageContentView)
    }
    
    //设置导航栏
    private func setNavigationBar(){
        
        //设置leftBarButtonItem
        navigationItem.leftBarButtonItem = UIBarButtonItem(imagePath: "logo")
        
        //设置rightBarButtonItem
        let historyItem = UIBarButtonItem(imagePath:"image_my_history", highLightImagePath: "Image_my_history_click")
        let searchItem = UIBarButtonItem(imagePath: "btn_search", highLightImagePath: "btn_search_clicked")
        let qrcodeItem = UIBarButtonItem(imagePath: "Image_scan", highLightImagePath: "Image_scan_click")
        navigationItem.rightBarButtonItems = [qrcodeItem,historyItem,searchItem]
        
    }
    
    
}

//遵循协议
extension HomeController: PageTitleViewDelegate{
    
    func pageTitleView(titleView: PageTitleView,index: Int){
        homePageContentView.changeContentView(index: index)
        
    }
}

//遵循协议
extension HomeController: PageContentViewDelegate{
    func pageContentView(pageContentView: PageContentView, progress: CGFloat, souceIndex: Int, targetIndex: Int){
        self.homePageTitleView.scrollChangeBar(progress: progress, souceIndex: souceIndex, targetIndex: targetIndex)
    }
}
