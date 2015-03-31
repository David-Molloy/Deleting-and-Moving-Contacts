//
//  DetailViewController.swift
//  Contacts
//
//  Created by David Molloy on 27/03/2015.
//  Copyright (c) 2015 riis. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITextFieldDelegate, UISearchBarDelegate {
    
    @IBOutlet weak var myNameLabel: UILabel!
    @IBOutlet var nameField: UITextField!
    @IBOutlet var phoneNumberField: UITextField!
    var contact: Contact?
    @IBOutlet weak var scrollView: UIScrollView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.nameField.delegate = self
        self.phoneNumberField.delegate = self
        
        self.myNameLabel.text = ""

        searchInstagramByHashtag("dogs")

        // Do any additional setup after loading the view.
        
        if let contact = self.contact {
            if let name = contact.name {
                self.nameField.text = name
            }
            if let phoneNumber = contact.phoneNumber {
                self.phoneNumberField.text = phoneNumber
            }
        }
        
        //instantiate a gray Activity Indicator View
        var activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .Gray)
        //add the activity to the ViewController's view
        view.addSubview(activityIndicatorView)
        //position the Activity Indicator View in the center of the view
        activityIndicatorView.center = view.center
        //tell the Activity Indicator View to begin animating
        activityIndicatorView.startAnimating()
        
        let manager = AFHTTPRequestOperationManager()
        manager.GET( "http:/graph.facebook.com/jane.murphy.9469",
            parameters: nil,
            success: { (operation: AFHTTPRequestOperation!,responseObject: AnyObject!) in
                println("Response: " + responseObject.description)
                if let myName = responseObject["name"] as? String{
                    self.myNameLabel.text = myName
                    activityIndicatorView.removeFromSuperview()
                }
            },
            failure: { (operation: AFHTTPRequestOperation!,error: NSError!) in
                println("Error: " + error.localizedDescription)
        })
        
    }
    func searchInstagramByHashtag(searchString:String) {
        let manager = AFHTTPRequestOperationManager()
        manager.GET( "https://api.instagram.com/v1/tags/\(searchString)/media/recent?client_id=979ed22d520f462aa0a89eef082913c1",
        parameters: nil,
        success: { (operation: AFHTTPRequestOperation!,responseObject: AnyObject!) in
        if let dataArray = responseObject["data"] as? [AnyObject] {
        var urlArray:[String] = []
        for dataObject in dataArray {
        if let imageURLString = dataObject.valueForKeyPath("images.standard_resolution.url") as? String {
        urlArray.append(imageURLString)
        }
        }
            //display urlArray in ScrollView
            let imageWidth = self.view.frame.width
            self.scrollView.contentSize = CGSizeMake(imageWidth, imageWidth * CGFloat(dataArray.count))
            
            for var i = 0; i < urlArray.count; i++ {
                let imageView = UIImageView(frame: CGRectMake(0, imageWidth*CGFloat(i), imageWidth, imageWidth))
                imageView.setImageWithURL( NSURL(string: urlArray[i]))
                self.scrollView.addSubview(imageView)
            }
        
        }
        },
        failure: { (operation: AFHTTPRequestOperation!,error: NSError!) in
        println("Error: " + error.localizedDescription)
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        if textField == self.nameField {
            self.contact?.name = textField.text
        } else if textField == self.phoneNumberField {
            self.contact?.phoneNumber == textField.text
        }
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        for subview in self.scrollView.subviews {
            subview.removeFromSuperview()
        }
        searchBar.resignFirstResponder()
        searchInstagramByHashtag(searchBar.text)
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
