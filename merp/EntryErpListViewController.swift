//
//  EntryErpListViewController.swift
//  merp
//
//  Created by yunjie Xie on 15/11/18.
//  Copyright © 2015年 balintimes. All rights reserved.
//

import UIKit

class EntryErpListViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,ErpListViewHeaderDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    
    private var _userModelGroups:[UserModelGroup]?;
    
    private var userModelGroups:[UserModelGroup]{
        get{
            if self._userModelGroups == nil{
                
                var groups:[UserModelGroup] = [];
                
                let arrDicts = NSArray(contentsOfFile: NSBundle.mainBundle().pathForResource("usermodels.plist", ofType: nil)!);
                
                for dic in arrDicts!{
                    let group = UserModelGroup.createGroup(dic as! [String:AnyObject]);
                    
                    groups.append(group);
                    
                }
                
                self._userModelGroups = groups;
            }
            
            return self._userModelGroups!;
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.dataSource = self;
        self.collectionView.delegate = self;

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        
        return self.userModelGroups.count;
    }
    

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return self.userModelGroups[section].visible ? (self.userModelGroups[section].models?.count)! : 0 ;
        
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("erpcell", forIndexPath: indexPath) as! ErpListViewCell;
        
        let model = self.userModelGroups[indexPath.section].models![indexPath.row];
        
        cell.setUserModel(model);
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionElementKindSectionHeader{
            
            let cell = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader, withReuseIdentifier: "header", forIndexPath: indexPath) as! ErpListViewHeader;
            
            cell.userGroup = self.userModelGroups[indexPath.section];
            cell.tag = indexPath.section;
            cell.delegate = self;
            
            return cell;
            
        }
        else{
            let foot = UICollectionReusableView();
            foot.frame.size.height = 0;
            return foot;
        }
    }
    
    func HeaderOnClick(sender: ErpListViewHeader, group: UserModelGroup) {
        
        group.visible = !group.visible;
        
        collectionView.reloadSections(NSIndexSet(index: sender.tag));
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
