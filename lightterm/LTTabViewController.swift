//
//  LTTabViewController.swift
//  lightterm
//
//  Created by Alex Jeong on 9/18/15.
//  Copyright (c) 2015 Netsarang. All rights reserved.
//

import Cocoa

class LTTabViewController: NSTabViewController {    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    var tabNumber = 1;
    
    @IBAction func AddNewTab(_: AnyObject){
        let ltTabViewItem:LTTabViewItem = LTTabViewItem()
        let ltTabView:LTTabView = LTTabView()
        
        let strTabText = String(format: "%@ %d", "Tab", tabNumber++)
        
        ltTabViewItem.label = strTabText
        ltTabViewItem.view = ltTabView

        addTabViewItem(ltTabViewItem)
    }
}