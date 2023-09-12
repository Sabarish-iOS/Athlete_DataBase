//
//  ViewController.swift
//  Athlete DataBase
//
//  Created by Apple8 on 11/09/23.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, collectionViewCellClicked {

    @IBOutlet weak var baseTableView: UITableView!
    var indicatorView = UIActivityIndicatorView()
    
    var GetGameListData : [GameListData]? = nil
    var GetParticipateListData : [ParticipationListData]? = nil
    var GameIDForAPI : [Int] = [Int]()
    var LoadingInterval = 0
    var CityStaticName = [String]()
    var mainArrayOfDictionary : [[String:Any]] = [[String:Any]]()
    var baseArray : [[String:Any]] = [[String:Any]]()
    var fullyLoaded = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.callGameListAPI()
       
        //Setting the delegate and Datasource for the Main Table View
        self.baseTableView.delegate = self
        self.baseTableView.dataSource = self
        self.baseTableView.showsVerticalScrollIndicator = false
        self.baseTableView.separatorStyle = .none
        self.view.bringSubviewToFront(self.baseTableView)
        
        self.indicatorView = self.activityIndicator(style: .medium,center: self.view.center)
        self.view.addSubview(indicatorView)
            
       
    }
   
    private func activityIndicator(style: UIActivityIndicatorView.Style = .medium,
                                       frame: CGRect? = nil,
                                   center: CGPoint? = nil) -> UIActivityIndicatorView {
        
        let activityIndicatorView = UIActivityIndicatorView(style: style)
        if let frame = frame {
            activityIndicatorView.frame = frame
        }
        if let center = center {
            activityIndicatorView.center = center
        }
        return activityIndicatorView
    }
    //API call:
    func callGameListAPI(){
        self.indicatorView.startAnimating()
        GamesViewModel().getGameList(url: "https://ocs-test-backend.onrender.com/games") { result in
            switch result{
            case .success(let data):
                self.GetGameListData = data
                for i in 0...self.GetGameListData!.count - 1 {
                    let dictionary: [String: Any] = [
                        "\(self.GetGameListData![i].city ?? "")": [[String:Any]].self
                    ]
                    self.CityStaticName.append("\(self.GetGameListData![i].city ?? "")")
                    usingCityStaticName = self.CityStaticName
                    self.mainArrayOfDictionary.append(dictionary)
                }
                DispatchQueue.main.async {
                    self.indicatorView.stopAnimating()
                    self.getTheListForOneGame()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    //Call one by one api
    func getTheListForOneGame(){
        for i in 0...((self.GetGameListData?.count ?? 0) - 1){
            self.GameIDForAPI.append(self.GetGameListData?[i].game_id ?? 0)
        }
        print(GameIDForAPI)
        self.callParticipationList(ID: self.GameIDForAPI[self.LoadingInterval])
    }
    
    func callParticipationList(ID: Int){
        self.indicatorView.startAnimating()
        ParticipationViewModel().getParticipationList(url: "https://ocs-test-backend.onrender.com/games/\(ID)/athletes") { result in
            switch result{
            case .success(let data):
                self.GetParticipateListData = data
                newData = self.GetParticipateListData!
                if newData!.count > 0{
                    self.baseArray = [[String:Any]]()
                    for i in 0...newData!.count - 1{
                        let dictionary: [String: Any] = [
                            "adId": newData![i].athlete_id ?? "",
                            "name": newData![i].name ?? ""
                        ]
                        self.baseArray.append(dictionary)
                    }
                    self.mainArrayOfDictionary[ID - 1]["\(self.CityStaticName[ID - 1])"] = self.baseArray
                }else{
                    self.baseArray = [[String:Any]]()
                    self.mainArrayOfDictionary[ID - 1]["\(self.CityStaticName[ID - 1])"] = self.baseArray
                }
                print(self.mainArrayOfDictionary)
                usingmainArrayOfDictionary = self.mainArrayOfDictionary
                DispatchQueue.main.async {
                    self.LoadingInterval = self.LoadingInterval+1
                    if self.LoadingInterval < self.GameIDForAPI.count{
                        self.callParticipationList(ID: self.GameIDForAPI[self.LoadingInterval])
                    }else{
                        self.indicatorView.stopAnimating()
                        self.baseTableView.reloadData()
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    //Artibution for the Table view:
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.GetGameListData?.count ?? 0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row % 2 == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "GamesListTitleTableViewCell", for: indexPath) as! GamesListTitleTableViewCell
            cell.selectionStyle = .none
            
            
            cell.GameTitleLabel.text = "\(self.GetGameListData?[indexPath.section].city ?? "") \(self.GetGameListData?[indexPath.section].year ?? 0)"
            
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "AthleteThumbnailTableViewCell", for: indexPath) as! AthleteThumbnailTableViewCell
            cell.selectionStyle = .none
            cell.delegate = self
            
            let nsDictionary = NSDictionary(objects: usingmainArrayOfDictionary.flatMap { $0.values }, forKeys: usingmainArrayOfDictionary.flatMap { $0.keys } as [NSCopying])
            let valued = nsDictionary.value(forKey: "\(CityStaticName[indexPath.section])") as! NSArray
            
            cell.valued = valued
            if valued.count == 0 {
                cell.noDataFoundLabel.isHidden = false
                cell.AthleteFrontCollectionView.isHidden = true
            }else{
                cell.noDataFoundLabel.isHidden = true
                cell.AthleteFrontCollectionView.isHidden = false
            }
            cell.AthleteFrontCollectionView.reloadData()
            
            return cell
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row % 2 == 0{
            return UITableView.automaticDimension
        }else{
            return 140
        }
    }
    func cellClicked(myIndex: Int) {
        let push = storyboard?.instantiateViewController(withIdentifier: "AthleteDetailsViewController") as! AthleteDetailsViewController
        push.AthleteID = myIndex
        self.navigationController?.pushViewController(push, animated: true)
        
    }
    
}

