//
//  levelsViewController.swift
//  All Ones
//
//  Created by Difeng Chen on 12/9/17.
//  Copyright © 2017 Difeng Chen. All rights reserved.
//

import UIKit
import GoogleMobileAds
class levelsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,GADBannerViewDelegate {
    
    @IBOutlet weak var myBanner: GADBannerView!
    @IBOutlet weak var nextLevelImage: UIImageView!
    @IBOutlet weak var nextLevelOutlet: UILabel!
    @IBOutlet weak var levelTable: UITableView!
    
    var level = Int()
    var levelTableArray = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for i in 1...level-1{
            levelTableArray += [level-i]
        }
        nextLevelOutlet.text = String(levelTableArray[0]+1)
        
        levelTable.backgroundColor = UIColor.clear
        nextLevelImage.layer.cornerRadius = 15
        
        //Banner
        let adRequest = GADRequest()
        adRequest.testDevices = [kGADSimulatorID]
        myBanner.adUnitID = "ca-app-pub-6779325502552778/2293332567"
        myBanner.rootViewController = self
        myBanner.delegate = self
        myBanner.load(adRequest)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return levelTableArray.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LCell", for: indexPath) as! levelTableViewCell
        cell.levelNumer.text = String(levelTableArray[indexPath.row])
        cell.cellImage.layer.cornerRadius = 15
        cell.backgroundColor = UIColor.clear
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        level = level - indexPath.row
        performSegue(withIdentifier: "LCellSegue", sender: Any?.self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.destination is gameViewController){
            let GController = segue.destination as! gameViewController
            GController.level = level-1
        }
    }
}
