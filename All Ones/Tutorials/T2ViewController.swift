//
//  T2ViewController.swift
//  All Ones
//
//  Created by Difeng Chen on 12/17/17.
//  Copyright © 2017 Difeng Chen. All rights reserved.
//

import UIKit

class T2ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource{
    
    
    @IBAction func NumButtonAction(_ sender: Any) {
        num += 1
        if(num > 3){
            num = 0
        }
        numButtonOutlet.setBackgroundImage(UIImage(named: "B"+String(num)), for:.normal )
        for i in 0...3{
            if(numberArray[i] == num){
                numberAlpatArray[i] = 0
            }else{
                numberAlpatArray[i] = 0.5
            }
        }
        numCollectionView.reloadData()
    }
    @IBOutlet weak var numButtonOutlet: UIButton!
    @IBOutlet weak var numCollectionView: UICollectionView!
    
    var num = Int()
    var numberArray = [0,1,2,3]
    var numberAlpatArray = [0,0.5,0.5,0.5]
    override func viewDidLoad() {
        super.viewDidLoad()
        numButtonOutlet.setBackgroundImage(UIImage(named: "B"+String(num)), for:.normal )
        
        //collection layout
        var itemSize = CGFloat()
        if(view.frame.width < 375.0){
            itemSize = numCollectionView.frame.width/CGFloat(4)-30
        }else{
            itemSize = numCollectionView.frame.width/CGFloat(4)
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
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "T2", for: indexPath) as! T2CollectionViewCell
        cell.numberImage.image = UIImage(named:"B"+String(numberArray[indexPath.row]))
        cell.alptaImage.alpha = CGFloat(numberAlpatArray[indexPath.row])
        return cell
    }

}
