//
//  GameCollectionView.swift
//  ZB_project01
//
//  Created by tcl on 2022/8/22.
//



import UIKit
import CoreMIDI
let cellId = "cellId"

class GameRecommenView: UIView {
    var gameData: [AnchorGroup]?{
        didSet{
            //移除前两组数据
            gameData?.removeFirst()
            gameData?.removeFirst()
            let moreGroup = AnchorGroup()
            moreGroup.tag_name = "更多"
            moreGroup.icon_url = "home_more_btn"
            gameData?.append(moreGroup)
            self.collectionView.reloadData()
        }
    }
    
    
    lazy var collectionView: UICollectionView = {[unowned self] in
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 80, height: 90)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        collectionView.register(GameViewCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        
        return collectionView
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: -设置UI界面
extension GameRecommenView{
    func setUI(){
        self.addSubview(collectionView)
    }
}

extension GameRecommenView: UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gameData?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! GameViewCell
        cell.gameData = gameData![indexPath.item]
        
        return cell
    }
}
