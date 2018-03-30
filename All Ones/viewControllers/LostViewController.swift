//
//  LostViewController.swift
//  All Ones
//
//  Created by Difeng Chen on 12/10/17.
//  Copyright © 2017 Difeng Chen. All rights reserved.
//

import UIKit

class LostViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    @IBOutlet weak var numCollectionView: UICollectionView!
    
    @IBOutlet weak var levelLabelOutlet: UILabel!
    @IBOutlet weak var statusLabelOutlet: UILabel!
    @IBOutlet weak var taskBackgroundOutlet: UIImageView!
    @IBOutlet weak var taskCompletedLabel: UILabel!
    @IBOutlet weak var lostView: UIView!
    @IBOutlet weak var homeButtonOutlet: UIButton!
    @IBOutlet weak var replayButtonOutlet: UIButton!
    var level = Int()
    var numberArray = [Int]()
    let status = ["Try again!","Almost done!","Never give up!","You can do it!"]
    var numberOfItem = Int()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.clear
        lostView.layer.cornerRadius = 15
        taskBackgroundOutlet.layer.cornerRadius = 15
        taskCompletedLabel.text = "Level failed"
        statusLabelOutlet.text = status[Int(arc4random_uniform(UInt32(4)))]
        levelLabelOutlet.text = "Level: "+String(level)
        
        
        //collection layout
        var itemSize = CGFloat()
        if(view.frame.width < 375.0){
            itemSize = numCollectionView.frame.width/CGFloat(numberOfItem)-30
        }else{
            itemSize = numCollectionView.frame.width/CGFloat(numberOfItem)
        }
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: itemSize, height: itemSize)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        numCollectionView.collectionViewLayout = layout
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.destination is gameViewController){
            let GController = segue.destination as! gameViewController
            GController.level = level
        }
    }
    
    //collection
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "lostCell", for: indexPath) as! lostCollectionViewCell
        cell.image.image = UIImage(named:"B"+String(numberArray[indexPath.row]))
        return cell
    }
    

}
