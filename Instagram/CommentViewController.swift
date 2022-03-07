//
//  CommentViewController.swift
//  Instagram
//
//  Created by HOKO on 2022/03/07.
//

import UIKit
import Firebase
import SVProgressHUD

class CommentViewController: UIViewController {
    var postId: String?
    
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func handlePostButton(_ sender: Any) {
        if let content = textField.text {
            if content.isEmpty {
                SVProgressHUD.showError(withStatus: "コメント内容を入力してください")
                return
            }
            // 投稿データの保存場所を定義する
            let commentRef = Firestore.firestore().collection(Const.PostPath).document(postId!).collection(Const.CommentPath).document()
            // FireStoreに投稿データを保存する
            let name = Auth.auth().currentUser?.displayName
            let commentDic = [
                "name": name!,
                "content": content,
                "date": FieldValue.serverTimestamp(),
                ] as [String : Any]
            commentRef.setData(commentDic)
            // HUDで投稿完了を表示する
            SVProgressHUD.showSuccess(withStatus: "投稿しました")
            // 前の画面に戻る
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func handleCancelButton(_ sender: Any) {
        // 前の画面に戻る
        self.dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
