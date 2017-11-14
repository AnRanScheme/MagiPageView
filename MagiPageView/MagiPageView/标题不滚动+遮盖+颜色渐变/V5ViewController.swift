//
//  V5ViewController.swift
//  MagiPageView
//
//  Created by 安然 on 2017/11/13.
//  Copyright © 2017年 MacBook. All rights reserved.
//

import UIKit

class V5ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // 这个是必要的设置
        // automaticallyAdjustsScrollViewInsets = false
        
        var style = SegmentStyle()
        // 标题不滚动, 则每个label会平分宽度
        style.isScrollTitle = false
        // 遮盖
        style.isShowCover = false
        style.isShowLine = true
        // 颜色渐变
        style.isGradualChangeTitleColor = true
        style.scrollLineWidth = 60
        // 遮盖颜色
        style.coverBackgroundColor = UIColor.lightGray
        let childVcs = setChildVcs()
        let titles = childVcs.map { $0.title! }
        
        let scrollPageView = MagiPageView(frame: CGRect(x: 0,
                                                        y: 64,
                                                        width: view.bounds.size.width,
                                                        height: view.bounds.size.height - 64),
                                          segmentStyle: style,
                                          titles: titles,
                                          childVcs: childVcs,
                                          parentViewController: self)
        view.addSubview(scrollPageView)
    }
    
    func setChildVcs() -> [UIViewController] {
        
        let vc1 = Chaild1ViewController()
        vc1.title = "国内头条"
        
        let vc2 = UIViewController()
        vc2.view.backgroundColor = UIColor.green
        vc2.title = "国际要闻"

        
        return [vc1, vc2]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
