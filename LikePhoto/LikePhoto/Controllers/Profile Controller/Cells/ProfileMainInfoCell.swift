//
//  ProfileMainInfoCell.swift
//  LikePhoto
//
//  Created by A on 2/18/22.
//

import UIKit

protocol ProfileCellDelegate: AnyObject {
    func editProfile()
}

struct ProfileMainInfoCellModel {
    let profileImage: UIImage
    let nameString: String
    let interestsString: String
    let addressLabel: String
    let followersCount: String
    let followingCount: String
    let postsCount: String
}

final class ProfileMainInfoCell: UITableViewCell {
    @IBOutlet private weak var profileImage: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var interestsLabel: UILabel!
    @IBOutlet private weak var addressLabel: UILabel!
    @IBOutlet private weak var followersLabel: UILabel!
    @IBOutlet private weak var followingLabel: UILabel!
    @IBOutlet private weak var postsLabel: UILabel!
    
    weak var delegate: ProfileCellDelegate?
    
    override class func description() -> String {
        return "ProfileMainInfoCell"
    }
        
    func setupWith(model: ProfileMainInfoCellModel) {
        profileImage.layer.cornerRadius = profileImage.frame.height/2
                
        profileImage.image = model.profileImage
        nameLabel.text = model.nameString
        interestsLabel.text = model.interestsString
        addressLabel.text = model.addressLabel
        followersLabel.text = model.followersCount
        followingLabel.text = model.followingCount
        postsLabel.text = model.postsCount

    }
    
    @IBAction private func pressedEditProfileButton(_ sender: UIButton) {
        delegate?.editProfile()
    }    
}
