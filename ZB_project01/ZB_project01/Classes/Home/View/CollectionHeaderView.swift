//
//  CollectionHeaderView.swift
//  ZB_project01
//
//  Created by tcl on 2022/8/17.
//
//自定义头部视图

import UIKit

class CollectionHeaderView: UICollectionReusableView {
    
    var imagePath: String
    var headerTitle: String
    var buttomTitle = "更多"
    init(frame: CGRect,imagePath: String,title: String,buttomTitle: String = "更多" ) {
        self.imagePath = imagePath
        self.headerTitle = title
        self.buttomTitle = buttomTitle
        super.init(frame: frame)
        setUI()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: - 设置UI界面
extension CollectionHeaderView{
    func setUI(){
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: kScreenW, height: 8))
        headerView.backgroundColor = UIColor.systemGray5
        
        self.backgroundColor = UIColor.white
//        let image = UIImage(named: imagePath)
//
//        let imageView = UIImageView(image: image)
        
        let imageURL = NSURL(string: self.imagePath)
        let imageData = try? Data(contentsOf: imageURL! as URL)
        var image: UIImage = UIImage()
        if(imageData == nil){
            image = UIImage(named: imagePath)!
        }
        else{
            image = UIImage(data: imageData! as Data)!
        }
        
        let imageView = UIImageView(image: image)
        
        imageView.frame = CGRect(x: 10, y: 10, width: 30, height: 30)
        
        let label = UILabel()
        label.text = headerTitle
        label.frame = CGRect(x: 50, y: 10, width: 100, height: 30)
        label.textColor = UIColor.gray
        
        let bnt = UIButton(type: .system)
        bnt.setTitle(buttomTitle, for: .normal)
        bnt.frame = CGRect(x: 300, y: 10, width: 50, height: 30)
        bnt.tintColor = UIColor.gray
        
        addSubview(headerView)
        addSubview(imageView)
        addSubview(label)
        addSubview(bnt)
        
        
        
    }
}
