//
//  IAPService.swift
//  All Ones
//
//  Created by Difeng Chen on 12/20/17.
//  Copyright © 2017 Difeng Chen. All rights reserved.
//

import Foundation
import StoreKit
import SwiftyStoreKit
import CoreData

class IAPService: NSObject{
    private override init(){}
    static let shared = IAPService()
    
    var products = [SKProduct]()
    let paymentQueue = SKPaymentQueue.default()
    func getProducts() {
        let products: Set = [IAPProduct.Coins100.rawValue,
                             IAPProduct.Coins500.rawValue,
                             IAPProduct.Coins1000.rawValue,
                             IAPProduct.MonthlySilver.rawValue,
                             IAPProduct.MontylyGold.rawValue]
        let request = SKProductsRequest(productIdentifiers: products)
        request.delegate = self
        request.start()
        paymentQueue.add(self)
    }
    
    func purchase(product: IAPProduct){
        NetworkActivityIndicatorManager.NetworkOperationStarted()
        guard let productToPurchase = products.filter({ $0.productIdentifier == product.rawValue}).first
            else{ return }
        let payment = SKPayment(product: productToPurchase)
        paymentQueue.add(payment)
        
        SwiftyStoreKit.purchaseProduct(product.rawValue, atomically: true) { result in
            if case .success(let product) = result {
                if(product.productId == "allones.100coins"){
                    let coins:Coins = NSEntityDescription.insertNewObject(forEntityName: "Coins", into: DatabaseController.getContext()) as! Coins
                    coins.amount = 100
                    DatabaseController.saveContext()
                }else if(product.productId == "allones.500coins"){
                    let coins:Coins = NSEntityDescription.insertNewObject(forEntityName: "Coins", into: DatabaseController.getContext()) as! Coins
                    coins.amount = 500
                    DatabaseController.saveContext()
                }else if(product.productId == "allones.1000coins"){
                    let coins:Coins = NSEntityDescription.insertNewObject(forEntityName: "Coins", into: DatabaseController.getContext()) as! Coins
                    coins.amount = 1000
                    DatabaseController.saveContext()
                }
            }else{
                print(result)
            }
        }
    }
    
}

extension IAPService: SKProductsRequestDelegate{
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        self.products = response.products
        for product in response.products{
            print(product.localizedTitle)
        }
    }
    
}

extension IAPService: SKPaymentTransactionObserver{
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions{
            print(transaction.transactionState.status(), transaction.payment.productIdentifier)
            switch transaction.transactionState{
            case .purchasing:break
            default: queue.finishTransaction(transaction)
            }
            
        }
        
    }
}

extension SKPaymentTransactionState{
    func status() -> String{
        switch self {
        case .deferred: return "deferred"
        case .failed: return "failed"
        case .purchased: return "purchased"
        case .purchasing: return "purchasing"
        case .restored: return "restored"
        }
    }
}
