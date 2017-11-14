//
//  V6ViewController.swift
//  MagiPageView
//
//  Created by 安然 on 2017/11/13.
//  Copyright © 2017年 MacBook. All rights reserved.
//

import UIKit

class V6ViewController: UIViewController {
    
    var titleTopView: SegmentView!
    
    var contentView: MagiContentView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let titles = setChildVcs().map { (childVC) -> String in
            childVC.title ?? ""
        }
        
        var style = SegmentStyle()
        // 标题不滚动, 则每个label会平分宽度
        style.isScrollTitle = false
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
        
        titleTopView = SegmentView(frame: CGRect(x: 0, y: 0, width: 180, height: 28),
                                  segmentStyle: style,
                                  titles: titles)
        titleTopView.backgroundColor = UIColor.red
        titleTopView.layer.cornerRadius = 14.0
        titleTopView.titleBtnOnClick = {[unowned self] (label: UILabel, index: Int) in
            self.contentView.setContentOffSet(offSet: CGPoint(x: self.contentView.bounds.size.width * CGFloat(index),
                                                              y: 0),
                                              animated: false)
            
        }
        
        navigationItem.titleView = titleTopView
        
        contentView = MagiContentView(frame: CGRect(x: 0, y: 64,
                                                    width: self.view.bounds.width,
                                                    height: self.view.bounds.height - 64),
                                           childVcs: setChildVcs(),
                                           parentViewController: self)
        contentView.delegate = self
        view.addSubview(contentView)
        
        let btn = UIButton(frame: CGRect(x: 100, y: 300, width: 100, height: 44))
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.setTitle("测试刷新", for: .normal)
        btn.addTarget(self,
                      action: #selector(reloadChildVcs),
                      for: .touchUpInside)
        view.addSubview(btn)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc func reloadChildVcs() {
        
        // 设置新的childVcs
        let vc1 = UIViewController()
        vc1.view.backgroundColor = UIColor.red
        vc1.title = "更换标题1"
        
        let vc2 = UIViewController()
        vc2.view.backgroundColor = UIColor.green
        vc2.title = "更换标题2"
        
        let newChildVcs = [vc1, vc2]
        // 设置新的标题
        let newTitles = newChildVcs.map {
            $0.title!
        }
        titleTopView.reloadTitlesWithNewTitles(newTitles)
        titleTopView.selectedIndex(selectedIndex: 0, animated: true)
        contentView.reloadAllViewsWithNewChildVcs(newChildVcs: newChildVcs)
    }
    
    func setChildVcs() -> [UIViewController]{
        let vc1 = UIViewController()
        vc1.view.backgroundColor = UIColor.blue
        vc1.title = "国内头条"
        
        let vc2 = UIViewController()
        vc2.view.backgroundColor = UIColor.green
        vc2.title = "国际头条"
        
        return [vc1, vc2]
    }

}

extension V6ViewController: MagiContentViewDelegate {
    
    var segmentView: SegmentView {
        return titleTopView
    }
    
}
