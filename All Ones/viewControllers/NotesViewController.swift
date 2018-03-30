//
//  NotesViewController.swift
//  All Ones
//
//  Created by Difeng Chen on 12/11/17.
//  Copyright © 2017 Difeng Chen. All rights reserved.
//

import UIKit

class NotesViewController: UIViewController {

    @IBOutlet weak var BView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.clear
        BView.layer.cornerRadius = 15
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
