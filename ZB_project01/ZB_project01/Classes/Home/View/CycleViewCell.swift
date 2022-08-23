//
//  CycleModelCell.swift
//  ZB_project01
//
//  Created by tcl on 2022/8/22.
//

import UIKit
import SnapKit

class CycleViewCell: UICollectionViewCell {
    var cycleModel: CycleViewModel? {
        didSet{
            setUI()
        }
    }
    var imageView: UIImageView = UIImageView()
    var label: UILabel = UILabel()
}

extension CycleViewCell{
    func setUI(){
        NetWorkTools.loadWebImage(urlString: cycleModel!.pic_url, defaultImage: "Img_default", imageView: self.imageView)
        imageView.frame = self.bounds
        self.addSubview(imageView)
        
        label.textColor = UIColor.white
        
        let para = NSMutableParagraphStyle()
        para.firstLineHeadIndent = 18
        label.attributedText = NSMutableAttributedString(string: cycleModel!.title, attributes: [.paragraphStyle : para])
        
        label.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
        self.addSubview(label)
        label.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets.init(top: kCycleViewH-30, left: 0, bottom: 0, right: 0))
        }
        
    }
}
