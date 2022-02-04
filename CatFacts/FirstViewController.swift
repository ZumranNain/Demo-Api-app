//
//  ViewController.swift
//  CatFacts
//
//  Created by Zumran Nain on 2022-01-19.
//

import UIKit

class FirstViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    var fetchedCat = [CatFacts]()
    let tableView = UITableView()
    
    var fetchAndDecode: FetchandDecodeOperation = FetchandDecodeOperation()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView .register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
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
    








