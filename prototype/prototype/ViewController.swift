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
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        configureItems()
    }


    private func configureItems() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Profile",
            style: .plain,
            target: self,
            action: #selector(profile)
        )
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
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
    
    @objc func profile(_ sender: UIBarButtonItem){
        if let viewController = storyboard?.instantiateViewController(withIdentifier: "ProfileController") {
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    @objc func home(_ sender: UIBarButtonItem) {
        if let viewController = storyboard?.instantiateViewController(withIdentifier: "ViewController") {
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    @objc func recipes() {
        navigationController?.pushViewController(NextViewController(nibName: "RecipesController", bundle: nil), animated: true)
    }
}

