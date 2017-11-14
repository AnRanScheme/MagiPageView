//
//  V7ViewController.swift
//  MagiPageView
//
//  Created by 安然 on 2017/11/13.
//  Copyright © 2017年 MacBook. All rights reserved.
//

import UIKit

let segmentViewHeight: CGFloat = 44.0
let naviBarHeight: CGFloat  = 64.0
let headViewHeight: CGFloat  = 200.0

class CustomGestureTableView: UITableView {
    
    /// 返回true  ---- 能同时识别多个手势
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return (gestureRecognizer is UIPanGestureRecognizer) && (otherGestureRecognizer is UIPanGestureRecognizer)
    }
    
}

class V7ViewController: UIViewController {
    
    var childScrollView: UIScrollView?
    
    // 懒加载 topView
    lazy var topView: SegmentView = {[unowned self] in
        
        var style = SegmentStyle()
        
        // 颜色渐变
        style.isGradualChangeTitleColor = true
        // 遮盖
        style.isShowCover = true
        // 遮盖颜色
        style.coverBackgroundColor = UIColor.white
        
        // title正常状态颜色 使用RGB空间值
        style.normalTitleColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        // title选中状态颜色 使用RGB空间值
        style.selectedTitleColor = UIColor(red: 235.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 1.0)
        
        let titles = self.setChildVcs().map { $0.title! }
        
        let topView = SegmentView(frame: CGRect(x: 0.0, y: 0.0,
                                                width: self.view.bounds.size.width,
                                                height: segmentViewHeight),
                                  segmentStyle: style,
                                  titles: titles)
        
        topView.titleBtnOnClick = {[unowned self] (label: UILabel, index: Int) in
            self.contentView.setContentOffSet(offSet: CGPoint(x: self.contentView.bounds.size.width * CGFloat(index),
                                                              y: 0),
                                              animated: false)
            
        }
        
        topView.backgroundColor = UIColor.lightGray
        return topView
        
        }()
    
    lazy var headView: UIImageView = {
        let headView = UIImageView(frame: CGRect(x: 0.0, y: 0.0, width: self.view.bounds.size.width, height: headViewHeight))
        headView.image = UIImage(named: "fruit")
        return headView
    }()
    
    
    // 懒加载contentView
    lazy var contentView: MagiContentView = {[unowned self] in
        // 注意, 如果tableview是在storyboard中来的, 设置contentView的高度和这里不一样
        let contentView = MagiContentView(frame: CGRect(x: 0.0, y: 0.0,
                                                        width: self.view.bounds.size.width,
                                                        height: self.view.bounds.size.height - naviBarHeight - segmentViewHeight),
                                          childVcs: self.setChildVcs(),
                                          parentViewController: self)
        contentView.delegate = self // 必须实现代理方法
        return contentView
        }()
    
    // 懒加载tableView, 注意如果是从storyBoard中连线过来的,那么注意设置contentView的高度有点不一样
    // 或者在滚动的时候需要渐变navigationBar的时候,需要注意相关的tableView的frame设置和contentInset的设置
    lazy var tableView: CustomGestureTableView = {[unowned self] in
        let table = CustomGestureTableView(frame: CGRect(x: 0.0, y: naviBarHeight, width: self.view.bounds.size.width, height: self.view.bounds.size.height - naviBarHeight), style: .plain)
        table.delegate = self
        table.dataSource = self
        return table
        
        }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "简书个人主页"
        
        // 设置tableView的headView
        tableView.tableHeaderView = headView
        tableView.tableFooterView = UIView()
        // 设置cell行高为contentView的高度
        tableView.rowHeight = contentView.bounds.size.height
        // 设置tableView的sectionHeadHeight为segmentViewHeight
        tableView.sectionHeaderHeight = CGFloat(segmentViewHeight)
        tableView.showsVerticalScrollIndicator = false
        view.addSubview(tableView)
        
    }
    
    func setChildVcs() -> [UIViewController] {
        
        let titles = ["国内头条", "国际要闻", "趣事", "囧图", "明星八卦", "爱车", "国防要事", "科技频道", "手机专页"]
        var childVcs: [UIViewController] = []
        
        for (index, title) in titles.enumerated() {
            let childVc: PageViewController
            
            if index % 2 == 0 {
                childVc = PageTableViewController()
                childVc.delegate = self
            }
            else {
                childVc = PageCollectionViewController()
                childVc.delegate = self
            }
            
            childVc.title = title
            childVcs.append(childVc)
        }
        
        return childVcs
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}

extension V7ViewController: PageViewDelegate {
    
    func scrollViewIsScrolling(_ scrollView: UIScrollView) {
        /// 记录便于处理联动
        childScrollView = scrollView
        
        if tableView.contentOffset.y < headViewHeight {
            scrollView.contentOffset = CGPoint.zero
            scrollView.showsVerticalScrollIndicator = false
        }
            
        else {
            tableView.contentOffset.y = headViewHeight
            scrollView.showsVerticalScrollIndicator = true
        }
        
    }
    
}

// MARK:- UIScrollViewDelegate 这里的代理可以监控tableView的滚动, 在滚动的时候就可以做一些事情, 比如使navigationBar渐变, 或者像简书一样改变头像的属性
extension V7ViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if childScrollView?.contentOffset.y ?? 0 > 0.0 {
            tableView.contentOffset.y = headViewHeight
        }
        
    }
}

// MARK:- UITableViewDataSource UITableViewDelegate
extension V7ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cellId")
        
        cell.contentView.subviews.forEach { (subview) in
            subview.removeFromSuperview()
        }
        
        cell.contentView.addSubview(contentView)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        return topView
    }
    
}

// MARK:- ContentViewDelegate
extension V7ViewController: MagiContentViewDelegate {
    var segmentView: SegmentView {
        return topView
    }
    
    // 监控开始滚动contentView的时候, 这里将滚动条滚动至顶部(简书没有这个效果,但其他的有---这里拒绝广告)
    func contentViewDidBeginMove() {
        tableView.setContentOffset(CGPoint(x: 0.0,
                                           y: headViewHeight),
                                   animated: true)
    }
    
}

