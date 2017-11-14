//
//  V2ViewController.swift
//  MagiPageView
//
//  Created by 安然 on 2017/11/13.
//  Copyright © 2017年 MacBook. All rights reserved.
//

import UIKit

class V2ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // 这个是必要的设置
        // automaticallyAdjustsScrollViewInsets = false
        
        var style = SegmentStyle()
        // 遮盖
        style.isShowCover = true
        // 颜色渐变
        style.isGradualChangeTitleColor = true
        // 遮盖颜色
        style.coverBackgroundColor = UIColor.lightGray
        
        let titles = setChildVcs().map { $0.title! }
        
        let scrollPageView = MagiPageView(frame: CGRect(x: 0,
                                                        y: 64,
                                                        width: view.bounds.size.width,
                                                        height: view.bounds.size.height - 64),
                                          segmentStyle: style,
                                          titles: titles,
                                          childVcs: setChildVcs(),
                                          parentViewController: self)
        view.addSubview(scrollPageView)
    }
    
    func setChildVcs() -> [UIViewController] {
        
        let vc1 = Chaild1ViewController()
        vc1.title = "国内头条"
        
        let vc2 = UIViewController()
        vc2.view.backgroundColor = UIColor.green
        vc2.title = "国际要闻"
        
        let vc3 = UIViewController()
        vc3.view.backgroundColor = UIColor.red
        vc3.title = "趣事"
        
        let vc4 = UIViewController()
        vc4.view.backgroundColor = UIColor.yellow
        vc4.title = "囧图"
        
        let vc5 = UIViewController()
        vc5.view.backgroundColor = UIColor.lightGray
        vc5.title = "明星八卦"
        
        let vc6 = UIViewController()
        vc6.view.backgroundColor = UIColor.brown
        vc6.title = "爱车"
        
        let vc7 = UIViewController()
        vc7.view.backgroundColor = UIColor.orange
        vc7.title = "国防要事"
        
        let vc8 = UIViewController()
        vc8.view.backgroundColor = UIColor.blue
        vc8.title = "科技频道"
        
        let vc9 = UIViewController()
        vc9.view.backgroundColor = UIColor.brown
        vc9.title = "手机专页"
        
        let vc10 = UIViewController()
        vc10.view.backgroundColor = UIColor.orange
        vc10.title = "风景图"
        
        let vc11 = UIViewController()
        vc11.view.backgroundColor = UIColor.blue
        vc11.title = "段子"
        
        return [vc1, vc2, vc3,vc4, vc5, vc6, vc7, vc8, vc9, vc10, vc11]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
