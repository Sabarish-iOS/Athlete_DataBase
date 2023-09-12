//
//  AthleteDetailsViewController.swift
//  Athlete DataBase
//
//  Created by Apple8 on 11/09/23.
//

import UIKit

class AthleteDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var DetailsTableView: UITableView!
    var indicatorView = UIActivityIndicatorView()
    
    var GetAthleteDetailsData : AthleteDetailsData? = nil
    var GetPrizeDeatilsData : [PrizeDeatilsData]? = nil
    
    var AthleteID = 2
    
    @IBOutlet weak var backButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.callAthleteDetails()
        self.callprizeDetails()
        
        self.DetailsTableView.dataSource = self
        self.DetailsTableView.delegate = self
        self.DetailsTableView.separatorStyle = .none
        
        self.backButton.addTarget(self, action: #selector(backButtonTapped(sender: )), for: .touchUpInside)
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
    @objc func backButtonTapped(sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
    func callAthleteDetails(){
        self.indicatorView.startAnimating()
        AthleteDetailsViewModel().getAthleteDeatils(url: "https://ocs-test-backend.onrender.com/athletes/\(self.AthleteID)") { result in
            switch result{
            case .success(let data):
                self.GetAthleteDetailsData = data
                
                DispatchQueue.main.async {
                    self.indicatorView.stopAnimating()
                    self.DetailsTableView.reloadData()
                    self.titleLabel.text = "\(self.GetAthleteDetailsData?.name ?? "") Details"
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func callprizeDetails(){
        self.indicatorView.startAnimating()
        PrizeDetailsViewModel().getprizeDeatils(url: "https://ocs-test-backend.onrender.com/athletes/\(self.AthleteID)/results") { result in
            switch result{
            case .success(let data):
                self.GetPrizeDeatilsData = data
                
                DispatchQueue.main.async {
                    self.indicatorView.stopAnimating()
                    self.DetailsTableView.reloadData()
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1{
            return self.GetPrizeDeatilsData?.count ?? 0
        }
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "AthleteProfileTableViewCell", for: indexPath) as! AthleteProfileTableViewCell
            cell.selectionStyle = .none
            
            cell.nameLbl.text = self.GetAthleteDetailsData?.surname ?? ""
            cell.dobLbl.text = self.GetAthleteDetailsData?.dateOfBirth ?? ""
            cell.weightLbl.text = "\(self.GetAthleteDetailsData?.weight ?? 0)Kg"
            cell.heightLbl.text = "\(self.GetAthleteDetailsData?.height ?? 0)cms"
            
            let BaseUrl = URL(string: "https://ocs-test-backend.onrender.com/athletes/\(self.AthleteID)/photo")
            let imageData = NSData(contentsOf: BaseUrl!)
            cell.profileImage.image = UIImage(data: imageData! as Data)
            
            return cell
        }else if indexPath.section == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: "PrizeTableViewCell", for: indexPath) as! PrizeTableViewCell
            cell.selectionStyle = .none
            
            cell.prizeNameLbl.text = "• \(self.GetPrizeDeatilsData![indexPath.row].city ?? "")"
            cell.goldLbl.text = "\(self.GetPrizeDeatilsData![indexPath.row].gold ?? 0)"
            cell.bronzeLbl.text = "\(self.GetPrizeDeatilsData![indexPath.row].bronze ?? 0)"
            cell.silverLbl.text = "\(self.GetPrizeDeatilsData![indexPath.row].silver ?? 0)"
            if self.GetPrizeDeatilsData![indexPath.row].gold == 0{
                cell.goldView.isHidden = true
            }
            if self.GetPrizeDeatilsData![indexPath.row].bronze == 0{
                cell.bronzeView.isHidden = true
            }
            if self.GetPrizeDeatilsData![indexPath.row].silver == 0{
                cell.silverView.isHidden = true
            }
            
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "BioTableViewCell", for: indexPath) as! BioTableViewCell
            cell.selectionStyle = .none
            
            cell.bioLabel.text = self.GetAthleteDetailsData?.bio ?? ""
           
            
            return cell
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: self.DetailsTableView.frame.size.width, height: 40))
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: headerView.frame.size.width, height: 40))
        if section == 1{
            titleLabel.text = "    Medals"
        }else{
            titleLabel.text = "    Bio"
        }
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20.0)
        headerView.addSubview(titleLabel)
        return headerView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1 || section == 2{
            return 40
        }else{
            return 0
        }
    }

}

