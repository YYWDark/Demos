//
//  ViewController.swift
//  Day_01
//
//  Created by wyy on 2017/5/31.
//  Copyright © 2017年 wyy. All rights reserved.
//

import UIKit
/*
 Type 'ViewController' does not conform to protocol 'UITableViewDataSource'
 以上的错误是因为没有实现协议里面的Requred方法
 */
class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    fileprivate var dataArrays:[Product]?
    fileprivate var cellID = "cellID"
    fileprivate var tableView:UITableView?

    override func viewDidLoad() {
        super.viewDidLoad()
        //数据源
        dataArrays = [
            Product.init(name: "1907 Wall Set 1", cellImageName: "image-cell1", fullScreenImageName: "phone-fullscreen1"),
            Product.init(name: "1907 Wall Set 2", cellImageName: "image-cell1", fullScreenImageName: "phone-fullscreen1"),
            Product.init(name: "1907 Wall Set 3", cellImageName: "image-cell1", fullScreenImageName: "phone-fullscreen1"),
            Product.init(name: "1907 Wall Set 4", cellImageName: "image-cell1", fullScreenImageName: "phone-fullscreen1"),
        ]
        
       //视图
        self.tableView = UITableView.init(frame: CGRect.init(x: 0, y: 0, width: self.view.bounds.size.width, height: self.view.bounds.size.height), style: .plain)
        self.tableView?.dataSource = self
        self.tableView?.delegate = self
        self.tableView?.register(ProductCell.classForCoder(), forCellReuseIdentifier: cellID)
        self.view .addSubview(self.tableView!)
        
    }

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArrays?.count  ?? 0
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! ProductCell
        let product = dataArrays?[indexPath.row]
        cell .setProduct(product: product!)
        return cell;
    }

}

