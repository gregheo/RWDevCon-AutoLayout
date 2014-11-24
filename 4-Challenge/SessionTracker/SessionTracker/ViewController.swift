//
//  ViewController.swift
//  SessionTracker
//
//  Created by Greg Heo on 2014-11-23.
//  Copyright (c) 2014 Razeware LLC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  @IBOutlet weak var greenViewHeightConstraint: NSLayoutConstraint!

  @IBAction func expandTapped(sender: AnyObject) {
    if greenViewHeightConstraint.constant == 0 {
      greenViewHeightConstraint.constant = 100
    } else {
      greenViewHeightConstraint.constant = 0
    }
  }
}

