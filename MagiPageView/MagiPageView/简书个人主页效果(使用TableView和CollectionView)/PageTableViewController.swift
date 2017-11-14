//
//  PageTableViewController.swift
//  MagiPageView
//
//  Created by 安然 on 2017/11/13.
//  Copyright © 2017年 MacBook. All rights reserved.
//

import UIKit


class PageTableViewController: PageViewController {
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: self.view.bounds,
                                    style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

// MARK: UITableViewDelegate, UITableViewDataSource - 这里测试使用, 实际使用中可以重写这些方法
extension PageTableViewController: UITableViewDelegate, UITableViewDataSource {
    // MARK: - Table view data source
    
     func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cellId")
        cell.textLabel?.text = "--------ceshishishihi\(indexPath.row)"
        
        return cell
    }
}


//// MARK: UIScrollViewDelegate - 监控tableview的滚动, 将改变通知给通知父控制器
//extension PageTableViewController: UIScrollViewDelegate {
//    func scrollViewDidScroll(scrollView: UIScrollView) {
//        delegate?.scrollViewIsScrolling(scrollView)
//    }
//}


