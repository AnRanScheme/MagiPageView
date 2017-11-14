//
//  PageViewController.swift
//  MagiPageView
//
//  Created by 安然 on 2017/11/13.
//  Copyright © 2017年 MacBook. All rights reserved.
//

import UIKit

// MARK: - PageTableViewDelegate
protocol PageViewDelegate: class {
    func scrollViewIsScrolling(_ scrollView: UIScrollView)
}

class PageViewController: UIViewController, UIScrollViewDelegate {
   
    weak var delegate: PageViewDelegate?
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        delegate?.scrollViewIsScrolling(scrollView)
    }
    
}
