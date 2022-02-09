//
//  ViewController.swift
//  CatFacts
//
//  Created by Zumran Nain on 2022-01-19.
//

import FlybitsConcierge
import UIKit

class FirstViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    var fetchedCat = [CatFacts]()
    let tableView = UITableView()
    
   // var logOut = UIButton()
    
    var fetchAndDecode: FetchandDecodeOperation = FetchandDecodeOperation()
    
    @objc private func logOutAction() {
      
        Concierge.disconnect(){ boolean in
           // print("DISCONNCETING")
        }

        self.dismiss(animated: true, completion: nil)
    }
    

    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        let logOut = UIButton(frame: CGRect(x: 150, y: 400, width: 100, height: 50))
        logOut.backgroundColor = .gray
        
        logOut.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
       // logOut.translatesAutoresizingMaskIntoConstraints = false
        logOut.setTitle("Disconnect", for: .normal)
        logOut.setTitleColor(.white, for: .normal)
        logOut.layer.cornerRadius = 3
        logOut.addTarget(self, action: #selector(logOutAction), for: .touchUpInside)
        self.view.addSubview(logOut)
        
         
        tableView .register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
        view.addSubview(logOut)
        tableView.delegate = self
        tableView.dataSource = self
        
        
        
        self.title = "Table View"
        
        self.view.backgroundColor = UIColor.white
    
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        self.tableView .refreshControl = refreshControl
        
       

        fetchAndDecode.fetchCatData { (catFacts) in

            for catFact in catFacts {
                self.fetchedCat.append(catFact)
                self.tableView.reloadData()

            }

        }
   //    parseData()
        
    }
    
    override func viewDidLayoutSubviews() {
        
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        
    }
    
    @objc func refresh(_ sender: Any) {
        
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0){
         //   self.parseData()
                
                self.fetchedCat = []
                
                self.fetchAndDecode.fetchCatData { (catFacts) in

                    for catFact in catFacts {
                        
                        self.fetchedCat.append(catFact)
                        self.tableView.reloadData()

                    }

                }

            self.tableView .refreshControl?.endRefreshing()
        }
    }
    
    
   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
          
        let vc = SecondViewController()
        let navVC = UINavigationController(rootViewController: vc)
        
         navVC.modalPresentationStyle = .fullScreen
         vc.eachFetchedCat = fetchedCat[indexPath.row]
        
        navigationController?.pushViewController(vc, animated: true)
        
        }
    

    override var prefersStatusBarHidden: Bool {
        return false
    }
    
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return fetchedCat.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        
        cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "cell")
                
        cell?.textLabel?.text = "Id: " + fetchedCat[indexPath.row]._id
        cell?.textLabel?.font = UIFont.systemFont(ofSize: 15.0)
        cell?.detailTextLabel?.text = "Fact: " + fetchedCat[indexPath.row].text
        cell?.detailTextLabel?.font = UIFont.systemFont(ofSize: 15.0)
  
        return cell!
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
            super.viewWillAppear(animated)
            tableView .reloadData()
        }
}
    








