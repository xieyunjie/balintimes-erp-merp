//
//  CommonViewCell.swift
//  merp
//
//  Created by yunjie Xie on 15/11/18.
//  Copyright © 2015年 balintimes. All rights reserved.
//

import UIKit

class CommonViewCell: UICollectionViewCell {
    
    @IBOutlet var lblIntro: UILabel!
    
    @IBOutlet var imgIcon: UIImageView!
    
    var model:UserModel?;
    
    
    func setUserModel(model:UserModel){
    
        self.model = model;
        
        self.lblIntro.text = self.model?.label;
        self.imgIcon.image = UIImage(named: "gift");
        
        self.contentView.addSubview(lblIntro);
        self.contentView.addSubview(imgIcon);
               
    
    }
    
    

}
