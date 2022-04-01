//
//  FullPhotoNewController.swift
//  LikePhoto
//
//  Created by A on 2/18/22.
//

import UIKit

final class FullPhotoNewController: UIViewController {
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var profileImageView: UIImageView!
    @IBOutlet private weak var imageView: UIImageView!
    
    private let name: String
    private let profileImage: UIImage?
    private let image: UIImage
    
    init(name: String, profileImage: UIImage?, image: UIImage) {
        self.name = name
        self.profileImage = profileImage
        self.image = image
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = name
        profileImageView.image = profileImage
        imageView.image = image
        
        profileImageView.layer.cornerRadius = profileImageView.frame.size.width / 2
        profileImageView.layer.masksToBounds = true
    }
}
