//
//  RecommendViewController.swift
//  ZB_project01
//
//  Created by tcl on 2022/8/17.
//首页推荐页面

import UIKit

private let kSpacing: CGFloat = 10
private let itemW: CGFloat = (kScreenW - 3*kSpacing)/2
private let itemH: CGFloat = itemW*3/4
private let itemPrettyH: CGFloat = itemW*4/3
private let cellNormalId = "cellNormalId"
private let cellPrettyId = "cellPrettyId"
private let SectionHeaderId = "SectionHeaderId"
private let sectionHeaderW: CGFloat = kScreenW
private let sectionHeaderH: CGFloat = 44
let kCycleViewH: CGFloat = kScreenW*3/8
let kGameViewH: CGFloat = 90

class RecommendViewController: UIViewController {
    
    // MARK: - 懒加载属性
    lazy var recommenViewModel: RecommenViewModel = RecommenViewModel()
    
    lazy var recommenCycleView :RecommenCycleView = {
        let cycleViewFrame = CGRect(x: 0, y: -(kCycleViewH + kGameViewH), width: kScreenW, height: kCycleViewH)
        let recommenCycleView = RecommenCycleView(frame: cycleViewFrame)
        return recommenCycleView
    }()
    
    lazy var gameRecommenView: GameRecommenView = {
        let frame = CGRect(x: 0, y: -kGameViewH, width: kScreenW, height: kGameViewH)
        let gameRecommenView = GameRecommenView(frame: frame)
        return gameRecommenView
    }()
    
    lazy var collectionView: UICollectionView = {[weak self] in
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kSpacing
        layout.headerReferenceSize = CGSize(width: sectionHeaderW, height: sectionHeaderH)
        layout.sectionInset = UIEdgeInsets(top: 0, left: kSpacing, bottom: 0, right: kSpacing)
        
        let collectionView = UICollectionView(frame: self!.view.bounds, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellNormalId)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellPrettyId)
        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeaderId)
        collectionView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        
        collectionView.addSubview(recommenCycleView)
        collectionView.addSubview(gameRecommenView)
        
        collectionView.contentInset = UIEdgeInsets(top: kCycleViewH + kGameViewH, left: 0, bottom: 0, right: 0)
        
        return collectionView
    }()
    
    
    // MARK: - 系统调用的回掉函数
    override func viewDidLoad() {
        super.viewDidLoad()
        //设置UI界面
        setUI()
        //发送网络请求
        requestData()
        
    }
    
}

//MARK: -发送网络请求
extension RecommendViewController{
    func requestData(){
        //请求推荐数据
        recommenViewModel.requestData {
            //展示推荐数据
            self.collectionView.reloadData()
            
            //展示游戏推荐数据
            self.gameRecommenView.gameData = self.recommenViewModel.recommenAnchorGroup
            
        }
        recommenViewModel.requestCycleData {
            self.recommenCycleView.cycleModes = self.recommenViewModel.cycleModes
        }
    }
}

// MARK: - 设置UI界面
extension RecommendViewController{
    func setUI(){
        view.addSubview(collectionView)
    }
}

// MARK: - 委托协议和数据源协议
extension RecommendViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return recommenViewModel.recommenAnchorGroup.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let group = recommenViewModel.recommenAnchorGroup[section]
        return group.room_list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //1、取出模型
        let group = recommenViewModel.recommenAnchorGroup[indexPath.section]
        let cellContent = group.room_list[indexPath.item]
        
        
        if(indexPath.section == 1){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellPrettyId, for: indexPath)
            for view in cell.contentView.subviews{
                view.removeFromSuperview()
            }
            
            let cellView = PrettyCellView(frame: cell.contentView.bounds, address: cellContent.anchor_city, userName: cellContent.nickname, numberOfMan: "\(cellContent.online)",imagePath: cellContent.vertical_src)
            cell.contentView.addSubview(cellView)
            
            return cell
        }
        
        
        //要获取cell，需要先注册cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellNormalId, for: indexPath)
        
        for view in cell.contentView.subviews{
            view.removeFromSuperview()
        }
        
        let cellView = NormalCellView(frame: cell.contentView.bounds, iconPath: "home_live_cate_normal", labelText: cellContent.room_name, userName:  cellContent.nickname, imagePath: cellContent.vertical_src, bntTitle: "\(cellContent.online)")
        cell.contentView.addSubview(cellView)
        
        return cell
    }
  
    //设置节头
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let anchorGroup = recommenViewModel.recommenAnchorGroup[indexPath.section]
        
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeaderId, for: indexPath)
        
        for view in headerView.subviews{
            view.removeFromSuperview()
        }
        
        let collectionHeaderView = CollectionHeaderView(frame: headerView.bounds, imagePath: anchorGroup.icon_url, title: anchorGroup.tag_name)
        
        headerView.addSubview(collectionHeaderView)
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if(indexPath.section == 1){
            return CGSize(width: itemW, height: itemPrettyH)
        }
        return CGSize(width: itemW, height: itemH)
    }
    
    
    
}
