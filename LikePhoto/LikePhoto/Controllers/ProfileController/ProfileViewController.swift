//
//  ProfileViewController.swift
//  LikePhoto
//
//  Created by A on 2/18/22.
//

import UIKit

struct ProfileControllerModel {
    let profileImage: UIImage
    let nameString: String
    let interestsString: String
    let addressLabel: String
    let followersCount: String
    let followingCount: String
    let postsCount: String
    let photos: [UIImage]
}

final class ProfileViewController: UIViewController {
//    @IBOutlet private weak var tableView: UITableView!
    
    @IBOutlet private weak var tableView: UITableView!
    
    enum ControllerSections {
        case mainInfo
        case photos
    }
    
    private let profileModel: ProfileControllerModel
    private let dataSource: [ControllerSections] = [.mainInfo, .photos]
    
    required init?(coder: NSCoder) {
        profileModel = ProfileControllerModel(profileImage: #imageLiteral(resourceName: "Снимок экрана 2021-11-03 в 8.28.10 PM"),
                                              nameString: "Bloodborne",
                                              interestsString: "Hunter",
                                              addressLabel: "Minsk",
                                              followersCount: "10",
                                              followingCount: "5",
                                              postsCount: "0",
                                              photos: [#imageLiteral(resourceName: "Снимок экрана 2021-11-03 в 10.36.15 PM"), #imageLiteral(resourceName: "Снимок экрана 2021-11-03 в 10.35.14 PM"), #imageLiteral(resourceName: "Снимок экрана 2021-11-03 в 8.28.10 PM"), #imageLiteral(resourceName: "Снимок экрана 2021-11-03 в 8.29.09 PM"), #imageLiteral(resourceName: "Снимок экрана 2021-11-03 в 10.36.15 PM"), #imageLiteral(resourceName: "Снимок экрана 2021-11-03 в 10.35.40 PM")])
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: ProfileMainInfoCell.description(),
                                 bundle: nil),
                           forCellReuseIdentifier: ProfileMainInfoCell.description())
        
        tableView.register(UINib(nibName: ProfilePhotosCell.description(),
                                 bundle: nil),
                           forCellReuseIdentifier: ProfilePhotosCell.description())
    }
    
    private func setupPhotosHeightFor(width: CGFloat) -> CGFloat {
        let squareHeight = width / 3
        let rowsCount = Int(profileModel.photos.count / 3)
        let additionRow = profileModel.photos.count%3 > 0 ? 1 : 0
        let rowsSumm = rowsCount + additionRow

        return squareHeight * CGFloat(rowsSumm)
    }
}


//MARK: - UITableViewDataSource, UITableViewDelegate
extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if dataSource[indexPath.row] == .photos {
            return setupPhotosHeightFor(width: tableView.frame.width)
            
        } else {
            return UITableView.automaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch dataSource[indexPath.row] {
        case .mainInfo:
            let cell = tableView.dequeueReusableCell(withIdentifier: ProfileMainInfoCell.description(),
                                                     for: indexPath) as! ProfileMainInfoCell
            
            let model = ProfileMainInfoCellModel(profileImage: profileModel.profileImage,
                                                 nameString: profileModel.nameString,
                                                 interestsString: profileModel.interestsString,
                                                 addressLabel: profileModel.addressLabel,
                                                 followersCount: profileModel.followersCount,
                                                 followingCount: profileModel.followingCount,
                                                 postsCount: profileModel.postsCount)
            cell.setupWith(model: model)
           
            return cell
        case .photos:
            let cell = tableView.dequeueReusableCell(withIdentifier: ProfilePhotosCell.description(),
                                                     for: indexPath) as! ProfilePhotosCell
            cell.delegate = self
            cell.setupWith(photos: profileModel.photos)
            return cell
        }
    }
}

extension ProfileViewController: ProfilePhotosCellDelegate {
    func photoSelected(_ photo: UIImage) {
        let controller = FullPhotoNewController(name: "John",
                                                profileImage: #imageLiteral(resourceName: "Third"),
                                                image: photo)
        present(controller, animated: true, completion: nil)
    }
}
