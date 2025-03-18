//
//  ViewController.swift
//  prototype
//
//  Created by Nicole Milmine on 2025-03-18.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = ""
        configureItems()
    }


    private func configureItems() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Profile",
            style: .plain,
            target: self,
            action: #selector(profile)
        )
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "Home",
            style: .plain,
            target: self,
            action: #selector(home)
        )
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Recipes",
            style: .plain,
            target: self,
            action: #selector(recipes)
        )
    }
    
    @objc func profile(){
        
    }
    
    @objc func home() {
        
    }
    
    @objc func recipes() {
        
    }
}

