//
//  PrettyCellView.swift
//  ZB_project01
//
//  Created by tcl on 2022/8/17.
//
//另一种格式的Cell，竖屏幕显示

import UIKit
import SnapKit
private let itemW: CGFloat = (kScreenW - 3*10)/2
private let itemPrettyH: CGFloat = itemW*4/3
private let itemH: CGFloat = itemW*3/4
class PrettyCellView: UIView {
    
    var adress: String
    var userName: String
    var numberOfMan: String
    var imagePath: String
    init(frame: CGRect,address: String,userName: String,numberOfMan: String,imagePath: String) {
        self.adress = address
        self.userName = userName
        self.numberOfMan = numberOfMan
        self.imagePath = imagePath
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: - 设置UI界面
extension PrettyCellView{
    func setUI(){
        let addressBnt = UIButton(type: .system)
        addressBnt.setImage(UIImage(named: "ico_location"), for: .normal)
        addressBnt.setTitle(adress, for: .normal)
        addressBnt.tintColor = UIColor.systemGray4
        
        let userNameLabel = UILabel()
        userNameLabel.text = userName
        userNameLabel.textColor = UIColor.gray
        
        let imageView: UIImageView = UIImageView()
        NetWorkTools.loadWebImage(urlString: self.imagePath, defaultImage: "live_cell_default_phone", imageView: imageView)
        
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
    
        
        let numberOfMan = UILabel()
        numberOfMan.text = self.numberOfMan
        numberOfMan.textColor = UIColor.white
        numberOfMan.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
        numberOfMan.textAlignment = .center
        
        
        addSubview(addressBnt)
        addSubview(userNameLabel)
        addSubview(imageView)
        imageView.addSubview(numberOfMan)
        
        addressBnt.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-10)
            make.top.equalToSuperview().offset(itemPrettyH-40)
            make.left.equalToSuperview().offset(0)
            make.right.equalToSuperview().offset(-(itemW-80))
        }
        
        userNameLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-40)
            make.top.equalToSuperview().offset(itemPrettyH-70)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
        }
        
        imageView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-75)
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
        }
        
        numberOfMan.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-120)
            make.top.equalToSuperview().offset(5)
            make.left.equalToSuperview().offset(70)
            make.right.equalToSuperview().offset(-5)
        }
        
    }
}
