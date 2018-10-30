//
//  SharingManager.swift
//  sBotOSX
//
//  Created by Andrew Solesa on 2018-10-28.
//  Copyright © 2018 KSG. All rights reserved.
//

import Foundation

class SharingManager
{
    var name = ""
    var email = ""
    var telephone = ""
    var address = ""
    var apt = ""
    var zip = ""
    var city = ""
    var state = ""
    
    var number = ""
    var expMonth = ""
    var expYear = ""
    var cvv = ""
    
    var itemName = ""
    var itemColor = ""
    var itemSize = ""
    
    var delay = 0.8
    
    static let sharedInstance = SharingManager()
}
