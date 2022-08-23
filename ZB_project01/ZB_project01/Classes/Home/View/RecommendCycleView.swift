//
//  RecommendCycleView.swift
//  ZB_project01
//
//  Created by tcl on 2022/8/22.
//

import UIKit
import SnapKit
import CoreMedia

private let CycleCellId = "CycleCellId"

class RecommenCycleView: UIView {
    
    var cycleTimer: Timer?
    
    var cycleModes: [CycleViewModel]?{
        didSet{
            //刷新表格
            collectionView.reloadData()
            pageControl.numberOfPages = cycleModes?.count ?? 0
            
            //默认加载时滚动到中间的某一个位置，保证往前滚动和往后滚动有值
            let indexPath = IndexPath(item: (cycleModes?.count ?? 0)*100, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .left, animated: false)
            
            
            //添加定时器
            removeCycleTimer()
            addCycleTimer()
        }
    }
    lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        
        return pageControl
        
    }()
    
    lazy var collectionView: UICollectionView = {[unowned self] in
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = self.bounds.size
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        
        collectionView.isPagingEnabled = true
        collectionView.register(CycleViewCell.self, forCellWithReuseIdentifier: CycleCellId)
        collectionView.dataSource = self
        collectionView.delegate = self
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
extension RecommenCycleView{
    func setUI(){
        self.backgroundColor = UIColor.red
        self.addSubview(collectionView)
        self.addSubview(pageControl)
        pageControl.snp.makeConstraints({ make in
            make.edges.equalToSuperview().inset(UIEdgeInsets.init(top: kCycleViewH-40, left: kScreenW-180, bottom: 0, right: 0))
        })
    }
}


//MARK: -CollectionView数据源协议和代理协议
extension RecommenCycleView: UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return (cycleModes?.count ?? 0) * 10000
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CycleCellId, for: indexPath) as! CycleViewCell
        cell.cycleModel = self.cycleModes![indexPath.item % cycleModes!.count]
        
        return cell
    }
    
    //监听滚动
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //1、获取滚动偏移量
        let offsetX = self.collectionView.contentOffset.x + self.bounds.width * 0.5
        pageControl.currentPage = Int(offsetX/self.bounds.width) % (cycleModes?.count ?? 1)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        removeCycleTimer()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        removeCycleTimer()
        addCycleTimer()
    }
    
}

//MARK: -实现定时器的操作方法
extension RecommenCycleView{
    //添加定时器
    func addCycleTimer(){
        cycleTimer = Timer(timeInterval: 2.0, target: self, selector: #selector(scrollToNext(_ :)), userInfo: nil, repeats: true)
        RunLoop.main.add(cycleTimer!, forMode: .common)
    }
    
    //移除定时器
    func removeCycleTimer(){
        cycleTimer?.invalidate()
        cycleTimer = nil
    }
    
    //定时事件处理
    @objc func scrollToNext(_ sender: AnyObject){
        //1、获取要滚动的偏移量
        let currentOffsetX = self.collectionView.contentOffset.x
        let offsetX = currentOffsetX + self.collectionView.bounds.width
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
    }
}
