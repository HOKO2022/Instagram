//
//  PostTableViewCell.swift
//  Instagram
//
//  Created by HOKO on 2022/03/01.
//

import UIKit
import Firebase
import FirebaseStorageUI

class PostTableViewCell: UITableViewCell {
    
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var commentButton: UIButton!
    @IBOutlet weak var stackView: UIStackView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    // PostDataの内容をセルに表示
    func setPostData(post postData: PostData, comment commentArray: [CommentData]?) {
        // 画像の表示
        postImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        let imageRef = Storage.storage().reference().child(Const.ImagePath).child(postData.id + ".jpg")
        postImageView.sd_setImage(with: imageRef)

        // キャプションの表示
        self.captionLabel.text = "\(postData.name!) : \(postData.caption!)"
        
        //stackViewの内容を全消去
        self.stackView.arrangedSubviews.forEach { arrangedSubview in arrangedSubview.removeFromSuperview()}
        //stackViewにコメント内容を追加
        self.stackView.translatesAutoresizingMaskIntoConstraints = false
        if commentArray != nil {
            for commentData in commentArray! {
                let commentLabel = UILabel()
                commentLabel.text = "\(commentData.name!) : \(commentData.content!)"
                commentLabel.numberOfLines = 0
                commentLabel.sizeToFit()
                self.stackView.addArrangedSubview(commentLabel)
            }
        }
        
        // 日時の表示
        self.dateLabel.text = ""
        if let date = postData.date {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm"
            let dateString = formatter.string(from: date)
            self.dateLabel.text = dateString
        }

        // いいね数の表示
        let likeNumber = postData.likes.count
        likeLabel.text = "\(likeNumber)"

        // いいねボタンの表示
        if postData.isLiked {
            let buttonImage = UIImage(named: "like_exist")
            self.likeButton.setImage(buttonImage, for: .normal)
        } else {
            let buttonImage = UIImage(named: "like_none")
            self.likeButton.setImage(buttonImage, for: .normal)
        }
    }
}
