//
//  ViewController.swift
//  MMPixelExampleApp
//
//  Copyright © 2017 MediaMath. All rights reserved.
//

import UIKit
import MMPixelSdk

class ViewController: UIViewController {
    
    @IBOutlet weak var advertiserInput: UITextField!
    @IBOutlet weak var pixelInput: UITextField!
    @IBOutlet weak var debugOutput: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        debugOutput.text = ""
        MMPixelSdk.setDebugOutput(debug: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func firePixel(_ sender: Any) {
        
        view.endEditing(true)
        debugOutput.text = "Trying to fire " + advertiserInput.text! + " " + pixelInput.text!
        MMPixelSdk.report(advertiser: advertiserInput.text!, pixel: pixelInput.text!)
    }
    
}

