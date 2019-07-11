//
//  ViewController.swift
//  VideoSearchApp
//
//  Created by kk-project on 2019/07/03.
//  Copyright © 2019 kk-project. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var searchTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

    }

    @IBAction func searchButton(_ sender: Any) {
        guard let txt = searchTextField.text, !txt.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            print("不正な検索ワードです。")
            return
        }

        print("検索ワード:\(txt)")
        let nc = VideoListTableViewController.makeInstance(searchWord: txt)
        self.navigationController?.pushViewController(nc, animated: true)

    }
}

