//
//  ListingControllerModel.swift
//  LikePhoto
//
//  Created by A on 2/18/22.
//

import UIKit

class ListingModel {
    let profileTitle: String
    let profileImage: UIImage
    let listingImage: UIImage
    let description: String
    var statistics: (like: Int, views: Int)
    var isLiked: Bool
    var isExpanded: Bool
    let identifier: Int
    var comments: [CommentModel]
    
    var commentString: NSAttributedString {
        let string = NSMutableAttributedString(string: "")
        for comment in comments {
            let attributedString = NSMutableAttributedString(string: comment.commentOwner,
                                                             attributes: [.font : UIFont.boldSystemFont(ofSize: 17.0)])
             
            attributedString.append(NSAttributedString(string: " \(comment.commentText)",
                                                        attributes: [.font : UIFont.systemFont(ofSize: 17.0,
                                                                                               weight: .light)]))
            attributedString.append(NSAttributedString(string: "\n",
                                                        attributes: [.font : UIFont.systemFont(ofSize: 17.0,
                                                                                               weight: .light)]))
            string.append(attributedString)
        }
        return string
    }
    
    var attributedDescription: NSAttributedString {
       let attributedString = NSMutableAttributedString(string: profileTitle,
                                                        attributes: [.font : UIFont.boldSystemFont(ofSize: 17.0)])
        
        attributedString.append(NSAttributedString(string: " \(description)",
                                                   attributes: [.font : UIFont.systemFont(ofSize: 17.0,
                                                                                          weight: .light)]))
        return attributedString
    }
    
    init(profileTitle: String, profileImage: UIImage,  listingImage: UIImage,
         description: String, statistics: (like: Int, views: Int),
         isLiked: Bool, isExpanded: Bool, identifier: Int,
         comments: [CommentModel]) {
        
        self.profileTitle = profileTitle
        self.profileImage = profileImage
        self.listingImage = listingImage
        self.description = description
        self.statistics = statistics
        self.isLiked = isLiked
        self.isExpanded = isExpanded
        self.identifier = identifier
        self.comments = comments
    }
}

struct CommentModel {
    let commentOwner: String
    let commentText: String
}
