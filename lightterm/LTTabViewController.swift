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
    
    @IBAction func AddNewTab(AnyObject){
        var ltTabViewItem:LTTabViewItem = LTTabViewItem()
        var ltTabView:LTTabView = LTTabView()
        
        var strTabText = String(format: "%@ %d", "Tab", tabNumber++)
        
        ltTabViewItem.label = strTabText
        ltTabViewItem.view = ltTabView

        addTabViewItem(ltTabViewItem)
    }
}