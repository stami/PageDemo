//
//  ViewController.swift
//  PageDemo
//
//  Created by Samuli Tamminen on 18.7.2017.
//  Copyright © 2017 Samuli Tamminen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var openWelcomeScreen: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


    // Manual unwind segue
    @IBAction func unwindToMainViewController(segue: UIStoryboardSegue) {
    }
}
