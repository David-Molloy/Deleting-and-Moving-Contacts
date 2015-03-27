//
//  ContactsTableViewController.swift
//  Contacts
//
//  Created by David Molloy on 26/03/2015.
//  Copyright (c) 2015 riis. All rights reserved.
//

import UIKit

class ContactsTableViewController: UITableViewController {

    var contacts = [Contact]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let moveButton = UIBarButtonItem(barButtonSystemItem: .Edit , target: self, action: Selector("toggleEdit"))
        self.navigationItem.leftBarButtonItem = moveButton
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        let jenny = Contact(phoneNumber: "867-5309")
        let rich = Contact(name:"Rich", phoneNumber:"888-888-8888")
        let mindy = Contact(name:"Mindy")
        
        self.contacts.append(jenny)
        self.contacts.append(rich)
        self.contacts.append(mindy)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func toggleEdit() {
        self.tableView.setEditing(!self.tableView.editing, animated: true)
        
        if !self.tableView.editing{
            
            let moveButton = UIBarButtonItem(barButtonSystemItem: .Edit , target: self, action: Selector("toggleEdit"))
            self.navigationItem.leftBarButtonItem = moveButton
        }else{
            let moveButton = UIBarButtonItem(barButtonSystemItem: .Done , target: self, action: Selector("toggleEdit"))
            self.navigationItem.leftBarButtonItem = moveButton
        }
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return self.contacts.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell

        let contact = self.contacts[indexPath.row]
        
        if let name = contact.name{
            cell.textLabel?.text = name
        }else{
            cell.textLabel?.text = "No Name"
        }

        return cell
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
        self.contacts.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }

    
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
        let contactMoving = self.contacts.removeAtIndex(fromIndexPath.row)
        self.contacts.insert(contactMoving, atIndex: toIndexPath.row)

    }
    
    override func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        if tableView.editing {
            return .None
        } else {
            return .Delete
        }
    }
    
    override func tableView(tableView: UITableView, shouldIndentWhileEditingRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }
    

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        let indexPath = self.tableView.indexPathForCell(sender as UITableViewCell)!
        let contact = self.contacts[indexPath.row]
        var destination = segue.destinationViewController as DetailViewController
        destination.contact = contact
    }

}
