//
//  ProductCell.swift
//  Day_01
//
//  Created by wyy on 2017/5/31.
//  Copyright © 2017年 wyy. All rights reserved.
//

import UIKit

 class ProductCell: UITableViewCell {
    var cellImageView:UIImageView?
    var cellLabel:UILabel?
    var cellButton:UIButton?
//    var product:Product? {
//        willSet(newValue) {
//            if product != newValue {
//                cellImageView?.image = UIImage.init(named:(self.product?.cellImageName)!)
//                cellLabel?.text = self.product?.name
//            }
//        }
//    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style:style , reuseIdentifier:reuseIdentifier)
        cellImageView = UIImageView()
        cellImageView?.backgroundColor = UIColor.init(red: 0.75, green: 0.5, blue: 0.15, alpha: 1)
        
        cellLabel = UILabel()
        cellLabel?.textColor = UIColor.init(red: 1, green: 0.5, blue: 0.5, alpha: 1)
        
        cellButton = UIButton.init(type: .system)
        cellButton?.backgroundColor = UIColor.init(red: 1, green: 0.5, blue: 0.15, alpha: 1)
        
        self.addSubview(cellImageView!)
        self.addSubview(cellLabel!)
        self.addSubview(cellButton!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        cellImageView?.frame = CGRect.init(x: 0, y: 0, width: 50, height: self.frame.size.height)
        cellLabel?.frame = CGRect.init(x: 50 , y: 0, width:self.frame.size.width - 150, height: self.frame.size.height)
        cellButton?.frame = CGRect.init(x: self.frame.size.width - 50, y: 0, width: 50, height: self.frame.size.height)
    }

    open func setProduct(product:Product) -> Void {
       cellImageView?.image = UIImage.init(named:(product.cellImageName)!)
       cellLabel?.text = product.name
    }
}
