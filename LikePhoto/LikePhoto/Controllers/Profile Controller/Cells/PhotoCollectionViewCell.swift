//
//  PhotoCollectionViewCell.swift
//  LikePhoto
//
//  Created by A on 2/18/22.
//

import UIKit

final class PhotoCollectionViewCell: UICollectionViewCell {
    @IBOutlet private weak var photoImageView: UIImageView!
    
    func setupWith(photo: UIImage) {
        photoImageView.image = photo
        
        photoImageView.layer.borderWidth = 1
        photoImageView.layer.borderColor = UIColor.black.cgColor
    }

    override class func description() -> String {
        return "PhotoCollectionViewCell"
    }
    
    
    
}
