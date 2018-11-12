//
//  ViewController.swift
//  sBotOSX
//
//  Created by Andrew Solesa on 2018-10-24.
//  Copyright © 2018 KSG. All rights reserved.
//

import Cocoa
import WebKit
import Kanna

class ViewController: NSViewController {

    @IBOutlet weak var supremeWKWebView: WKWebView!
    
    @IBOutlet weak var botButton: NSButton!
    
    var settingsViewController: NSViewController?
    
    var buttonSwitch: Bool = true
    
    var heartBeat: Bool = false
    
    let browserDelay = DispatchQueue(label: "browswerBackground", qos: .userInitiated)
    
    var delay = 0.0
    
    var countColorTotal = 0
    
    var countTotalSize = 0
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        //https://www.supremenewyork.com/mobile/
        //https://www.kanyetothe.com/forum/index.php
        
        //yourWebViewInstance.customUserAgent = "Mozilla/5.0 (iPhone; CPU iPhone OS 9_3 like Mac OS X) AppleWebKit/601.1.46 (KHTML, like Gecko) Version/9.0 Mobile/13E188a Safari/601.1"
        
        //yourWebViewInstance.customUserAgent = Mozilla/5.0 (iPhone; CPU iPhone OS 12_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/12.0 Mobile/15E148 Safari/604.1
        
        let urlReq = URLRequest(url: URL(string: "https://www.supremenewyork.com/mobile/")!)
        
        self.supremeWKWebView.load(urlReq)
    }

    override func viewWillAppear()
    {
        self.view.window?.title = "cop"
        
        self.view.window?.styleMask.remove(.fullScreen)
        self.view.window?.styleMask.remove(.miniaturizable)
        self.view.window?.styleMask.remove(.resizable)
    }
    
    override var representedObject: Any?
    {
        didSet
        {
        // Update the view, if already loaded.
        }
    }
    
    @IBAction func settingsButtonPressed(_ sender: NSButton)
    {
        if (self.settingsViewController == nil)
        {
            let storyBoard = NSStoryboard(name: "Main", bundle: nil) as NSStoryboard
            settingsViewController = storyBoard.instantiateController(withIdentifier: "settings") as? NSViewController
        }
        
        self.presentAsModalWindow(settingsViewController!)
    }
    
    @IBAction func reloadButtonPressed(_ sender: NSButton)
    {
        let urlReq = URLRequest(url: URL(string: "https://www.supremenewyork.com/mobile/")!)
        
        self.supremeWKWebView.load(urlReq)
    }
    
    @IBAction func botButtonPressed(_ sender: Any)
    {
        if !SharingManager.sharedInstance.itemName.isEmpty
        {
            if buttonSwitch
            {
                delay = SharingManager.sharedInstance.delay
                
                print("------------------------------------")
                print("Printing settings before launch")
                print("------------------------------------")
                print("name = \(SharingManager.sharedInstance.name)")
                print("email = \(SharingManager.sharedInstance.email)")
                print("telephone = \(SharingManager.sharedInstance.telephone)")
                print("address = \(SharingManager.sharedInstance.address)")
                print("apt = \(SharingManager.sharedInstance.apt)")
                print("zip = \(SharingManager.sharedInstance.zip)")
                print("city = \(SharingManager.sharedInstance.city)")
                print("state = \(SharingManager.sharedInstance.state)")
                print("number = \(SharingManager.sharedInstance.number)")
                print("expMonth = \(SharingManager.sharedInstance.expMonth)")
                print("expYear = \(SharingManager.sharedInstance.expYear)")
                print("cvv = \(SharingManager.sharedInstance.cvv)")
                print("itemName = \(SharingManager.sharedInstance.itemName)")
                print("itemColor = \(SharingManager.sharedInstance.itemColor)")
                print("itemSize = \(SharingManager.sharedInstance.itemSize)")
                print("delay = \(self.delay)")
                print("------------------------------------")
            
                print("-------------")
                print("Calling start")
                print("-------------")
            
                startBot()
            }
            else
            {
                print("-------------")
                print("Calling stop")
                print("-------------")
            
                stopBot()
            }
        }
        else
        {
            let alert = NSAlert()
            alert.messageText = "Cannot bot until settings are filled!"
            alert.alertStyle = .warning
            alert.addButton(withTitle: "OK")
            alert.runModal()
        }
    }
    
    func startBot()
    {
        print("------------")
        print("Starting bot")
        print("------------")
        
        self.botButton.image = NSImage(named: NSImage.Name("close"))
        
        buttonSwitch = false
        
        heartBeat = true
        
        AI_FirstStep_LoadCategory_FindItem()
    }
    
    func stopBot()
    {
        print("------------")
        print("Stopping bot")
        print("------------")
        
        self.botButton.image = NSImage(named: NSImage.Name("add"))
        
        buttonSwitch = true
        
        heartBeat = false
    }
    
    func AI_FirstStep_LoadCategory_FindItem()
    {
        //DispatchQueue.global(qos: .background).async
        DispatchQueue.main.async
        {
            if (!self.heartBeat) { print("Stopping"); return }
            
            print("Loading supreme website")
            
            let urlReq = URLRequest(url: URL(string: "https://www.supremenewyork.com/mobile/")!)
            
            self.supremeWKWebView.load(urlReq)
            
            self.browserDelay.asyncAfter(deadline: .now() + self.delay)
            {
                DispatchQueue.main.async
                    {
                        if (!self.heartBeat) { print("Stopping"); return }
            
                        print("Clicking new category")
            
                        self.supremeWKWebView.evaluateJavaScript("document.getElementById(\"new-category\").click()", completionHandler:
                            { (html: Any?, error: Error?) in
                    
                                if (!self.heartBeat) { print("Stopping"); return }
                    
                                print("Gathering list")
                    
                                self.browserDelay.asyncAfter(deadline: .now() + self.delay)
                                {
                                    DispatchQueue.main.async
                                        {
                                            self.supremeWKWebView.evaluateJavaScript("document.documentElement.outerHTML.toString()", completionHandler:
                                                { (html: Any?, error: Error?) in
                        
                                                    if (!self.heartBeat) { print("Stopping"); return }
                            
                                                    print("Sorting list")
                            
                                                    let htmlText = html as! String
                                        
                                                    var foundItem = false
                                                    var count = 0
                                        
                                                    if let doc = try? Kanna.HTML(html: htmlText, encoding: .utf8)
                                                    {
                                                        for item in doc.css("div[class^='clearfix']")
                                                        {
                                                            let itemText = item.text!
                                                
                                                            let formattedItemText = itemText.replacingOccurrences(of: "new", with: "", options: NSString.CompareOptions.literal, range:nil).lowercased()
                                                
                                                            let wishListItem = SharingManager.sharedInstance.itemName.lowercased()
                                                
                                                            if formattedItemText.range(of:wishListItem) != nil
                                                            {
                                                                print("Found item: \(formattedItemText)")
                                                    
                                                                foundItem = true
                                                    
                                                                break
                                                            }
                                                
                                                            count += 1
                                                        }
                                                    }
                                        
                                                    if (foundItem)
                                                    {
                                                        if (!self.heartBeat) { print("Stopping"); return }
                                            
                                                        print("Clicking item")
                                                        
                                                        self.AI_SecondStep_ClickItem_CountColor(withItemIndex: count)
                                                    }
                                                    else
                                                    {
                                                        if (!self.heartBeat) { print("Stopping"); return }
                                            
                                                        print("Restarting")
                                                        
                                                        self.AI_FirstStep_LoadCategory_FindItem()
                                                    }
                                                })
                                        }
                                    }
                                })
                    }
            }
        }
    }
    
    func AI_SecondStep_ClickItem_CountColor(withItemIndex itemIndex: Int)
    {
        DispatchQueue.main.async
        {
            if (!self.heartBeat) { print("Stopping"); return }
            
            self.countColorTotal = 0
            
            self.supremeWKWebView.evaluateJavaScript("document.getElementsByClassName(\"clearfix\")[\(itemIndex)].click()", completionHandler: nil)
            
            let wishListColor = SharingManager.sharedInstance.itemColor
            
            if (!wishListColor.isEmpty)
            {
                self.browserDelay.asyncAfter(deadline: .now() + self.delay)
                {
                    DispatchQueue.main.async
                    {
                        self.supremeWKWebView.evaluateJavaScript("document.documentElement.outerHTML.toString()", completionHandler:
                        { (html: Any?, error: Error?) in
                            
                            if (!self.heartBeat) { print("Stopping"); return }
                            
                            let htmlText = html as! String
                            
                            if let doc = try? Kanna.HTML(html: htmlText, encoding: .utf8)
                            {
                                for _ in doc.css("div[class^='style-images']")
                                {
                                    self.countColorTotal += 1
                                }
                                
                                print("count color = \(self.countColorTotal)")
                                
                                self.AI_ThirdStep_LoadStyle()
                            }
                            
                        })
                    }
                }
            }
            else
            {
                let wishListSize = SharingManager.sharedInstance.itemSize
                
                if (wishListSize.isEmpty)
                {
                    self.AI_FifthStep_AddItem()
                }
                else
                {
                    self.AI_FourthStep_FindSize()
                }
            }
        }
    }
    
    func AI_ThirdStep_LoadStyle()
    {
        DispatchQueue.main.async
        {
            if (!self.heartBeat) { print("Stopping"); return }
            
            var foundItemColor = 0
            var countColors = 1
            var foundItemColorBool = false
            
            for countColor in 0..<self.countColorTotal
            {
                self.supremeWKWebView.evaluateJavaScript("document.getElementsByClassName(\"style-images\")[\(countColor)].firstElementChild.click()", completionHandler: nil)
                
                self.supremeWKWebView.evaluateJavaScript("document.documentElement.outerHTML.toString()", completionHandler:
                { (html: Any?, error: Error?) in
                    
                    if (!self.heartBeat) { print("Stopping"); return }
                    
                    let htmlText = html as! String
                    
                    if let doc = try? Kanna.HTML(html: htmlText, encoding: .utf8)
                    {
                        for itemColor in doc.css("p[id^='style-name']")
                        {
                            let itemColor = itemColor.text!
                            
                            let formattedItemColor = itemColor.lowercased()
                            
                            let wishListItemColor = SharingManager.sharedInstance.itemColor.lowercased()
                            
                            if formattedItemColor.range(of: wishListItemColor) != nil
                            {
                                foundItemColorBool = true
                                
                                print("Found color: \(formattedItemColor)")
                                
                                if (!self.heartBeat) { print("Stopping"); return }
                                
                                self.supremeWKWebView.evaluateJavaScript("document.getElementsByClassName(\"style-images\")[\(foundItemColor)].firstElementChild.click()", completionHandler: nil)
                                
                                self.browserDelay.asyncAfter(deadline: .now() + self.delay)
                                {
                                    DispatchQueue.main.async
                                    {
                                        self.supremeWKWebView.evaluateJavaScript("document.documentElement.outerHTML.toString()", completionHandler:
                                            { (html: Any?, error: Error?) in
                                                
                                                if (!self.heartBeat) { print("Stopping"); return }
                                                
                                                let htmlText = html as! String
                                                
                                                if let doc = try? Kanna.HTML(html: htmlText, encoding: .utf8)
                                                {
                                                    for _ in doc.css("option[value^='']")
                                                    {
                                                        self.countTotalSize += 1
                                                    }
                                                }
                                                
                                                self.AI_FourthStep_FindSize()
                                            })
                                    }
                                }
                            }
                            
                            if (countColors == self.countColorTotal && !foundItemColorBool)
                            {
                                print("DIDNT FIND COLOR")
                                self.stopBot()
                            }
                            
                            foundItemColor += 1
                            countColors += 1
                        }
                    }
                })
            }
        }
    }
    
    func AI_FourthStep_FindSize()
    {
        DispatchQueue.main.async
        {
            if (!self.heartBeat) { print("Stopping"); return }
            
            var foundItemSize = false
            
            self.browserDelay.asyncAfter(deadline: .now() + self.delay)
            {
                DispatchQueue.main.async
                    {
                        self.supremeWKWebView.evaluateJavaScript("document.documentElement.outerHTML.toString()", completionHandler:
                        { (html: Any?, error: Error?) in
                
                            if (!self.heartBeat) { print("Stopping"); return }
                            
                            let htmlText = html as! String
                
                            if let doc = try? Kanna.HTML(html: htmlText, encoding: .utf8)
                            {
                                for itemSize in doc.css("option[value^='']")
                                {
                                    let itemSizeText = itemSize.text!.lowercased()
                        
                                    let wishListItemSize = SharingManager.sharedInstance.itemSize.lowercased()
                        
                                    if itemSizeText.range(of: wishListItemSize) != nil
                                    {
                                        print("Found size")
                            
                                        foundItemSize = true
                            
                                        let itemSizeValue = itemSize["value"]
                            
                                        self.supremeWKWebView.evaluateJavaScript("document.getElementById(\"size-options\").value = \(itemSizeValue!)", completionHandler: nil)
                            
                                        break
                                        
                                    }
                                }
                            }
                
                            if (foundItemSize)
                            {
                                self.AI_FifthStep_AddItem()
                            }
                            else
                            {
                                print("DIDNT FIND SIZE")
                                self.stopBot()
                            }
                        })
                    }
            }
        }
    }
    
    func AI_FifthStep_AddItem()
    {
        DispatchQueue.main.async
        {
            if (!self.heartBeat) { print("Stopping"); return }
            
            self.browserDelay.asyncAfter(deadline: .now() + self.delay)
            {
                DispatchQueue.main.async
                {
                    if (!self.heartBeat) { print("Stopping"); return }
                    
                    self.supremeWKWebView.evaluateJavaScript("document.getElementsByClassName(\"cart-button\")[0].click()", completionHandler: nil)
            
                    self.browserDelay.asyncAfter(deadline: .now() + self.delay)
                    {
                        DispatchQueue.main.async
                        {
                            if (!self.heartBeat) { print("Stopping"); return }
                            
                            self.supremeWKWebView.evaluateJavaScript("document.getElementById(\"checkout-now\").click()", completionHandler: nil)
                            
                            self.AI_SixthStep_PasteInformation()
                        }
                    }
                }
            }
        }
    }
    
    func AI_SixthStep_PasteInformation()
    {
        DispatchQueue.main.async
        {
            if (!self.heartBeat) { print("Stopping"); return }
            
            self.browserDelay.asyncAfter(deadline: .now() + self.delay)
            {
                DispatchQueue.main.async
                    {
                        if (!self.heartBeat) { print("Stopping"); return }
                        
                        self.supremeWKWebView.evaluateJavaScript("document.getElementById(\"order_billing_name\").value = \"\(SharingManager.sharedInstance.name)\"", completionHandler: nil)
            
                        self.supremeWKWebView.evaluateJavaScript("document.getElementById(\"order_email\").value = \"\(SharingManager.sharedInstance.email)\"", completionHandler: nil)
            
                        self.supremeWKWebView.evaluateJavaScript("document.getElementById(\"order_tel\").value = \"\(SharingManager.sharedInstance.telephone)\"", completionHandler: nil)
        
                        self.supremeWKWebView.evaluateJavaScript("document.getElementById(\"order_billing_address\").value = \"\(SharingManager.sharedInstance.address)\"", completionHandler: nil)
            
                        self.supremeWKWebView.evaluateJavaScript("document.getElementById(\"order_billing_address_2\").value = \"\(SharingManager.sharedInstance.apt)\"", completionHandler: nil)
            
                        self.supremeWKWebView.evaluateJavaScript("document.getElementById(\"obz\").value = \"\(SharingManager.sharedInstance.zip)\"", completionHandler: nil)
            
                        self.supremeWKWebView.evaluateJavaScript("document.getElementById(\"order_billing_city\").value = \"\(SharingManager.sharedInstance.city)\"", completionHandler: nil)
            
                        self.supremeWKWebView.evaluateJavaScript("document.getElementById(\"order_billing_state\").value = \"\(SharingManager.sharedInstance.state)\"; document.getElementById(\"order_billing_state\").dispatchEvent(new Event('change'));", completionHandler: nil)
            
                        self.supremeWKWebView.evaluateJavaScript("document.getElementById(\"credit_card_n\").value = \"\(SharingManager.sharedInstance.number)\"", completionHandler: nil)
            
                        self.supremeWKWebView.evaluateJavaScript("document.getElementById(\"credit_card_month\").value = \"\(SharingManager.sharedInstance.expMonth)\"; document.getElementById(\"credit_card_month\").dispatchEvent(new Event('change'));", completionHandler: nil)
            
                        self.supremeWKWebView.evaluateJavaScript("document.getElementById(\"credit_card_year\").value = \"\(SharingManager.sharedInstance.expYear)\"; document.getElementById(\"credit_card_year\").dispatchEvent(new Event('change'));", completionHandler: nil)
            
                        self.supremeWKWebView.evaluateJavaScript("document.getElementById(\"cav\").value = \"\(SharingManager.sharedInstance.cvv)\"", completionHandler: nil)
            
                        self.supremeWKWebView.evaluateJavaScript("document.getElementById(\"order_terms\").click()", completionHandler: nil)
            
                        self.supremeWKWebView.evaluateJavaScript("document.getElementById(\"submit_button\").click()", completionHandler: nil)
                        
                        self.stopBot()
                }
            }
        }
    }
}
