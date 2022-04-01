//
//  ListingViewController.swift
//  LikePhoto
//
//  Created by A on 2/18/22.
//

import UIKit

final class ListingViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    
    private let dataSource = [
        ListingModel(profileTitle: "Halo",
                     profileImage: #imageLiteral(resourceName: "Снимок экрана 2021-11-08 в 2.54.37 PM"),
                     listingImage: #imageLiteral(resourceName: "Снимок экрана 2022-03-28 в 7.15.38 PM"),
                     description: "My First Action!",
                     statistics: (like: 13, views: 20),
                     isLiked: false,
                     isExpanded: false, identifier: 0,
                     comments: [CommentModel(commentOwner: "Vasya", commentText: "Wooow"), CommentModel(commentOwner: "Petya", commentText: "Nice"), CommentModel(commentOwner: "Kolya", commentText: "Coool!!!!")]),
                
        ListingModel(profileTitle: "Tomb Rieder",
                     profileImage: #imageLiteral(resourceName: "Снимок экрана 2021-11-08 в 2.56.32 PM"),
                     listingImage: #imageLiteral(resourceName: "Снимок экрана 2022-03-28 в 7.19.33 PM"),
                     description: "I'm walking )))",
                     statistics: (like: 9, views: 11),
                     isLiked: false,
                     isExpanded: false, identifier: 1, comments: []),
        ListingModel(profileTitle: "Assassin's creed",
                     profileImage: #imageLiteral(resourceName: "Снимок экрана 2021-11-08 в 2.49.13 PM"),
                     listingImage: #imageLiteral(resourceName: "Снимок экрана 2022-03-28 в 7.23.37 PM"),
                     description: "Looking at you 😉",
                     statistics: (like: 25, views: 50),
                     isLiked: true,
                     isExpanded: false, identifier: 2, comments: []),
        ListingModel(profileTitle: "Bioshock",
                     profileImage: #imageLiteral(resourceName: "Снимок экрана 2021-11-08 в 2.50.47 PM"),
                     listingImage: #imageLiteral(resourceName: "Снимок экрана 2022-03-28 в 7.26.24 PM"),
                     description: "Let's fly",
                     statistics: (like: 8, views: 23),
                     isLiked: false,
                     isExpanded: false, identifier: 3, comments: [])]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: ListingCell.description(), bundle: nil),
                           forCellReuseIdentifier: ListingCell.description())
    }
}

//MARK: - UITableViewDataSource, UITableViewDelegate
extension ListingViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ListingCell.description(),
                                                 for: indexPath) as! ListingCell
        
        let modelsArray = dataSource.compactMap({ListingCellModel(profileTitle: $0.profileTitle,
                                                                  profileImage: $0.profileImage,
                                                                  listingImage: $0.listingImage,
                                                                  isLiked: $0.isLiked,
                                                                  likeCount: "Likes: \($0.statistics.like)",
                                                                  photoDescription: $0.commentString,
                                                                  isExpand: $0.isExpanded,
                                                                  identifier: $0.identifier)})
        
        cell.setupWith(model: modelsArray[indexPath.row])
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        listingImageTapped(id: dataSource[indexPath.row].identifier)
    }
}

//MARK: - ListingCellDelegate
extension ListingViewController: ListingCellDelegate {
    func listingImageTapped(id: Int) {
        guard let data = dataSource.first(where: { $0.identifier == id}) else { return }

        let controller = FullPhotoNewController(name: data.profileTitle,
                                                profileImage: data.profileImage,
                                                image: data.listingImage)
        
        let navi = UINavigationController(rootViewController: controller )
        present(navi, animated: true, completion: nil)
    }
    
    func settingsButtonAction(id: Int) {
        
    }
    
    func bookmarkButtonAction(id: Int) {
        
    }
    
    func shareButtonAction(id: Int) {
        
    }
    
    func commentButtonAction(id: Int) {
        let controller = CommentViewController(identifier: id)

        present(UINavigationController(rootViewController: controller),
                animated: true, completion: nil)
    }
    
    func likeButtonAction(id: Int) {
        let model = dataSource.first(where: { $0.identifier == id })        
        model?.isLiked.toggle()
        
        model?.statistics.like = (model?.statistics.like ?? 0) + (model?.isLiked == true ? 1 : -1)
        tableView.reloadData()
    }
    
    func expandButtonTapped(id: Int) {
        let model = dataSource.first(where: { $0.identifier == id })
        model?.isExpanded = true
        
        tableView.reloadData()
    }
}
