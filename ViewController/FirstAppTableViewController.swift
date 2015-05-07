//
//  FirstAppTableViewController.swift
//  FirstAppWithParse
//
//  Created by MIguel Saravia on 5/6/15.
//  Copyright (c) 2015 MIguel Saravia. All rights reserved.
//

import UIKit
import Parse
import Bolts

class FirstAppTableViewController: UITableViewController {
    
    var objectArray:NSMutableArray = NSMutableArray()
    override func viewDidLoad() {
        super.viewDidLoad()
    }
     required init(coder aDecoder: NSCoder!) {
        super.init(coder: aDecoder)
    }
 @IBAction func loadData(){
        objectArray.removeAllObjects()
        var findObjectArray: PFQuery = PFQuery(className: "Contenido")
        findObjectArray.findObjectsInBackgroundWithBlock(
            {(objects:[AnyObject]?, error:NSError?) -> Void in
            if error == nil {
                for object in objects! {
                    let contents:PFObject = object as! PFObject
                    self.objectArray.addObject(object)
                }
            }
                let array:NSArray = self.objectArray.reverseObjectEnumerator().allObjects
                self.objectArray =  NSMutableArray(array: array)
                self.tableView.reloadData()
        })
    }
    override func viewDidAppear(animated: Bool) {
        self.loadData()
        if((PFUser.currentUser()) == nil){
            var loggin:UIAlertController = UIAlertController(title: "Sing up or loggin", message: "Please sign up or loggin", preferredStyle: UIAlertControllerStyle.Alert)
            loggin.addTextFieldWithConfigurationHandler({ ( textField: UITextField!) in
                
                textField.placeholder = "Your name"
            })
            
            loggin.addTextFieldWithConfigurationHandler({(textField: UITextField!) in
            
                textField.placeholder = "Password"
                textField.secureTextEntry = true
            })
            loggin.addAction(UIAlertAction(title: "Login", style: UIAlertActionStyle.Default, handler: {
                alertAction in
            
                let textField = loggin.textFields
                let usernametextField: UITextField = textField![0] as! UITextField
                let passwordtextField: UITextField = textField![1] as! UITextField
                
                var usuarios:PFUser = PFUser()
                usuarios.username = usernametextField.text
                usuarios.password = passwordtextField.text
                
               usuarios.signUpInBackgroundWithBlock {
                    (success:Bool , error:NSError?) -> Void in
                    if error != nil {
                        println("Sign up success")
                    }else{
                        let errorString = error?.localizedDescription
                    }
                }
                
            
            }))
            self.presentViewController(loggin, animated: true, completion: nil)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
extension FirstAppTableViewController: UITableViewDataSource {
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.objectArray.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("FirstAppCell", forIndexPath: indexPath) as! FirstAppTableViewCell
        let contenido:PFObject = self.objectArray[indexPath.row] as! PFObject
        
        cell.textFieldViewController.alpha = 0
        cell.timestamLabel.alpha = 0
        cell.usernameLabel.alpha = 0
        
        cell.textFieldViewController.text = contenido.objectForKey("content") as! String
        
        
        var dataFormatter:NSDateFormatter = NSDateFormatter()
        dataFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        cell.timestamLabel.text = dataFormatter.stringFromDate(contenido.createdAt!)
        var findContenido:PFQuery = PFUser.query()!
        let users = "User"
       // findContenido.whereKey("objectId", equalTo: contenido.objectForKey("User")?.objectId!)
        
        findContenido.findObjectsInBackgroundWithBlock({
           (objects:[AnyObject]?, error:NSError?) -> Void in
          if error == nil{
            //  let user:PFUser = (objects as! NSArray).lastObject as! PFUser
                 cell.usernameLabel.text = contenido.objectForKey("User")?.objectForKey("username") as? String
                
                UIView.animateWithDuration(0.5, animations: {
                    cell.textFieldViewController.alpha = 1
                    cell.timestamLabel.alpha = 1
                    cell.usernameLabel.alpha = 1
                })
            }
        })

        return cell
    }
}
