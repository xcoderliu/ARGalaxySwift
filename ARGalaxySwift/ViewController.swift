//
//  ViewController.swift
//  ARGalaxySwift
//
//  Created by 刘智民 on 25/11/2017.
//  Copyright © 2017 刘智民. All rights reserved.
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

    @IBAction func enterNormalAR(_ sender: Any) {
        let arVC = ARGalaxyViewController()
        self.navigationController?.pushViewController(arVC, animated: true)
    }
    
}

