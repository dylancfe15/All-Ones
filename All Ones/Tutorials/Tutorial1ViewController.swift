//
//  Tutorial1ViewController.swift
//  All Ones
//
//  Created by Difeng Chen on 12/17/17.
//  Copyright © 2017 Difeng Chen. All rights reserved.
//

import UIKit

class Tutorial1ViewController: UIViewController ,UICollectionViewDelegate,UICollectionViewDataSource{
    
    @IBOutlet weak var numCollectionView: UICollectionView!
    var numberArray = [Int]()
    var numberAlptaArray = [CGFloat]()
    override func viewDidLoad() {
        super.viewDidLoad()
        for i in 0...24{
            numberArray += [0]
            numberAlptaArray += [0.0]
        }
        //collection layout
        var itemSize = CGFloat()
        if(view.frame.width < 375.0){
            itemSize = numCollectionView.frame.width/CGFloat(5)-30
        }else{
            itemSize = numCollectionView.frame.width/CGFloat(5)
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "T1", for: indexPath) as! Tutorial1CollectionViewCell
        cell.numberImage.image = UIImage(named: "B"+String(numberArray[indexPath.row]))
        cell.alptaImage.alpha = numberAlptaArray[indexPath.row]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cul = indexPath.row/5
        let row = indexPath.row%5
        for i in 0...numberArray.count-1{
            numberAlptaArray[i] = 0.5
            if(i/5 == cul){
                numberArray[i] += 1
                numberAlptaArray[i] = 0
            }else if(i%5 == row && i != indexPath.row){
                numberArray[i] += 1
                numberAlptaArray[i] = 0
            }
            if(numberArray[i] > 9){
                numberArray[i]=9
            }
        }
        numCollectionView.reloadData()
    }

}
