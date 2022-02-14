//
//  LoginViewController.swift
//  CatFacts
//
//  Created by Zumran Nain on 2022-02-08.
//
import UIKit
import SwiftUI
import FlybitsConcierge



class LoginViewController: UIViewController {
    
    let topView: UIView = {
            let view = UIView()
            view.backgroundColor =  .blue
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
    
    let emailTextField: UITextField = {
            let tf = UITextField()
             tf.autocapitalizationType = UITextAutocapitalizationType.none
            tf.translatesAutoresizingMaskIntoConstraints = false
            tf.placeholder = "Email"
            tf.borderStyle = .roundedRect
            tf.backgroundColor = UIColor(white: 0, alpha: 0.1)
            return tf
            
        }()
        
        let APIKeyTextField: UITextField = {
            let tf = UITextField()
            tf.autocapitalizationType = UITextAutocapitalizationType.none
            tf.translatesAutoresizingMaskIntoConstraints = false
            tf.placeholder = "ApiKey"
            tf.borderStyle = .roundedRect
            tf.backgroundColor = UIColor(white: 0, alpha: 0.1)
            return tf
            
        }()
    
    let button = UIButton(type: .system)
    
  //  var emailTextField: UITextField
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTopView()
 
        setupTextFields()
        
        view.backgroundColor = .white
        
        
            
    }
    
    func setupTopView() {
     
            
            view.addSubview(topView)
            
            topView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            topView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
            topView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
            topView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        }
    
    @objc private func didTapButton() {
      
        
        let email = emailTextField.text
        let apiKey = APIKeyTextField.text
        
        if(email == "" || apiKey == "") {
            return
        }
      
        
       DoLogin(email: email, apiKey: apiKey)
    
    }
    
    func DoLogin(email: String?, apiKey: String?){
        
       
        
          let idp = APIKeyConciergeIDP(email: email!, apiKey: apiKey!)
        
       
          Concierge.connect(with: idp)  { error in
              
            
              DispatchQueue.main.asyncAfter(deadline: .now() ){
             if error == nil{
                 print("Login successful")
                 let finalLayout = UICollectionViewFlowLayout()
                 
                 finalLayout.scrollDirection = .vertical
                 finalLayout.minimumLineSpacing = 1
                 finalLayout.minimumInteritemSpacing = 1
                 finalLayout.itemSize = CGSize(width: 40 , height: 50)
                 
                 let navVCTable = UINavigationController(rootViewController: FirstViewController())
                 let collectionTable = ViewController(collectionViewLayout: finalLayout)
                 collectionTable.title = "Collection View"
                 let navVcCollection = UINavigationController(rootViewController: collectionTable)
                 
                 
                 
                 let concierge = Concierge.viewController(.categories, params: [], options: [.settings,.displayNavigation])
                 concierge.title = "Concierge"
                 
                 let tabBarVC = UITabBarController()
                tabBarVC.setViewControllers([navVCTable, navVcCollection, concierge], animated: true)
                 tabBarVC.modalPresentationStyle = .fullScreen
                
                self.present(tabBarVC, animated: true, completion: nil)
    
              
             }//Flybits failed to auth
             else{
                 print("LOGIN NOT SUCCESS FUL THIS IS THE ERROR", error as Any)
                 
                 if Concierge.isConnected{
                 Concierge.disconnect(){ boolean in
                 print("DISCONNCETING")
                  
              }
                 }
                 
                 return
                 
             }
             }
          }
      
}

    func setupTextFields() {
        
          let loginButton: UIButton = {
             
              button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
              button.setTitle("Connect", for: .normal)
              button.setTitleColor(.white, for: .normal)
              button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
              button.translatesAutoresizingMaskIntoConstraints = false
              button.layer.cornerRadius = 3
              button.backgroundColor = UIColor.lightGray
              
              return button
          }()
            
        
            let stackView = UIStackView(arrangedSubviews: [emailTextField, APIKeyTextField, loginButton])
            stackView.axis = .vertical
            stackView.spacing = 10
            stackView.distribution = .fillEqually
            stackView.translatesAutoresizingMaskIntoConstraints = false
            
            //add stack view as subview to main view with AutoLayout
            view.addSubview(stackView)
            stackView.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 40).isActive = true
            stackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40).isActive = true
            stackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40).isActive = true
            stackView.heightAnchor.constraint(equalToConstant: 200).isActive = true
            
}
    

}
