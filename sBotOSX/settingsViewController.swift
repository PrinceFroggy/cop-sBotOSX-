//
//  settingsViewController.swift
//  sBotOSX
//
//  Created by Andrew Solesa on 2018-10-25.
//  Copyright © 2018 KSG. All rights reserved.
//

import Cocoa

class settingsViewController: NSViewController {
    
    @IBOutlet weak var nameTextField: NSTextField!
    @IBOutlet weak var emailTextField: NSTextField!
    @IBOutlet weak var telephoneTextField: NSTextField!
    @IBOutlet weak var addressTextField: NSTextField!
    @IBOutlet weak var aptTextField: NSTextField!
    @IBOutlet weak var zipTextField: NSTextField!
    @IBOutlet weak var cityTextField: NSTextField!
    @IBOutlet weak var stateComboBox: NSComboBox!

    @IBOutlet weak var numberTextField: NSTextField!
    @IBOutlet weak var expMonthComboBox: NSComboBox!
    @IBOutlet weak var expYearComboBox: NSComboBox!
    @IBOutlet weak var cvvTextField: NSTextField!
    @IBOutlet weak var itemNameTextField: NSTextField!
    @IBOutlet weak var itemColorTextField: NSTextField!
    @IBOutlet weak var itemSizeTextField: NSTextField!
    
    @IBOutlet weak var delaySlider: NSSlider!
    
    @IBOutlet weak var delayTextField: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    override func viewWillAppear()
    {
        self.view.window?.title = "sBot: settings"
        
        self.view.window?.styleMask.remove(.closable)
        self.view.window?.styleMask.remove(.fullScreen)
        self.view.window?.styleMask.remove(.miniaturizable)
        self.view.window?.styleMask.remove(.resizable)
    }
    
    @IBAction func delaySlider(_ sender: NSSlider)
    {
        let delay: Double = sender.doubleValue
        
        let formattedDelay = String(format: "%.1f", delay)
        
        SharingManager.sharedInstance.delay = Double(formattedDelay) ?? 0.8
        
        delayTextField.stringValue = formattedDelay
    }
    
    
    @IBAction func closeButtonPressed(_ sender: NSButton)
    {
        SharingManager.sharedInstance.name = nameTextField.stringValue
        SharingManager.sharedInstance.email = emailTextField.stringValue
        SharingManager.sharedInstance.telephone = telephoneTextField.stringValue
        SharingManager.sharedInstance.address = addressTextField.stringValue
        SharingManager.sharedInstance.apt = aptTextField.stringValue
        SharingManager.sharedInstance.zip = zipTextField.stringValue
        SharingManager.sharedInstance.city = cityTextField.stringValue
        SharingManager.sharedInstance.state = stateComboBox.stringValue

        SharingManager.sharedInstance.number = numberTextField.stringValue
        SharingManager.sharedInstance.expMonth = expMonthComboBox.stringValue
        SharingManager.sharedInstance.expYear = expYearComboBox.stringValue
        SharingManager.sharedInstance.cvv = cvvTextField.stringValue
        SharingManager.sharedInstance.itemName = itemNameTextField.stringValue
        SharingManager.sharedInstance.itemColor = itemColorTextField.stringValue
        SharingManager.sharedInstance.itemSize = itemSizeTextField.stringValue
            
        self.dismiss(self)
    }
}
