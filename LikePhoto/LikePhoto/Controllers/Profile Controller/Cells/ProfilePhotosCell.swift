//
//  ProfilePhotosCell.swift
//  LikePhoto
//
//  Created by A on 2/18/22.
//

import UIKit

protocol ProfilePhotosCellDelegate: AnyObject {
    func photoSelected(_ photo: UIImage)
}

final class ProfilePhotosCell: UITableViewCell {
    @IBOutlet private weak var collectionView: UICollectionView!
    private var dataSource: [UIImage] = []

    weak var delegate: ProfilePhotosCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()

        collectionView.delegate = self
        collectionView.dataSource = self
        
        let nib = UINib(nibName: PhotoCollectionViewCell.description(), bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: PhotoCollectionViewCell.description())
    }
    
    func setupWith(photos: [UIImage]) {
        dataSource = photos
        collectionView.reloadData()
    }
    
    override class func description() -> String {
        return "ProfilePhotosCell"
    }
}

//MARK: - UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
extension ProfilePhotosCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let photo = dataSource[indexPath.row]
        delegate?.photoSelected(photo)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.description(), for: indexPath) as! PhotoCollectionViewCell
        cell.setupWith(photo: dataSource[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let size = collectionView.frame.width / 3
        return CGSize(width: size, height: size)
    }
}
