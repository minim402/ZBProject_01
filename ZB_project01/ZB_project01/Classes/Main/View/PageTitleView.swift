//
//  PageTitleView.swift
//  ZB_project01
//
//  Created by tcl on 2022/8/16.
//
//封装标题工具栏

import UIKit

let kscrollLineH: CGFloat = 2
let kTitleBarLineH: CGFloat = 0.5

//MARK: - 定义协议
//利用代理实现PageTitleView和PageContentVeiw之间的信息交互
protocol PageTitleViewDelegate: class{
    func pageTitleView(titleView: PageTitleView,index: Int)
}

class PageTitleView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    //MARK: - 定义属性
    var titles = [String]()
    var labels = [UILabel]()
    var currentIndex: Int = 0
    weak var delegate: PageTitleViewDelegate?
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        
        scrollView.showsHorizontalScrollIndicator = false   //跟踪显示指示器
        scrollView.scrollsToTop = false
        scrollView.bounces = false
//        scrollView.contentInsetAdjustmentBehavior = .scrollableAxes
        return scrollView
    }()
    
    lazy var scrollLine: UIView = {
        let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor.orange
        
        let firstLabel = labels.first
        firstLabel?.textColor = UIColor.orange
        scrollLine.frame = CGRect(x:firstLabel!.frame.origin.x , y: frame.height-kscrollLineH-kTitleBarLineH, width: firstLabel!.frame.width, height: kscrollLineH)
        
        return scrollLine
    }()
    
    init(frame: CGRect,titiles: [String]) {
        self.titles = titiles
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: - 设置UI界面
extension PageTitleView{
    func setUI(){
        //1、要设置一个scrollView 2、在scrollView中添加label 3、设置scrollLine和底部的tiltleBarLine
        scrollView.frame = bounds
        addSubview(scrollView)
        setLableUI()
        setLineUI()
        
    }
    
    //设置label
    func setLableUI(){
        
        let kLableH: CGFloat = frame.height-kscrollLineH-kTitleBarLineH
        let kLableY: CGFloat = 0
        let kLableW: CGFloat = frame.width / CGFloat(titles.count)
        for (index,title) in titles.enumerated(){
            let label = UILabel()
            
            //设置label属性
            label.text = title
            label.tag = index
            label.textColor = UIColor.gray
            label.textAlignment = .center
            label.font = UIFont.systemFont(ofSize: 14.0)
            
            //给label添加手势，使它能响应点击事件
            label.isUserInteractionEnabled = true
            let tapGes = UITapGestureRecognizer(target: self, action: #selector(labelOnClick(tapGes:)))
            label.addGestureRecognizer(tapGes)
            
            //设置label尺寸
            let kLableX: CGFloat = kLableW * CGFloat(index)
            label.frame = CGRect(x: kLableX, y: kLableY, width: kLableW, height: kLableH)
            scrollView.addSubview(label)
            labels.append(label)
            
            
        }
    }
    
    //设置scrollLine和titleBarLine
    func setLineUI(){
        
        let titleBarLine = UIView()
        titleBarLine.frame = CGRect(x: 0, y: frame.height-kTitleBarLineH, width: frame.width, height: kTitleBarLineH)
        titleBarLine.backgroundColor = UIColor.gray
        addSubview(titleBarLine)
        scrollView.addSubview(scrollLine)
        
        
    }
}

//MARK: - 点击事件响应
extension PageTitleView{
    @objc func labelOnClick(tapGes: UITapGestureRecognizer){
        //1、改变字体颜色
        let currentLabel = labels[tapGes.view!.tag]
        let oldLabel = labels[currentIndex]
        currentLabel.textColor = UIColor.orange
        oldLabel.textColor = UIColor.gray
        
        //2、改变滑块
        let scrollLineX = CGFloat(currentLabel.tag) * scrollLine.frame.width
        UIView.animate(withDuration: 0.15) { [self] in
            scrollLine.frame.origin.x = scrollLineX
        }
        //3、更新保存的下标
        currentIndex = tapGes.view!.tag
        
        //4、通知代理
        delegate?.pageTitleView(titleView: self, index: currentIndex)
        
    }
}


//MARK: - 对外暴露方法
extension PageTitleView{
    func scrollChangeBar(progress: CGFloat, souceIndex: Int, targetIndex: Int){
        
        let souceLabel = labels[souceIndex]
        let targetLabel = labels[targetIndex]
        let OffsetX = targetLabel.frame.origin.x - souceLabel.frame.origin.x
        
        scrollLine.frame.origin.x = OffsetX*progress + souceLabel.frame.origin.x
        
        labels[souceIndex].textColor = UIColor.gray
        labels[targetIndex].textColor = UIColor.orange
        currentIndex = targetIndex
        
    }
}
