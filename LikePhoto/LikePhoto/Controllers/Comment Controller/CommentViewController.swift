//
//  CommentViewController.swift
//  LikePhoto
//
//  Created by A on 2/18/22.
//

import UIKit

protocol CommentViewControllerDelgate: AnyObject {
    func comentSaved(identifier: Int, comment: String)
}

final class CommentViewController: UIViewController {
    @IBOutlet private weak var textField: UITextField!
    
    weak var delegate: CommentViewControllerDelgate?
    let identifier: Int
    
    
    
    init(identifier: Int) {
        self.identifier = identifier
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()

        let rightButton = UIButton(type: .system)
        rightButton.setTitle("Close", for: .normal)
        rightButton.setTitleColor(.black, for: .normal)
        rightButton.addTarget(self, action: #selector(closeAction), for: .touchUpInside)
        rightButton.contentHorizontalAlignment = .right
        rightButton.isEnabled = false
        rightButton.sizeToFit()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightButton)
    }
    
    
    @objc func closeAction() {
        dismiss(animated: true, completion: nil)
    }

    @IBAction private func saveAction(_ sender: Any) {
        
        delegate?.comentSaved(identifier: identifier, comment: "")
    }
    
}
