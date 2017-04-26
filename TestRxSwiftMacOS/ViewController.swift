//
//  ViewController.swift
//  TestRxSwiftMacOS
//
//  Created by Calvix on 2017/4/26.
//  Copyright © 2017年 Calvix. All rights reserved.
//

import Cocoa
import RxSwift

class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        testBasic()
//        testSubject()
        testCombine()
        
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
}

