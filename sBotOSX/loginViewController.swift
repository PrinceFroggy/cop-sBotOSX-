//
//  loginViewController.swift
//  sBotOSX
//
//  Created by Andrew Solesa on 2018-10-27.
//  Copyright © 2018 KSG. All rights reserved.
//

import Cocoa

class loginViewController: NSViewController {
    
    func returnSerialNumber() -> String?
    {
        let platformExpert = IOServiceGetMatchingService(kIOMasterPortDefault, IOServiceMatching("IOPlatformExpertDevice"))
        
        guard platformExpert > 0
            else
        {
            return nil
        }
        
        guard let serialNumber = (IORegistryEntryCreateCFProperty(platformExpert, kIOPlatformSerialNumberKey as CFString, kCFAllocatorDefault, 0).takeUnretainedValue() as? String)
            else
        {
            return nil
        }
        
        IOObjectRelease(platformExpert)
        
        return serialNumber
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        NSPasteboard.general.clearContents()
        NSPasteboard.general.setString(returnSerialNumber()!, forType: .string)
    }
    
    override func viewWillAppear()
    {
        self.view.window?.title = "cop: login"
        
        self.view.window?.styleMask.remove(.fullScreen)
        self.view.window?.styleMask.remove(.miniaturizable)
        self.view.window?.styleMask.remove(.resizable)
    }
    
    @IBAction func loginButtonPressed(_ sender: NSButton)
    {
        if let url = URL(string: "https://raw.githubusercontent.com/PrinceFroggy/Serials/master/README.md")
        {
            do
            {
                var matchedSerial: Bool = false
                
                let contents = try String(contentsOf: url)
                
                let components = contents.components(separatedBy: CharacterSet.newlines)
                
                print("--------------------")
                
                print("Printing out serials")
                
                print("--------------------")
                
                for component in components
                {
                    print(component)
                    
                    if component == returnSerialNumber()!
                    {
                        matchedSerial = true
                    }
                }
                
                print("--------------------")
                
                // SINCE THIS APP IS NOW FREE...
                matchedSerial = true
                
                if matchedSerial
                {
                    print("Matched serial from github = \(returnSerialNumber()!)")
                    
                    print("--------------------")
                    
                    self.performSegue(withIdentifier: "approvedLogin", sender:  nil)
                    
                    self.view.window?.close()
                }
                else
                {
                    print("No matching serial from github = \(returnSerialNumber()!)")
                    
                    print("--------------------")
                    
                    let alert = NSAlert()
                    alert.messageText = "serial is not registered!"
                    alert.alertStyle = .warning
                    alert.addButton(withTitle: "OK")
                    alert.runModal()
                    
                }
            }
            catch
            {
                NSApplication.shared.terminate(self)
            }
        }
        else
        {
            NSApplication.shared.terminate(self)
        }
    }
    
    @IBAction func helpButtonPressed(_ sender: NSButton)
    {
        let alert = NSAlert()
        alert.messageText = "The serial should be copied to your clipboard! Send it as a message when purchasing subscription through paypal. Please email asolesa@yahoo.ca your serial if you cannot send through paypal alongside with the proof of purchase."
        alert.alertStyle = .informational
        alert.addButton(withTitle: "OK")
        alert.runModal()
    }
    
    @IBAction func paypalButtonPressed(_ sender: NSButton)
    {
        NSWorkspace.shared.open(NSURL(string: "https://www.paypal.me/AndrewSolesa/50USD")! as URL)
    }
}
