//
//  Contact.swift
//  Contacts
//
//  Created by David Molloy on 26/03/2015.
//  Copyright (c) 2015 riis. All rights reserved.
//

import UIKit

class Contact: NSObject {
    var name: String?
    var phoneNumber: String?
    
    init(name: String? = nil, phoneNumber: String? = nil){
        self.name = name
        self.phoneNumber = phoneNumber
        super.init()
    }
}
