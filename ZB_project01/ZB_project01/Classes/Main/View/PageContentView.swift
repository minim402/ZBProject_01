//
//  PageContentView.swift
//  ZB_project01
//
//  Created by tcl on 2022/8/16.
//

import UIKit

protocol PageContentViewDelegate: class{
    func pageContentView(pageContentView: PageContentView,progress: CGFloat,souceIndex: Int,targetIndex: Int)
}

private let collectionCellId = "collectionCellId"
class PageContentView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    //定义属性
    var childVCs = [UIViewController]()
    weak var parentVC: UIViewController?
    var startOffsetX: CGFloat = 0
    var delegate: PageContentViewDelegate?
    //判断是否禁止使用代理方法
    var isForbidDelegate = false
    lazy var collectionView: UICollectionView = {[weak self] in
        let collectionFrame = bounds
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0   //水平方向列与列之间的间距，或者垂直方向行间距
        layout.minimumInteritemSpacing = 0  //cell之间的间距
        layout.itemSize = bounds.size
        layout.scrollDirection = .horizontal    //滑动方向水平
        
        let collectionView = UICollectionView(frame: collectionFrame, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.delegate = self!
        collectionView.dataSource = self!
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: collectionCellId)
        
        return collectionView
    }()
    
    init(frame: CGRect,childVCs: [UIViewController],parentVC: UIViewController) {
        self.childVCs = childVCs
        self.parentVC = parentVC
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//设置UI界面
extension PageContentView{
    func setUI(){
        addSubview(collectionView)
    }
}

//实现CollectionView的数据源协议和代理协议
extension PageContentView: UICollectionViewDataSource,UICollectionViewDelegate{
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isForbidDelegate = false
        startOffsetX = scrollView.contentOffset.x
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if isForbidDelegate {return}
        
        var progress: CGFloat = 0
        var souceIndex: Int = 0
        var targetIndex: Int = 0
        let currentOffsetX = scrollView.contentOffset.x
        if(startOffsetX < currentOffsetX){
            //左滑
            progress = currentOffsetX / scrollView.bounds.width - floor(currentOffsetX / scrollView.bounds.width)
            souceIndex = Int(currentOffsetX / scrollView.bounds.width)
            targetIndex = souceIndex + 1
            if(targetIndex >= childVCs.count){
                targetIndex = childVCs.count - 1
            }
            if(currentOffsetX - startOffsetX == scrollView.bounds.width){
                progress = 1
                targetIndex = souceIndex
            }
            
        }else{
            //右滑
            progress = 1 - (currentOffsetX/scrollView.bounds.width - floor(currentOffsetX/scrollView.bounds.width))
            targetIndex = Int(currentOffsetX/scrollView.bounds.width)
            souceIndex = targetIndex + 1
            if(souceIndex >= childVCs.count ){
                souceIndex = childVCs.count - 1 
            }
        }
       
        delegate!.pageContentView(pageContentView:self,progress: progress, souceIndex: souceIndex, targetIndex: targetIndex)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVCs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:collectionCellId, for: indexPath)
        
        for view in cell.contentView.subviews{
            view.removeFromSuperview()
        }
        let childVC = childVCs[indexPath.item]
        childVC.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVC.view)
        return cell
        
    }
}

//对外暴露方法
extension PageContentView{
    func changeContentView(index: Int){
        isForbidDelegate = true
        let offsetX = collectionView.frame.width*CGFloat(index)
        collectionView.setContentOffset(CGPoint(x: offsetX, y:0), animated: false)
    }
}
