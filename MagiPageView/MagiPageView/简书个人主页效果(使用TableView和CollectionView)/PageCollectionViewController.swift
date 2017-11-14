//
//  V7ViewController.swift
//  MagiPageView
//
//  Created by 安然 on 2017/11/13.
//  Copyright © 2017年 MacBook. All rights reserved.
//

import UIKit


class PageCollectionViewController: PageViewController {
    
    static let cellID = "cellID"
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 100.0,
                                 height: 100.0)
        let collectionView = UICollectionView(frame: self.view.bounds,
                                              collectionViewLayout: layout)
        collectionView.register(UICollectionViewCell.self,
                                forCellWithReuseIdentifier: PageCollectionViewController.cellID)

        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
    }
}

extension PageCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PageCollectionViewController.cellID, for: indexPath)
        cell.backgroundColor = UIColor.red
        return cell
    }
}
