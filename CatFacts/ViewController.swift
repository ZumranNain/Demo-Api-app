//
//  ViewController.swift
//  CatFacts
//
//  Created by Zumran Nain on 2022-01-19.
//

import UIKit


//remmebr to add data cource and delegate for collection view
class ViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout{
   
    
     var fetchedCat = [CatFacts]()
     var fetchAndDecode: FetchandDecodeOperation = FetchandDecodeOperation()
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        let layout = UICollectionViewFlowLayout()

        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 1

        layout.sectionFootersPinToVisibleBounds = true
        layout.sectionHeadersPinToVisibleBounds = true
        
        self.collectionView.collectionViewLayout = layout
        self.collectionView.frame = .zero
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.register(CatFactCell.self, forCellWithReuseIdentifier: CatFactCell.identifier)
        self.title = "Collection View"
        
    
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        self.collectionView!.refreshControl = refreshControl
        
        fetchAndDecode.fetchCatData { (catFacts) in
            for catFact in catFacts {
                self.fetchedCat.append(catFact)
                self.collectionView!.reloadData()
            }
        }
        
   //    parseData()
    }
    
 
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fetchedCat.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CatFactCell.identifier, for: indexPath) as! CatFactCell
        
        cell.idLabel.text = "Id: " + fetchedCat[indexPath.row]._id
        cell.idLabel.font = UIFont.systemFont(ofSize: 20)
    
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.width - 1)/2 , height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    // prevents cells from changing size
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        guard let flowLayout = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout else {
            return
        }
        flowLayout.invalidateLayout()
    }

    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
                      
            let vc = SecondViewController()
    
            let navVC = UINavigationController(rootViewController: vc)
        
      //      var cell = self.collectionView(collectionView, cellForItemAt: indexPath) as! CatFactCell
      //      cell.idLabel.backgroundColor = .green
    
            navVC.modalPresentationStyle = .fullScreen
            vc.eachFetchedCat = fetchedCat[indexPath.row]
        
            navigationController?.pushViewController(vc, animated: true)
        
    }
    
    override func viewDidLayoutSubviews() {
        
        super.viewDidLayoutSubviews()
        collectionView!.frame = view.bounds
        
    }
    
    @objc func refresh(_ sender: Any) {
        
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0){
         //   self.parseData()
                
                self.fetchedCat = []
                
                self.fetchAndDecode.fetchCatData { (catFacts) in

                    for catFact in catFacts {
                        
                        self.fetchedCat.append(catFact)
                        self.collectionView.reloadData()

                    }

                }

            self.collectionView .refreshControl?.endRefreshing()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
            super.viewWillAppear(animated)
            collectionView.reloadData()
        }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
    }
    
    
}


struct CatFacts: Decodable{
    
    let _id : String
    let text: String
    let user: String
    let source: String
    let updatedAt: String
    let createdAt: String
    let deleted: Bool
    let used: Bool
    let __v: Int
    let type: String
    let status: StatusLabel
    

    init(_id: String, text: String, user: String, source: String, updatedAt: String,  createdAt: String, deleted: Bool, used: Bool, __v: Int, type:String, status:StatusLabel){
      
        self._id = _id
        self.text = text
        self.user = user
        self.source = source
        self.updatedAt = updatedAt
        self.createdAt = createdAt
        self.deleted = deleted
        self.used = used
        self.__v = __v
        self.type = type
        self.status = status
        
    }
}



class StatusLabel: Decodable {
    
    var verified: Bool
    var  sentCount: Int
    
    init(verified: Bool, sentCount: Int) {
        
        self.verified = verified
        self.sentCount = sentCount
    }
}

class FetchandDecodeOperation: Operation {
    
    func fetchCatData(completionHandler: @escaping ([CatFacts]) -> Void ){
        
        let url = "https://cat-fact.herokuapp.com/facts/"
        var request = URLRequest(url: URL(string: url)!)
        
        request.httpMethod = "GET"
        
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            
            if error != nil {
                print("Error")
            }
            
            else {
                
              let catFactDecoder = JSONDecoder()
                
                do {
                    
                    let fetchedData = try catFactDecoder.decode([CatFacts].self,from: data!)
                    completionHandler(fetchedData)
                    
                }
                catch let error {
                    print(error)
                  
                }
            }
        }
        task.resume()
    }
}
    

extension UIView {
    func pinEdges(to other: UIView) {
        leadingAnchor.constraint(equalTo: other.leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: other.trailingAnchor).isActive = true
        topAnchor.constraint(equalTo: other.topAnchor).isActive = true
        bottomAnchor.constraint(equalTo: other.bottomAnchor).isActive = true
    }
}




