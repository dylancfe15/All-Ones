//
//  gameViewController.swift
//  All Ones
//
//  Created by Difeng Chen on 12/9/17.
//  Copyright © 2017 Difeng Chen. All rights reserved.
//

import UIKit
import CoreData
import GoogleMobileAds
class gameViewController: UIViewController,UICollectionViewDelegate, GADBannerViewDelegate,UICollectionViewDataSource {
    
    @IBOutlet weak var toolView: UIView!
    @IBOutlet weak var tipsOutlet: UILabel!
    @IBOutlet weak var taskOutlet: UILabel!
    @IBOutlet weak var stepOutlet: UILabel!
    @IBOutlet weak var numCollectionView: UICollectionView!
    @IBOutlet weak var levelOutlet: UILabel!
    @IBOutlet weak var myBanner: GADBannerView!
    @IBAction func help(_ sender: Any) {
        helpView.isHidden = false
        dismissOutlet.isHidden = false
    }
    @IBOutlet weak var helpView: UIView!
    @IBAction func dismiss(_ sender: Any) {
        helpView.isHidden = true
        dismissOutlet.isHidden = true
    }
    @IBOutlet weak var dismissOutlet: UIButton!
    //tools
    var tool = String()
    @IBOutlet weak var goldPriceOutlet: UILabel!
    @IBOutlet weak var silverPriceOutlet: UILabel!
    @IBOutlet weak var basicPriceOutlet: UILabel!
    @IBOutlet weak var toolLabelOutlet: UILabel!
    @IBOutlet weak var introductionOfTools: UILabel!
    @IBOutlet weak var selectedToolImage: UIImageView!
    @IBOutlet weak var coinsAmountLabel: UILabel!
    @IBAction func tool1Action(_ sender: Any) {
        toolView.isHidden = false
        tool = "Steps"
        selectedToolImage.image = UIImage(named: tool)
        introductionOfTools.text = "Add more moves."
        basicPriceOutlet.text = "10"
        silverPriceOutlet.text = "15"
        goldPriceOutlet.text = "20"
        fetchCoins()
        coinsAmountLabel.text = String(coinsSum)
    }
    @IBAction func tool2Action(_ sender: Any) {
        toolView.isHidden = false
        tool = "Freezing"
        selectedToolImage.image = UIImage(named: tool )
        introductionOfTools.text = "Freeze/Unfreeze numbers."
        basicPriceOutlet.text = "15"
        silverPriceOutlet.text = "20"
        goldPriceOutlet.text = "25"
        fetchCoins()
        coinsAmountLabel.text = String(coinsSum)
    }
    @IBAction func tool3Action(_ sender: Any) {
        toolView.isHidden = false
        tool = "Increase"
        selectedToolImage.image = UIImage(named: tool)
        introductionOfTools.text = "Increase numbers."
        basicPriceOutlet.text = "15"
        silverPriceOutlet.text = "20"
        goldPriceOutlet.text = "25"
        fetchCoins()
        coinsAmountLabel.text = String(coinsSum)
    }
    @IBAction func tool4Action(_ sender: Any) {
        toolView.isHidden = false
        tool = "Refresh"
        selectedToolImage.image = UIImage(named: tool)
        introductionOfTools.text = "Refresh numbers."
        basicPriceOutlet.text = "10"
        silverPriceOutlet.text = "15"
        goldPriceOutlet.text = "20"
        fetchCoins()
        coinsAmountLabel.text = String(coinsSum)
    }
    @IBAction func exitToolView(_ sender: Any) {
        toolView.isHidden = true
        tool = ""
    }
    //badge touch down
    var badge = String()
    @IBAction func basicBadgeAction(_ sender: Any) {
        if(tool == "Steps"){
            introductionOfTools.text = "Add 10 moves."
        }else if(tool == "Freezing"){
            introductionOfTools.text = "Freeze/Unfreeze ONE number."
        }else if(tool == "Increase"){
            introductionOfTools.text = "Increase ONE number."
        }else{
            introductionOfTools.text = "Refresh ONE number."
        }
        toolLabelOutlet.text = "Basic"
    }
    @IBAction func silverBadgeAction(_ sender: Any) {
        if(tool == "Steps"){
            introductionOfTools.text = "Add 20 moves."
        }else if(tool == "Freezing"){
            introductionOfTools.text = "Freeze/Unfreeze THREE numbers."
        }else if(tool == "Increase"){
            introductionOfTools.text = "Increase THREE numbers."
        }else{
            introductionOfTools.text = "Refresh THREE numbers."
        }
        toolLabelOutlet.text = "Silver"
    }
    @IBAction func goldBadgeAction(_ sender: Any) {
        if(tool == "Steps"){
            introductionOfTools.text = "Add 30 moves."
        }else if(tool == "Freezing"){
            introductionOfTools.text = "Freeze/Unfreeze FIVE numbers."
        }else if(tool == "Change"){
            introductionOfTools.text = "Increase FIVE numbers."
        }else{
            introductionOfTools.text = "Refresh FIVE numbers."
        }
        toolLabelOutlet.text = "Gold"
    }
    //badge touch up
    @IBAction func exitToolUsingView(_ sender: Any) {
        tool = ""
        toolUsingOutlet.isHidden = true
    }
    @IBAction func exitCoinsNotEnough(_ sender: Any) {
        coinsNotEnoughView.isHidden = true
        tool = ""
    }
    @IBOutlet weak var toolUsingOutlet: UIView!
    @IBOutlet weak var toolUsingImage: UIImageView!
    @IBOutlet weak var toolUsingInstructionOutlet: UILabel!
    @IBOutlet weak var numbersLeftOutlet: UILabel!
    @IBOutlet weak var coinsNotEnoughView: UIView!
    @IBOutlet weak var notEngCoinsAmountlabel: UILabel!
    var numberLeftTool = Int()
    @IBAction func basicBadgeUpAction(_ sender: Any) {
        if(tool != "Steps"){
            numberLeftTool = 1
            if(tool == "Freezing"){
                if(coinsSum >= 15){
                    addEntityObject(num: -15)
                    toolSetupLabels()
                    toolView.isHidden = true
                }else{
                    coinsNotEnoughView.isHidden = false
                }
            }else if(tool == "Increase"){
                if(coinsSum >= 15){
                    addEntityObject(num: -15)
                    toolSetupLabels()
                    toolView.isHidden = true
                }else{
                    coinsNotEnoughView.isHidden = false
                }
            }else{
                if(coinsSum >= 10){
                    addEntityObject(num: -10)
                    toolSetupLabels()
                    toolView.isHidden = true
                }else{
                    coinsNotEnoughView.isHidden = false
                }
            }
        }else{
            if(coinsSum >= 10){
                steps += 10
                stepOutlet.text = "Steps: "+String(steps)
                addEntityObject(num: -10)
                toolView.isHidden = true
            }else{
                coinsNotEnoughView.isHidden = false
            }
        }
        notEngCoinsAmountlabel.text = String(coinsSum)
    }
    @IBAction func silverBadgeUpAction(_ sender: Any) {
        if(tool != "Steps"){
            numberLeftTool = 3
            if(tool == "Freezing"){
                if(coinsSum >= 20){
                    addEntityObject(num: -20)
                    toolSetupLabels()
                    toolView.isHidden = true
                }else{
                    coinsNotEnoughView.isHidden = false
                }
            }else if(tool == "Increase"){
                if(coinsSum >= 20){
                    addEntityObject(num: -20)
                    toolSetupLabels()
                    toolView.isHidden = true
                }else{
                    coinsNotEnoughView.isHidden = false
                }
            }else{
                if(coinsSum >= 15){
                    addEntityObject(num: -15)
                    toolSetupLabels()
                    toolView.isHidden = true
                }else{
                    coinsNotEnoughView.isHidden = false
                }
            }
        }else{
            if(coinsSum >= 15){
                steps += 20
                stepOutlet.text = "Steps: "+String(steps)
                addEntityObject(num: -15)
                toolView.isHidden = true
            }else{
                coinsNotEnoughView.isHidden = false
            }
        }
        notEngCoinsAmountlabel.text = String(coinsSum)
    }
    @IBAction func goldBadgeUpAction(_ sender: Any) {
        if(tool != "Steps"){
            numberLeftTool = 5
            if(tool == "Freezing"){
                if(coinsSum >= 25){
                    addEntityObject(num: -25)
                    toolSetupLabels()
                    toolView.isHidden = true
                }else{
                    coinsNotEnoughView.isHidden = false
                }
            }else if(tool == "Increase"){
                if(coinsSum >= 25){
                    addEntityObject(num: -25)
                    toolSetupLabels()
                    toolView.isHidden = true
                }else{
                    coinsNotEnoughView.isHidden = false
                }
            }else{
                if(coinsSum >= 20){
                    addEntityObject(num: -20)
                    toolSetupLabels()
                    toolView.isHidden = true
                }else{
                    coinsNotEnoughView.isHidden = false
                }
            }
        }else{
            if(coinsSum >= 20){
                steps += 30
                stepOutlet.text = "Steps: "+String(steps)
                addEntityObject(num: -20)
                toolView.isHidden = true
            }else{
                coinsNotEnoughView.isHidden = false
            }
        }
        notEngCoinsAmountlabel.text = String(coinsSum)
    }
    func toolSetupLabels(){
        toolUsingOutlet.isHidden = false
        toolUsingImage.image = UIImage(named: tool)
        numbersLeftOutlet.text = String(numberLeftTool)
        if(tool == "Freezing"){
            toolUsingInstructionOutlet.text = "Select a number. The number you select will be freezed/unfreezed."
        }else if(tool == "Refresh"){
            toolUsingInstructionOutlet.text = "Select a number. The number you select will be refreshed."
        }else{
            toolUsingInstructionOutlet.text = "Select a number. The number you select will be increased by ONE."
        }
    }
    //fetch coins
    var coinsArray = [Coins]()
    var coinsSum = Int16()
    func fetchCoins(){
        coinsSum = 0
        let coinsRequest: NSFetchRequest<Coins> = Coins.fetchRequest()
        do{
            coinsArray = try DatabaseController.getContext().fetch(coinsRequest)
        }catch{
            
        }
        for result in coinsArray{
            coinsSum += result.amount
        }
    }
    //add entity object
    func addEntityObject(num: Int16){
        let coins:Coins = NSEntityDescription.insertNewObject(forEntityName: "Coins", into: DatabaseController.getContext()) as! Coins
        coins.amount = num
        DatabaseController.saveContext()
    }
    
    var selectedTool = String()
    var level = Int()
    var highestVal = Int()
    var numberOfItem = Int()
    var randomNum = Int()
    var numberArray = [Int]()
    var numberArrayAlpha = [CGFloat]()
    var steps = Int()
    var levelIsTen = Bool()
    var numOfTens = Int()
    var numInOrder = Int()
    var numEqual = Int()
    var numOfOnes = Int()
    var isWon = Bool()
    var task = Int()
    var taskString = String()
    let tips = ["Make all numbers to ones.","Make all numbers in order. \nFor example:\n'0120','2345'.","The sum of every row and column must be the same."]
    let numberFormatter = NumberFormatter()
    override func viewDidLoad() {
        super.viewDidLoad()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        //initialize value
        steps = 10 + level%10*3 + level/10*4
        if(level%10 == 0){
            steps += 40
        }
        
        if(level <= 10){
            highestVal = 1 + level%10
            numberOfItem = 2
            task = numberOfItem * numberOfItem
            if(level%10 == 0){
                highestVal += 10
                task -= 1
            }
            taskString = "All Ones"
            tipsOutlet.text = tips[0]
        }else if(level <= 20){
            highestVal = 1 + level%10
            numberOfItem = 2
            task = numberOfItem * numberOfItem
            if(level%10 == 0){
                highestVal += 10
                task -= 1
            }
            taskString = "In order"
            tipsOutlet.text = tips[1]
        }else if(level <= 30){
            highestVal = 1 + level%10
            numberOfItem = 2
            task = numberOfItem * 2-1
            if(level%10 == 0){
                highestVal += 10
            }
            taskString = "Equality"
            tipsOutlet.text = tips[2]
        }else if(level <= 40){
            highestVal = 1 + level%10
            numberOfItem = 3
            task = numberOfItem * numberOfItem
            if(level%10 == 0){
                highestVal += 10
                task -= 1
            }
            taskString = "All Ones"
            tipsOutlet.text = tips[0]
        }else if(level <= 50){
            highestVal = 1 + level%10
            numberOfItem = 3
            task = numberOfItem * 2-1
            if(level%10 == 0){
                highestVal += 10
            }
            taskString = "Equality"
            tipsOutlet.text = tips[2]
        }else if(level <= 60){
            highestVal = 1 + level%10
            numberOfItem = 3
            task = numberOfItem * numberOfItem
            if(level%10 == 0){
                highestVal += 10
                task -= 1
            }
            taskString = "In order"
            tipsOutlet.text = tips[1]
        }else if(level <= 70){
            highestVal = 1 + level%10
            numberOfItem = 2
            task = numberOfItem * numberOfItem
            if(level%10 == 0){
                highestVal += 10
                task -= 1
            }
            taskString = "All Ones"
            tipsOutlet.text = tips[0]
        }else if(level <= 80){
            highestVal = 1 + level%10
            numberOfItem = 2
            task = numberOfItem * 2-1
            if(level%10 == 0){
                highestVal += 10
            }
            taskString = "Equality"
            tipsOutlet.text = tips[2]
        }else if(level <= 90){
            highestVal = 1 + level%10
            numberOfItem = 2
            task = numberOfItem * numberOfItem
            if(level%10 == 0){
                highestVal += 10
                task -= 1
            }
            taskString = "In order"
            tipsOutlet.text = tips[1]
        }
        helpView.layer.cornerRadius = 15
        
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
        
        //label
        levelOutlet.text = "Level: "+String(level)
        
        // initialize numbers
        //level less than 60
        if(level <= 60){
            repeat{
                numberArray = []
                for i in 1...numberOfItem*numberOfItem{
                    randomNum = Int(arc4random_uniform(UInt32(highestVal)))
                    numberArray += [randomNum]
                    numberArrayAlpha += [0.0]
                }
                
            }while(checkWinStatue() || numOfTenIsOne())
        }
        
        updateData()
        
        //Banner
        let adRequest = GADRequest()
        adRequest.testDevices = [kGADSimulatorID]
        myBanner.adUnitID = "ca-app-pub-6779325502552778/2293332567"
        myBanner.rootViewController = self
        myBanner.delegate = self
        myBanner.load(adRequest)
    }

    //update data
    func updateData(){
        //labels
        taskOutlet.text = "Task: " + taskString
        stepOutlet.text = "Moves: " + String(steps)
        
        //check if win
        if(checkWinStatue()){
            let request:NSFetchRequest<LevelCompleted> = LevelCompleted.fetchRequest()
            var levelArray = [LevelCompleted]()
            do{
                levelArray = try DatabaseController.getContext().fetch(request)
            }catch{
                
            }
            level += 1
            if(levelArray[levelArray.count - 1].levelNum == level-1){
                //update level
                let managedContext: NSManagedObjectContext = DatabaseController.getContext()
                var tempArray = [LevelCompleted]()
                //delete
                let request: NSFetchRequest<LevelCompleted> = LevelCompleted.fetchRequest()
                do{
                    tempArray = try DatabaseController.getContext().fetch(request)
                }catch{
                    
                }
                for result in tempArray{
                    managedContext.delete(result)
                }
                //add
                let levelcompleted: LevelCompleted = NSEntityDescription.insertNewObject(forEntityName: "LevelCompleted", into: DatabaseController.getContext()) as! LevelCompleted
                
                levelcompleted.levelNum = Int16(level)
                DatabaseController.saveContext()
                
            }
            performSegue(withIdentifier: "WinSegue", sender: Any?.self)
        }else if(steps == 0){
            performSegue(withIdentifier: "LostSegue", sender: Any?.self)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if(tool == ""){
            let cul = indexPath.row/numberOfItem
            let row = indexPath.row%numberOfItem
            if(numberArray[indexPath.row] != 10){
                if(numberArrayAlpha[indexPath.row] == 0.0){
                    for i in 0...numberArray.count-1{
                        if(i/numberOfItem == cul){
                            if(numberArray[i] != 10){
                                if(numberArrayAlpha[i] == 0.0){
                                    numberArray[i] += 1
                                }else{
                                    numberArrayAlpha[i] -= 0.25
                                }
                            }
                        }else if(i%numberOfItem == row && i != indexPath.row){
                            if(numberArray[i] != 10){
                                if(numberArrayAlpha[i] == 0.0){
                                    numberArray[i] += 1
                                }else{
                                    numberArrayAlpha[i] -= 0.25
                                }
                            }
                        }
                        if(level%10 == 0){
                            if(numberArray[i] > highestVal-2){
                                if(i != indexOfTen){
                                    numberArray[i] -= highestVal-1
                                }
                            }
                        }else{
                            if(numberArray[i] > highestVal-1){
                                numberArray[i] -= highestVal
                            }
                        }
                    }
                    //diable selected num
                    if(level>70 && level <= 90){
                        if(numberArrayAlpha[indexPath.row] == 0.0){
                            numberArrayAlpha[indexPath.row] = 0.25
                        }else{
                            numberArrayAlpha[indexPath.row] -= 0.25
                        }
                    }
                    steps -= 1
                    numCollectionView.reloadData()
                    updateData()
                }
            }
        }else if(tool == "Refresh"){
            if(numberArray[indexPath.row] != 10){
                if(numberArrayAlpha[indexPath.row] == 0.0){
                    repeat{
                        randomNum = Int(arc4random_uniform(UInt32(highestVal)))
                    }while(randomNum == numberArray[indexPath.row])
                    numberArray[indexPath.row] = randomNum
                    numCollectionView.reloadData()
                    updateData()
                    numberLeftTool -= 1
                    numbersLeftOutlet.text = String(numberLeftTool)
                    if(numberLeftTool < 1){
                        toolUsingOutlet.isHidden = true
                        tool = ""
                    }
                }
            }
        }else if(tool == "Freezing"){
            if(numberArray[indexPath.row] != 10){
                if(numberArrayAlpha[indexPath.row] == 0.0){
                    numberArrayAlpha[indexPath.row] = 0.75
                    numCollectionView.reloadData()
                    updateData()
                    numberLeftTool -= 1
                    numbersLeftOutlet.text = String(numberLeftTool)
                    if(numberLeftTool < 1){
                        toolUsingOutlet.isHidden = true
                        tool = ""
                    }
                }else{
                    numberArrayAlpha[indexPath.row] = 0.0
                    numCollectionView.reloadData()
                    updateData()
                    numberLeftTool -= 1
                    numbersLeftOutlet.text = String(numberLeftTool)
                    if(numberLeftTool < 1){
                        toolUsingOutlet.isHidden = true
                        tool = ""
                    }
                }
            }
        }else{
            if(numberArray[indexPath.row] != 10){
                if(numberArrayAlpha[indexPath.row] == 0.0){
                    numberArray[indexPath.row] += 1
                    numCollectionView.reloadData()
                    updateData()
                    numberLeftTool -= 1
                    numbersLeftOutlet.text = String(numberLeftTool)
                    if(numberLeftTool < 1){
                        toolUsingOutlet.isHidden = true
                        tool = ""
                    }
                    if(level%10 == 0){
                        if(numberArray[indexPath.row] > highestVal-2){
                            if(indexPath.row != indexOfTen){
                                numberArray[indexPath.row] -= highestVal-1
                            }
                        }
                    }else{
                        if(numberArray[indexPath.row] > highestVal-1){
                            numberArray[indexPath.row] -= highestVal
                        }
                    }
                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NumCell", for: indexPath) as! numCollectionViewCell
        cell.numImage.image = UIImage(named:"B"+String(numberArray[indexPath.row]))
        cell.topImage.alpha = numberArrayAlpha[indexPath.row]
        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.destination is LostViewController){
            let LController = segue.destination as! LostViewController
            LController.level = level
            LController.numberArray = numberArray
            LController.numberOfItem = numberOfItem
        }else if(segue.destination is WinViewController){
            let WController = segue.destination as! WinViewController
            WController.level = level
            WController.moves = steps
            WController.numberArray = numberArray
            WController.numberOfItem = numberOfItem
        }
    }
    
    //check win statue
    func checkWinStatue() -> Bool{
        isWon = false
        if(level <= 10 || (level > 30 && level <= 40) || (level > 60 && level <= 70)){
            numOfOnes = 0
            for result in numberArray{
                if(result == 1){
                    numOfOnes += 1
                }else if(result == 10){
                    numOfTens += 1
                }
            }
            if(numOfOnes == task){
                isWon = true
            }else{
                isWon = false
            }
        }else if(level <= 20 || (level > 50 && level <= 60) || (level > 80 && level <= 90)){
            //isWon
            numInOrder = 0
            for i in 0...numberArray.count-2{
                if(numberArray[i] != 10){
                    if(numberArray[i+1] != 10){
                        if(numberArray[i+1] > numberArray[i]){
                            if(numberArray[i+1]-1 == numberArray[i]){
                                numInOrder += 1
                            }
                        }else{
                            if(numberArray[i]-numberArray[i+1] == highestVal-1){
                                numInOrder += 1
                            }
                        }
                    }else{
                        if(numberArray[i+2] > numberArray[i]){
                            if(numberArray[i+2]-1 == numberArray[i]){
                                numInOrder += 1
                            }
                        }else{
                            if(numberArray[i]-numberArray[i+2] == highestVal-1){
                                numInOrder += 1
                            }
                        }
                    }
                }
            }
            if(numInOrder == task-1){
                isWon = true
            }else{
                isWon = false
            }
        }else if(level <= 30 || (level > 40 && level <= 50) || (level > 70 && level <= 80)){
            numEqual = 0
            var sum = [Int]()
            var rowSum = [0,0,0]
            var colSum = [0,0,0]
            var tempNum = 0
            if(level%10 == 0){
                for i in 0...numberArray.count-1{
                    if(numberArray[i] == 10){
                        tempNum = i
                    }
                }
                numberArray[tempNum] = 0
            }
            
            for i in 0...numberArray.count-1{
                rowSum[i/numberOfItem] += numberArray[i]
            }
            for i in 0...numberArray.count-1{
                colSum[i%numberOfItem] += numberArray[i]
            }
            sum += rowSum
            sum += colSum
            
            for i in 0...sum.count-2{
                if(sum[i] == sum[i+1]){
                    numEqual += 1
                }
            }
            if(numEqual == task){
                isWon = true
            }else{
                isWon = false
            }
            if(level%10 == 0){
                numberArray[tempNum] = 10
            }
        }
        
        return isWon
    }
    
    //check if number of ten is 1
    var indexOfTen = Int()
    func numOfTenIsOne() -> Bool {
        levelIsTen = false
        numOfTens = 0
        indexOfTen = 0
        for i in 0...numberArray.count-1{
            if(numberArray[i] == 10){
                numOfTens += 1
                indexOfTen = i
            }
        }
        if(level%10 == 0){
            if(numOfTens == 1){
                levelIsTen = false
            }else{
                levelIsTen = true
            }
        }else{
            levelIsTen = false
        }
        return levelIsTen
    }
}
