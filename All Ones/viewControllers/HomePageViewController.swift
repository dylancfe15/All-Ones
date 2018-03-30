//
//  ViewController.swift
//  All Ones
//
//  Created by Difeng Chen on 12/9/17.
//  Copyright © 2017 Difeng Chen. All rights reserved.
//

import UIKit
import CoreData
import GoogleMobileAds
class HomePageViewController: UIViewController,GADBannerViewDelegate,GADInterstitialDelegate ,UIPickerViewDelegate,UIPickerViewDataSource{
    
    @IBOutlet weak var addCoinsOutlet: UIButton!
    @IBOutlet weak var myBanner: GADBannerView!
    @IBOutlet weak var levelButtonOutlet: UIButton!
    @IBOutlet weak var startButtonOutlet: UIButton!
    @IBOutlet weak var modeLabelOutlet: UILabel!
    @IBOutlet weak var numOfCoins: UILabel!
    
    let request:NSFetchRequest<LevelCompleted> = LevelCompleted.fetchRequest()
    let requestNewUser:NSFetchRequest<NewUser> = NewUser.fetchRequest()
    let requestCoins :NSFetchRequest<Coins> = Coins.fetchRequest()
    var newUserArray = [NewUser]()
    var coinsArray = [Coins]()
    let modeArray = ["Classic","Rainbow(Coming soon)","Hell(Coming soon)"]
    var levelArray = [LevelCompleted]()
    var modeIndex = Int()
    var coinsNum = Int16()
    var color = UIColor()
    var numberFormatter = NumberFormatter()
    override func viewDidLoad() {
        super.viewDidLoad()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        levelButtonOutlet.layer.cornerRadius = 15
        startButtonOutlet.layer.cornerRadius = 20
        addCoinsOutlet.layer.cornerRadius = 15
        color = startButtonOutlet.backgroundColor!
        
        do{
            levelArray = try DatabaseController.getContext().fetch(request)
            newUserArray = try DatabaseController.getContext().fetch(requestNewUser)
        }catch{
        }
        
        //level
        if(levelArray.count < 1){
            let levelcompleted: LevelCompleted = NSEntityDescription.insertNewObject(forEntityName: "LevelCompleted", into: DatabaseController.getContext()) as! LevelCompleted
            levelcompleted.levelNum = 1
            DatabaseController.saveContext()
        }
        do{
            levelArray = try DatabaseController.getContext().fetch(request)
        }catch{
        }
        levelButtonOutlet.setTitle(String(levelArray[levelArray.count-1].levelNum), for: .normal)
        
        //newUser
        if(newUserArray.count < 1){
            let coins:Coins = NSEntityDescription.insertNewObject(forEntityName: "Coins", into: DatabaseController.getContext()) as! Coins
            let didrated: DidRated = NSEntityDescription.insertNewObject(forEntityName:
                "DidRated", into: DatabaseController.getContext()) as! DidRated
            let newuser:NewUser = NSEntityDescription.insertNewObject(forEntityName: "NewUser", into: DatabaseController.getContext()) as! NewUser
            coins.amount = 500
            newuser.newUser = false
            didrated.rated = false
            DatabaseController.saveContext()
        }
        do{
            coinsArray = try DatabaseController.getContext().fetch(requestCoins)
        }catch{
            
        }
        for result in coinsArray{
            coinsNum += result.amount
        }
        numOfCoins.text = numberFormatter.string(from: coinsNum as NSNumber)
        //Banner
        let adRequest = GADRequest()
        adRequest.testDevices = [kGADSimulatorID]
        myBanner.adUnitID = "ca-app-pub-6779325502552778/2293332567"
        myBanner.rootViewController = self
        myBanner.delegate = self
        myBanner.load(adRequest)
        
        CreatAndLoadInterstitial()
    }
    //Interstitial ads
    var fullScreenads : GADInterstitial!
    func CreatAndLoadInterstitial() -> GADInterstitial?{
        fullScreenads = GADInterstitial(adUnitID:"ca-app-pub-6779325502552778/2331316428")
        guard let fullScreenads = fullScreenads else{
            return nil
        }
        let requestInter = GADRequest()
        requestInter.testDevices = [kGADSimulatorID]
        fullScreenads.load(requestInter)
        fullScreenads.delegate = self
        return fullScreenads
    }
    func interstitialDidReceiveAd(_ ad: GADInterstitial) {
        ad.present(fromRootViewController: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.destination is levelsViewController){
            let LViewController = segue.destination as! levelsViewController
            LViewController.level = Int(levelButtonOutlet.currentTitle!)!
        }else if(segue.destination is gameViewController){
            let GViewController = segue.destination as! gameViewController
            GViewController.level = Int(levelButtonOutlet.currentTitle!)!
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func startAction(_ sender: Any) {
        if(levelArray[levelArray.count-1].levelNum > Int16(60)){
            performSegue(withIdentifier: "futureSegue", sender: Any?.self)
        }else{
            if(startButtonOutlet.backgroundColor != color){
                performSegue(withIdentifier: "futureSegue", sender: Any?.self)
            }else{
                performSegue(withIdentifier: "GVSegue", sender: Any?.self)
            }
        }
    }

    //picker
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return modeArray.count
    }
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 66
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return modeArray[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        modeLabelOutlet.text = modeArray[row]
        if(row == 0){
            startButtonOutlet.backgroundColor = color
        }else{
            startButtonOutlet.backgroundColor = UIColor.gray
        }
    }
    
}

