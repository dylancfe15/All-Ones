//
//  BuyCoinsViewController.swift
//  All Ones
//
//  Created by Difeng Chen on 12/19/17.
//  Copyright © 2017 Difeng Chen. All rights reserved.
//

import UIKit
import CoreData
import StoreKit
import SwiftyStoreKit

//network
class NetworkActivityIndicatorManager: NSObject {
    
    private static var loadingCount = 0
    
    class func NetworkOperationStarted(){
        if loadingCount == 0{
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
        }
        loadingCount += 1
    }
    class func networkOperationFinished(){
        if loadingCount > 0{
            loadingCount -= 1
        }
        if loadingCount == 0{
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }
    }
}
class BuyCoinsViewController: UIViewController {

    @IBOutlet weak var coinsOptionBackgroundImage: UIView!
    @IBOutlet weak var coinsNumBackgroundImage: UIImageView!
    @IBOutlet weak var coinsAmountLabel: UILabel!
    let numberFormatter = NumberFormatter()
    var coinsArray = [Coins]()
    var coinsSum = Int16()
    let coinsRequest:NSFetchRequest<Coins> = Coins.fetchRequest()
    override func viewDidLoad() {
        super.viewDidLoad()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        do{
            coinsArray = try DatabaseController.getContext().fetch(coinsRequest)
        }catch{
            
        }
        for result in coinsArray{
            coinsSum += result.amount
        }
        coinsNumBackgroundImage.layer.cornerRadius = 15
        coinsOptionBackgroundImage.layer.cornerRadius = 15
        
        coinsAmountLabel.text = numberFormatter.string(from: coinsSum as NSNumber)
        
        //IAP
        IAPService.shared.getProducts()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func buy100Coins(_ sender: Any) {
        IAPService.shared.purchase(product: .Coins100)
        coinsAmountLabel.text = numberFormatter.string(from: getCoinsSum() as NSNumber)
    }
    @IBAction func buy500Coins(_ sender: Any) {
        IAPService.shared.purchase(product: .Coins500)
        coinsAmountLabel.text = numberFormatter.string(from: getCoinsSum() as NSNumber)
    }
    @IBAction func buy1000Coins(_ sender: Any) {
        IAPService.shared.purchase(product: .Coins1000)
        coinsAmountLabel.text = numberFormatter.string(from: getCoinsSum() as NSNumber)
    }
    @IBAction func buySilverSub(_ sender: Any) {
        //IAPService.shared.purchase(product: .MonthlySilver)
    }
    @IBAction func buyGoldSub(_ sender: Any) {
        //IAPService.shared.purchase(product: .MontylyGold)
    }
    
    func getCoinsSum() -> Int16{
        coinsSum = 0
        do{
            coinsArray = try DatabaseController.getContext().fetch(coinsRequest)
        }catch{}
        for result in coinsArray{
            coinsSum += result.amount
        }
        return coinsSum
    }
    
    
//    func getInfo(purchase : RegisteredPurchase){
//        NetworkActivityIndicatorManager.NetworkOperationStarted()
//        SwiftyStoreKit.retrieveProductsInfo([productID + purchase.rawValue], completion: {
//            result in
//            NetworkActivityIndicatorManager.networkOperationFinished()
//        })
//    }
//    func purchase(purchase : RegisteredPurchase){
//        NetworkActivityIndicatorManager.NetworkOperationStarted()
//        SwiftyStoreKit.purchaseProduct(productID + purchase.rawValue, completion: {
//        result in
//            NetworkActivityIndicatorManager.networkOperationFinished()
//        })
//    }
//    func restorePurchases(){
//        NetworkActivityIndicatorManager.NetworkOperationStarted()
//        SwiftyStoreKit.restorePurchases(atomically: true, applicationUsername: "", completion: {
//            result in
//            NetworkActivityIndicatorManager.networkOperationFinished()
//        })
//    }
//    func verifyReceipt(){
//        NetworkActivityIndicatorManager.NetworkOperationStarted()
//        SwiftyStoreKit.verifyReceipt(using: <#T##ReceiptValidator#>, completion: <#T##(VerifyReceiptResult) -> Void#>)
//    }

}
