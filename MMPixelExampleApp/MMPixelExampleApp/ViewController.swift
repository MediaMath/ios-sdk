//
//  ViewController.swift
//  MMPixelExampleApp
//
//  Copyright © 2017 MediaMath. All rights reserved.
//

import UIKit
import MMPixelSDK

class ViewController: UIViewController {
    
    @IBOutlet weak var advertiserInput: UITextField!
    @IBOutlet weak var pixelInput: UITextField!
    @IBOutlet weak var debugOutput: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        debugOutput.text = ""
        MMPixel.setDebugOutput(debug: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func firePixel(_ sender: Any) {
        
        view.endEditing(true)
        let additionalParams = ["s1": "test", "mt_exem": "test@email.com"] // when using a dictionary, the mt_exem email is automatically hashed.
        debugOutput.text = "Trying to fire " + advertiserInput.text! + " " + pixelInput.text!
        MMPixel.report(advertiser: advertiserInput.text!, pixel: pixelInput.text!, addlParams: additionalParams)
    }
    
}

