//
//  ListingCell.swift
//  LikePhoto
//
//  Created by A on 2/18/22.
//

import UIKit

struct ListingCellModel {
    let profileTitle: String?
    let profileImage: UIImage?
    let listingImage: UIImage?
    let isLiked: Bool 
    let likeCount: String
    let photoDescription: NSAttributedString?
    let isExpand: Bool
    let identifier: Int
}

protocol ListingCellDelegate: AnyObject {
    func settingsButtonAction(id: Int)
    func bookmarkButtonAction(id: Int)
    func shareButtonAction(id: Int)
    func commentButtonAction(id: Int)
    func likeButtonAction(id: Int)
    func expandButtonTapped(id: Int)
    
    func listingImageTapped(id: Int)
}

final class ListingCell: UITableViewCell {
    @IBOutlet private weak var profileImage: UIImageView!
    @IBOutlet private weak var profileTitle: UILabel!
    @IBOutlet private weak var listingImage: UIImageView!
    @IBOutlet private weak var likeButton: UIButton!
    @IBOutlet private weak var likeCountLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    
    @IBOutlet private weak var descriptionRightConstraint: NSLayoutConstraint!
    @IBOutlet private weak var expandDescriptionButton: UIButton!
    
    private var identifier: Int?
    weak var delegate: ListingCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
//        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
//        listingImage.addGestureRecognizer(tap)
    }
    
    func setupWith(model: ListingCellModel) {
        identifier = model.identifier
    
        profileImage.layer.cornerRadius = profileImage.frame.width / 2
        profileImage.layer.masksToBounds = true
        
        likeButton.setBackgroundImage(UIImage(systemName: model.isLiked ? "heart.fill" : "heart") ,
                                      for: .normal)
        likeButton.tintColor = model.isLiked ? .red : .white
        
        likeCountLabel.text = model.likeCount
        
        descriptionLabel.attributedText = model.photoDescription
        descriptionLabel.numberOfLines = model.isExpand ? 0 : 1
        descriptionLabel.lineBreakMode = .byTruncatingTail
        descriptionRightConstraint.constant = model.isExpand ? 8 : 56
                
        if model.isExpand {
            expandDescriptionButton.isHidden = true
            descriptionRightConstraint.constant = 8
        } else {
            let isMoreThanOneLine = descriptionLabel.calculateMaxLines() > 1
            descriptionRightConstraint.constant = !isMoreThanOneLine ? 8 : 56
            expandDescriptionButton.isHidden = !isMoreThanOneLine
        }

        if let name = model.profileTitle {
            profileTitle.text = name
        }

        if let profileImg = model.profileImage {
            profileImage.image = profileImg
        }
        
        if let listingImg = model.listingImage {
            listingImage.image = listingImg
        }
    }
    
    override class func description() -> String {
        return "ListingCell"
    }
    
    @objc private func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        guard let id = identifier else { return }
        delegate?.listingImageTapped(id: id)
    }
    
    @IBAction private func settingsButtonAction(_ sender: Any) {
        guard let id = identifier else { return }
        delegate?.settingsButtonAction(id: id)
    }
    
    @IBAction private func bookmarkButtonAction(_ sender: Any) {
        guard let id = identifier else { return }
        delegate?.bookmarkButtonAction(id: id)
    }
    
    @IBAction private func shareButtonAction(_ sender: Any) {
        guard let id = identifier else { return }
        delegate?.shareButtonAction(id: id)
    }
    
    @IBAction private func commentButtonAction(_ sender: Any) {
        guard let id = identifier else { return }
        delegate?.commentButtonAction(id: id)
    }
    
    @IBAction private func likeButtonAction(_ sender: Any) {
        guard let id = identifier else { return }
        delegate?.likeButtonAction(id: id)
    }
    
    @IBAction private func expandButtonTapped(_ sender: Any) {
        guard let id = identifier else { return }
        delegate?.expandButtonTapped(id: id)
    }
}
