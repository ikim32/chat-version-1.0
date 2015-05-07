//
//  VistaFirstAppViewController.swift
//  FirstAppWithParse
//
//  Created by MIguel Saravia on 5/6/15.
//  Copyright (c) 2015 MIguel Saravia. All rights reserved.
//

import UIKit
import Parse


class VistaFirstAppViewController: UIViewController {

    @IBOutlet weak var contentTextField: UITextView!
    @IBOutlet weak var counterLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        contentTextField.layer.borderColor = UIColor.blackColor().CGColor
        contentTextField.layer.borderWidth = 0.5
        contentTextField.layer.cornerRadius = 5
        contentTextField.becomeFirstResponder()
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func BtnSendViewController(sender: AnyObject) {
        var content:PFObject = PFObject(className: "Contenido")
        content["content"] = self.contentTextField.text
        content["User"] = PFUser.currentUser()
        content.saveInBackground()
        
        self.navigationController?.popToRootViewControllerAnimated(true)
        
    }
}
