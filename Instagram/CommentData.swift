//
//  CommentData.swift
//  Instagram
//
//  Created by HOKO on 2022/03/07.
//

import UIKit
import Firebase

class CommentData: NSObject {
    var id: String
    var name: String?
    var content: String?
    var date: Date?

    init(document: QueryDocumentSnapshot) {
        self.id = document.documentID

        let commentDic = document.data()

        self.name = commentDic["name"] as? String

        self.content = commentDic["content"] as? String
        
        let timestamp = commentDic["date"] as? Timestamp
        self.date = timestamp?.dateValue()
    }
}
