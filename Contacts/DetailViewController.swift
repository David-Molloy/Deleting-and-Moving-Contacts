//
//  DetailViewController.swift
//  Contacts
//
//  Created by David Molloy on 27/03/2015.
//  Copyright (c) 2015 riis. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var phoneNumberLabel: UILabel!
    var contact: Contact?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if let contact = self.contact {
            if let name = contact.name {
                self.nameLabel.text = name
            }
            if let phoneNumber = contact.phoneNumber {
                self.phoneNumberLabel.text = phoneNumber
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
