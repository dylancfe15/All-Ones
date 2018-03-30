//
//  WinViewController.swift
//  All Ones
//
//  Created by Difeng Chen on 12/10/17.
//  Copyright © 2017 Difeng Chen. All rights reserved.
//

import UIKit
import CoreData
class WinViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {
    
    @IBOutlet weak var levelLabelOutlet: UILabel!
    @IBOutlet weak var statuLabelOutlet: UILabel!
    @IBOutlet weak var taskLabelOutlet: UILabel!
    @IBOutlet weak var taskBackgroundOutlet: UIImageView!
    @IBOutlet weak var viewImageOutlet: UIView!
    @IBOutlet weak var nextButtonOutlet: UIButton!
    @IBOutlet weak var homeButtonOutlet: UIButton!
    @IBOutlet weak var numCollectionView: UICollectionView!
    @IBOutlet weak var movesLeftLabel: UILabel!
    @IBOutlet weak var rewardLabel: UILabel!
    
    let status = ["Well done!","Good job!","Keep going!","Congratulations!"]
    var level = Int()
    var moves = Int()
    var numberArray = [Int]()
    var numberOfItem = Int()
    let rewardRequest:NSFetchRequest<RewardLevel> = RewardLevel.fetchRequest()
    var rewardLevelArray = [RewardLevel]()
    var rewardlevel: RewardLevel = NSEntityDescription.insertNewObject(forEntityName: "RewardLevel", into: DatabaseController.getContext()) as! RewardLevel
    var coins:Coins = NSEntityDescription.insertNewObject(forEntityName: "Coins", into: DatabaseController.getContext()) as! Coins
    var rewardReceived = false
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.clear
        viewImageOutlet.layer.cornerRadius = 15
        taskBackgroundOutlet.layer.cornerRadius = 15
        taskLabelOutlet.text = "Moves left:"
        statuLabelOutlet.text = status[Int(arc4random_uniform(UInt32(4)))]
        levelLabelOutlet.text = "Level: "+String(level-1)
        
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
        
        movesLeftLabel.text = String(moves)
        do{
            rewardLevelArray = try DatabaseController.getContext().fetch(rewardRequest)
        }catch{}
        for result in rewardLevelArray{
            if(Int16(level) == result.rewardLevel){
                rewardReceived = true
            }
        }
        if(!rewardReceived){
            rewardLabel.text = String(moves)
            rewardlevel.rewardLevel = Int16(level)
            coins.amount = Int16(moves)
            DatabaseController.saveContext()
        }else{
            rewardLabel.text = String(0)
        }
        
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
    override func viewDidAppear(_ animated: Bool) {
        //rate
        if( level == 6 || level == 16 || level == 36 || level == 66){
            let requestRate:NSFetchRequest<DidRated> = DidRated.fetchRequest()
            var rateArray = [DidRated]()
            do{
                rateArray = try DatabaseController.getContext().fetch(requestRate)
            }catch{
                
            }
            if(!rateArray[rateArray.count-1].rated){
                createAlert()
            }
        }
    }
    
    func createAlert(){
        let actionSheet = UIAlertController(title: "All Ones", message: "How do you feel our app?", preferredStyle: .actionSheet)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let excellent = UIAlertAction(title: "Excellent!", style: .default){ action in
            let appDelegate = AppDelegate()
            appDelegate.requestReview()
            let rate:DidRated = NSEntityDescription.insertNewObject(forEntityName: "DidRated", into: DatabaseController.getContext()) as! DidRated
            rate.rated = true
            DatabaseController.saveContext()
        }
        let verygood = UIAlertAction(title: "Very good!", style: .default){ action in
            let appDelegate = AppDelegate()
            appDelegate.requestReview()
            let rate:DidRated = NSEntityDescription.insertNewObject(forEntityName: "DidRated", into: DatabaseController.getContext()) as! DidRated
            rate.rated = true
            DatabaseController.saveContext()
        }
        let ok = UIAlertAction(title: "It's okay!", style: .default){ action in
            let alert = UIAlertController(title: nil, message: "Thank you for your feedback!", preferredStyle: .alert)
            let cancelAlert = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
            alert.addAction(cancelAlert)
            self.present(alert, animated: true, completion: nil)
        }
        let need = UIAlertAction(title: "Not really like it!", style: .default){ action in
            let alert = UIAlertController(title: nil, message: "Thank you for your feedback!", preferredStyle: .alert)
            let cancelAlert = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
            alert.addAction(cancelAlert)
            self.present(alert, animated: true, completion: nil)
        }
        let awful = UIAlertAction(title: "Awful!", style: .default){ action in
            let alert = UIAlertController(title: nil, message: "Thank you for your feedback!", preferredStyle: .alert)
            let cancelAlert = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
            alert.addAction(cancelAlert)
            self.present(alert, animated: true, completion: nil)
        }
        actionSheet.addAction(excellent)
        actionSheet.addAction(verygood)
        actionSheet.addAction(ok)
        actionSheet.addAction(need)
        actionSheet.addAction(awful)
        actionSheet.addAction(cancel)
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    //collection
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "winCell", for: indexPath) as! WinCollectionViewCell
        cell.image.image = UIImage(named:"B"+String(numberArray[indexPath.row]))
        return cell
    }
    
    @IBAction func next(_ sender: Any) {
        if(level > 60){
            performSegue(withIdentifier: "W2Notes", sender: Any?.self)
        }else{
            performSegue(withIdentifier: "nextLevelSegue", sender: Any?.self)
        }
    }
    
    
}
