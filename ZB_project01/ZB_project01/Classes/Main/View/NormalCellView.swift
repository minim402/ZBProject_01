//
//  NormalCellView.swift
//  ZB_project01
//
//  Created by tcl on 2022/8/17.
//
//自定义普通Cell

import UIKit
import SnapKit

private let itemW: CGFloat = (kScreenW - 3*10)/2
private let itemH: CGFloat = itemW*3/4

class NormalCellView: UIView {
    
    var iconPath: String
    var labelText: String
    var userName: String
    var imagePath: String
    var bntTitle: String
    init(frame: CGRect,iconPath: String,labelText: String,userName: String,imagePath:String,bntTitle:String) {
        self.iconPath = iconPath
        self.labelText = labelText
        self.userName = userName
        self.imagePath = imagePath
        self.bntTitle = bntTitle
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: - 设置UI界面
extension NormalCellView{
    func setUI(){
        let iconImageView = UIImageView(image: UIImage(named: iconPath))
        
        let titleLabel = UILabel()
        titleLabel.text = labelText
        titleLabel.textColor = UIColor.systemGray4
        titleLabel.font = UIFont.systemFont(ofSize: 14.0)
        titleLabel.textAlignment = .left
        
        let userLabel = UILabel()
        userLabel.text = userName
        userLabel.textColor = UIColor.white
        userLabel.font = UIFont.systemFont(ofSize: 14.0)
        
        let bnt = UIButton(type: .system)
        bnt.setTitle(bntTitle, for: .normal)
        bnt.tintColor = UIColor.white
        
        let imageView: UIImageView = UIImageView()
        NetWorkTools.loadWebImage(urlString: self.imagePath, defaultImage: "Img_default", imageView: imageView)
        
        addSubview(iconImageView)
        addSubview(titleLabel)
        addSubview(imageView)
        imageView.addSubview(userLabel)
        imageView.addSubview(bnt)
        
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        //布局
        iconImageView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-(itemW - 10 - 20))
            make.bottom.equalToSuperview().offset(-18)
            make.top.equalToSuperview().offset(itemH - 18 - 20)
        }
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(iconImageView).offset(25)
            make.right.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview().offset(-18)
            make.top.equalToSuperview().offset(itemH - 18 - 20)
        }
        imageView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview().offset(-40)
            make.top.equalToSuperview().offset(5)
        }
        userLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(5)
            make.right.equalToSuperview().offset(-60)
            make.bottom.equalToSuperview().offset(-5)
            make.top.equalToSuperview().offset(itemH - 75)
        }
        bnt.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(80)
            make.right.equalToSuperview().offset(0)
            make.bottom.equalToSuperview().offset(-5)
            make.top.equalToSuperview().offset(itemH - 75)
        }
        
    }
}
