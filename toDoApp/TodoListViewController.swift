//
//  TodoListViewController.swift
//  toDoApp
//
//  Created by 持田晴生 on 2023/11/16.
//

import UIKit
import Firebase


class TodoListViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var userNameLabel: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // ①ログイン済みかどうか確認
        if let user = Auth.auth().currentUser {
            // ②ログインしているユーザー名の取得
            Firestore.firestore().collection("users").document(user.uid).getDocument(completion: {(snapshot,error) in
                if let snap = snapshot {
                    if let data = snap.data() {
                        self.userNameLabel.text = data["name"] as? String
                    }
                } else if let error = error {
                    print("ユーザー名取得失敗: " + error.localizedDescription)
                }
            })
        }
    }

    
    @IBAction func tapAddButton(_ sender: Any) {

    }
    
    @IBAction func tapLogoutButton(_ sender: Any) {

    }
    
    @IBAction func changeDoneControl(_ sender: UISegmentedControl) {

    }
    
}
