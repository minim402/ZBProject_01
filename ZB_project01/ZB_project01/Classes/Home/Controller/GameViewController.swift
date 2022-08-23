//
//  GameViewController.swift
//  ZB_project01
//
//  Created by tcl on 2022/8/23.
//

import UIKit
import SnapKit

private let kEdgeMargin: CGFloat = 10
private let kItemW: CGFloat = (kScreenW - 2 * kEdgeMargin) / 3
private let kItemH: CGFloat = kItemW * 6 / 5
private let GamecellId = "GamecellId"
private let SectionId = "SectionId"

class GameViewController: UIViewController {
    private lazy var gameViewModel = GameViewModel()
    lazy var recommenViewModel: RecommenViewModel = RecommenViewModel()
    lazy var gameRecommenView: GameRecommenView = {
        let frame = CGRect(x: 0, y: -kGameViewH, width: kScreenW, height: kGameViewH)
        let gameRecommenView = GameRecommenView(frame: frame)
        return gameRecommenView
    }()
    lazy var collectionView: UICollectionView = {[unowned self] in
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: kEdgeMargin, bottom: 0, right: kEdgeMargin)
        layout.headerReferenceSize = CGSize(width: kScreenW, height: 44)
        
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.register(GameViewCell.self, forCellWithReuseIdentifier: GamecellId)
        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionId)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.addSubview(gameRecommenView)
        collectionView.contentInset = UIEdgeInsets(top: kGameViewH, left: 0, bottom: 0, right: 0)
        
        return collectionView
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        loaddata()
    }

}

//MARK: -设置UI界面
extension GameViewController{
    func setUI(){
        self.view.addSubview(collectionView)
    }
}

//MARK: -发送网络请求
extension GameViewController{
    func loaddata(){
        gameViewModel.requestdata {
            self.collectionView.reloadData()
        }
        recommenViewModel.requestData {
            //展示推荐数据
            self.collectionView.reloadData()
            
            //展示游戏推荐数据
            self.gameRecommenView.gameData = self.recommenViewModel.recommenAnchorGroup
            
        }
    }
}

//MARK: -collectionView的数据源协议以及代理协议
extension GameViewController: UICollectionViewDelegate,UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gameViewModel.games.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GamecellId, for: indexPath) as! GameViewCell
        cell.game = gameViewModel.games[indexPath.item]
        
        
        return cell
    }
    
    //设置节头
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let sectionView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionId, for: indexPath)
        let label = UILabel()
        label.text = "更多"
        label.textColor = UIColor.gray
        sectionView.addSubview(label)
        label.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0))
        }
        sectionView.backgroundColor = UIColor.systemGray5
        return sectionView
    }
}
