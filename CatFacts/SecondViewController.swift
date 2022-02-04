//
//  SecondViewController.swift
//  CatFacts
//
//  Created by Zumran Nain on 2022-01-21.
//

import UIKit

class SecondViewController: UIViewController{
    
   
  
    var statusLabel: StatusLabel = StatusLabel(verified: false, sentCount: 0)
    var eachFetchedCat: CatFacts = CatFacts(_id: " ", text: " ", user: " ", source: " ", updatedAt: " ", createdAt: " ", deleted: false, used: false, __v: 0, type: " ", status: StatusLabel(verified: false, sentCount: 0))

    //creating collection view

    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        self.view.backgroundColor = UIColor.white
        self.title =  "More Details"
        
        //creating buttons
        
        let backbutton = UIButton(type: .custom)
        backbutton.setImage(UIImage(named: "SKtqE.png"), for: .normal) // Image can be downloaded from here below link
        backbutton.setTitle("Home", for:.normal)
        backbutton.setTitleColor(backbutton.tintColor, for: .normal) // You can change the TitleColor
        backbutton.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backbutton)
                             
        //creating labels
        
        let factLabel = UILabel(frame: CGRect(x: -130, y:300, width: 1000, height: 400))
        let idLabel = UILabel(frame: CGRect(x: -130, y:400, width: 1000, height: 400))
        let userLabel = UILabel(frame: CGRect(x: -130, y: 500, width: 1000, height: 400))
        let updatedAtLabel = UILabel(frame: CGRect(x: -130, y: 600, width: 1000, height: 400))
        let createdAtLabel = UILabel(frame: CGRect(x: -130, y: 700, width: 1000, height: 400))
        let deletedLabel = UILabel(frame: CGRect(x: -130, y: 800, width: 1000, height: 400))
        let usedLabel = UILabel(frame: CGRect(x: -130, y: 900, width: 1000, height: 400))
        
      
            factLabel.textAlignment = .center
            idLabel.textAlignment = .center
            userLabel.textAlignment = .center
            updatedAtLabel.textAlignment = .center
            createdAtLabel.textAlignment = .center
            deletedLabel.textAlignment = .center
            usedLabel.textAlignment = .center
        
        
            factLabel.text = "Fact: " + eachFetchedCat.text
            factLabel.textColor = UIColor.black
            idLabel.text = "Id: " + eachFetchedCat._id
            userLabel.text = "User: " + eachFetchedCat.user
            updatedAtLabel.text = "Updated At: " + eachFetchedCat.updatedAt
            createdAtLabel.text = "Created At: " + eachFetchedCat.createdAt
            deletedLabel.text = "Deleted: " + String(eachFetchedCat.deleted)
            usedLabel.text = "Used: " + String(eachFetchedCat.used)
        
        
            factLabel.numberOfLines = 0
            idLabel.numberOfLines = 0
            userLabel.numberOfLines = 0
            updatedAtLabel.numberOfLines = 0
            createdAtLabel.numberOfLines = 0
            deletedLabel.numberOfLines = 0
            usedLabel.numberOfLines = 0
        
        
            factLabel.font = factLabel.font.withSize(17)
            idLabel.font = idLabel.font.withSize(17)
            userLabel.font = userLabel.font.withSize(17)
            updatedAtLabel.font = updatedAtLabel.font.withSize(17)
            createdAtLabel.font = createdAtLabel.font.withSize(17)
            deletedLabel.font = deletedLabel.font.withSize(17)
            usedLabel.font = usedLabel.font.withSize(17)
  
            //adding labels to stackView
        
            let stackView = UIStackView()
            stackView.axis = .vertical
            stackView.distribution = .fillEqually
            stackView.alignment = .center
        
            stackView.addArrangedSubview(factLabel)
            stackView.addArrangedSubview(idLabel)
            stackView.addArrangedSubview(userLabel)
            stackView.addArrangedSubview(updatedAtLabel)
            stackView.addArrangedSubview(createdAtLabel)
            stackView.addArrangedSubview(deletedLabel)
            stackView.addArrangedSubview(usedLabel)
        
        
            stackView.layoutMargins = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
            stackView.isLayoutMarginsRelativeArrangement = true
        
        
            stackView.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubview(stackView)
            stackView.pinEdges(to: self.view)
    
    }
    
    @objc func buttonClicked() {
        
       navigationController?.popViewController(animated: true)
        
    }
        
}

