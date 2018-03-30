//
//  T3ViewController.swift
//  All Ones
//
//  Created by Difeng Chen on 12/17/17.
//  Copyright © 2017 Difeng Chen. All rights reserved.
//

import UIKit

class T3ViewController: UIViewController ,UICollectionViewDataSource,UICollectionViewDelegate{
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var numCollectionView: UICollectionView!
    
    var numberArray = [0,1,0,0]
    override func viewDidLoad() {
        super.viewDidLoad()

        //collection layout
        var itemSize = CGFloat()
        if(view.frame.width < 375.0){
            itemSize = numCollectionView.frame.width/CGFloat(2)-30
        }else{
            itemSize = numCollectionView.frame.width/CGFloat(2)
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
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "T3", for: indexPath) as! T3CollectionViewCell
        cell.Image.image = UIImage(named: "B"+String(numberArray[indexPath.row]))
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cul = indexPath.row/2
        let row = indexPath.row%2
        for i in 0...numberArray.count-1{
            if(i/2 == cul){
                numberArray[i] += 1
            }else if(i%2 == row && i != indexPath.row){
                numberArray[i] += 1
            }
            if(numberArray[i] > 1){
                numberArray[i] -= 2
            }
        }
        var numOfOnes = Int()
        for result in numberArray{
            if(result == 1){
                numOfOnes += 1
            }
        }
        if(numOfOnes == 4){
            label.text = "Congratulations! \nYou made it!"
        }else{
            label.text = "Try making the following table all ONES."
        }
        numCollectionView.reloadData()
    }

}
