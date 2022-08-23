//
//  GameViewCell.swift
//  ZB_project01
//
//  Created by tcl on 2022/8/22.
//

import UIKit
import SnapKit

class GameViewCell: UICollectionViewCell {
    var gameData: AnchorGroup?{
        didSet{
            NetWorkTools.loadWebImage(urlString: gameData!.icon_url, defaultImage: "home_more_btn", imageView: imageView)
            addSubview(imageView)
            
            imageView.clipsToBounds = true
            
            imageView.snp.makeConstraints { make in
                make.edges.equalToSuperview().inset(UIEdgeInsets.init(top: 10, left: 15, bottom: 30, right: 15))
            }
            
            label.text = gameData?.tag_name
            label.font = UIFont.systemFont(ofSize: 10.0)
            label.textAlignment = .center
            addSubview(label)
            label.snp.makeConstraints { make in
                make.edges.equalToSuperview().inset(UIEdgeInsets.init(top: kGameViewH-20, left: 10, bottom: 10, right: 10))
            }
            
        }
    }
    
    var game: GameModel?{
        didSet{
            NetWorkTools.loadWebImage(urlString: game!.icon_url, defaultImage: "home_more_btn", imageView: imageView)
            addSubview(imageView)
            
            imageView.clipsToBounds = true
            
            imageView.snp.makeConstraints { make in
                make.edges.equalToSuperview().inset(UIEdgeInsets.init(top: 10, left: 15, bottom: 30, right: 15))
            }
            
            label.text = game?.tag_name
            label.font = UIFont.systemFont(ofSize: 10.0)
            label.textAlignment = .center
            addSubview(label)
            label.snp.makeConstraints { make in
                make.edges.equalToSuperview().inset(UIEdgeInsets.init(top: kGameViewH-20, left: 10, bottom: 10, right: 10))
            }
        }
    }
    
    var imageView = UIImageView()
    var label = UILabel()
    
    
}
