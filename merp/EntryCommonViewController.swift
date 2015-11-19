//
//  EntryCommonViewController.swift
//  merp
//
//  Created by yunjie Xie on 15/11/18.
//  Copyright © 2015年 balintimes. All rights reserved.
//

import UIKit

class EntryCommonViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate{
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    lazy var models:[UserModel] = {
        
        let aryDicts = NSArray(contentsOfFile: NSBundle.mainBundle().pathForResource("commoncells.plist", ofType: nil)!);
        
        var result:[UserModel] = [];
        for dic in aryDicts! {
            let m = UserModel.createModel(dic as! [String : AnyObject]);
            
            result.append(m);
        }
        return result;
        
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.dataSource = self;
        collectionView.delegate = self;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }
    
    // datasource
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        
        return self.models.count;
    }
    
    // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell{
         
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! CommonViewCell;
        let model = self.models[indexPath.row];
        
        cell.setUserModel(model);
//        cell.lblIntro.text = model.label;
//        
//        cell.imgIcon.image = UIImage(named: model.icon);
//        
//        cell.contentView.addSubview(cell.lblIntro);
//        cell.contentView.addSubview(cell.imgIcon);
        
        return cell;
        
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as? CommonViewCell;
        
        print("\(cell?.lblIntro.text)");
    }
    

}
