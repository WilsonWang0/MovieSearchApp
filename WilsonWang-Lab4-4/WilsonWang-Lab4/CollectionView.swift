//
//  CollectionView.swift
//  WilsonWang-Lab4
//
//  Created by Wilson Wang on 10/30/23.
//

import UIKit

class CollectionView: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var actionR:[Movie] = []
    var comedyR:[Movie] = []
    var romanceR:[Movie] = []
    var mysteryR:[Movie] = []
    
    var actionI:[Int:UIImage] = [:]
    var comedyI:[Int:UIImage] = [:]
    var romanceI:[Int:UIImage] = [:]
    var mysteryI:[Int:UIImage] = [:]

    @IBOutlet weak var actionView: UICollectionView!
    
    @IBOutlet weak var comedyView: UICollectionView!
    
    @IBOutlet weak var mysteryView: UICollectionView!
    @IBOutlet weak var romanceView: UICollectionView!
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    var theImageCache:[Int:UIImage] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setCollectionView()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func setCollectionView(){
        fetchSearchResults()
        
        actionView.dataSource = self
        comedyView.dataSource = self
        mysteryView.dataSource = self
        romanceView.dataSource = self
        
        actionView.delegate = self
        comedyView.delegate = self
        mysteryView.delegate = self
        romanceView.delegate = self
        
//        collectionView.allowsSelection = true
        if let flow = actionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flow.itemSize = CGSize(width: 80, height: 120)
            flow.minimumInteritemSpacing = 80
        }
        if let flow = comedyView.collectionViewLayout as? UICollectionViewFlowLayout {
            flow.itemSize = CGSize(width: 80, height: 120)
            flow.minimumInteritemSpacing = 80
        }
        if let flow = romanceView.collectionViewLayout as? UICollectionViewFlowLayout {
            flow.itemSize = CGSize(width: 80, height: 120)
            flow.minimumInteritemSpacing = 80
        }
        if let flow = mysteryView.collectionViewLayout as? UICollectionViewFlowLayout {
            flow.itemSize = CGSize(width: 80, height: 120)
            flow.minimumInteritemSpacing = 80
        }
        actionView.register(Collections.self, forCellWithReuseIdentifier: "actionCell")
        comedyView.register(Collections.self, forCellWithReuseIdentifier: "comedyCell")
        romanceView.register(Collections.self, forCellWithReuseIdentifier: "romanceCell")
        mysteryView.register(Collections.self, forCellWithReuseIdentifier: "mysteryCell")
        
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return actionR.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView.tag {
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "actionCell", for: indexPath) as! Collections
            
            cell.backgroundColor = UIColor.gray
            
            cell.movieTitle.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5)
            cell.movieTitle.font = cell.movieTitle.font.withSize(14)
            cell.movieTitle.textAlignment = .center
            cell.movieTitle.textColor = UIColor.white
            cell.movieTitle.numberOfLines = 2
            cell.movieTitle.text = actionR[indexPath.row].title
            
            cell.moviePoster.image = actionI[actionR[indexPath.row].id]
            cell.addSubview(cell.moviePoster)
            cell.addSubview(cell.movieTitle)
            return cell as UICollectionViewCell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "comedyCell", for: indexPath) as! Collections
            
            cell.backgroundColor = UIColor.gray
            
            cell.movieTitle.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5)
            cell.movieTitle.font = cell.movieTitle.font.withSize(14)
            cell.movieTitle.textAlignment = .center
            cell.movieTitle.textColor = UIColor.white
            cell.movieTitle.numberOfLines = 2
            cell.movieTitle.text = comedyR[indexPath.row].title
            
            cell.moviePoster.image = comedyI[comedyR[indexPath.row].id]
            cell.addSubview(cell.moviePoster)
            cell.addSubview(cell.movieTitle)
            return cell as UICollectionViewCell
        case 3:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mysteryCell", for: indexPath) as! Collections
            
            cell.backgroundColor = UIColor.gray
            
            cell.movieTitle.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5)
            cell.movieTitle.font = cell.movieTitle.font.withSize(14)
            cell.movieTitle.textAlignment = .center
            cell.movieTitle.textColor = UIColor.white
            cell.movieTitle.numberOfLines = 2
            cell.movieTitle.text = mysteryR[indexPath.row].title
            
            cell.moviePoster.image = mysteryI[mysteryR[indexPath.row].id]
            cell.addSubview(cell.moviePoster)
            cell.addSubview(cell.movieTitle)
            return cell as UICollectionViewCell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "romanceCell", for: indexPath) as! Collections
            
            cell.backgroundColor = UIColor.gray
            
            cell.movieTitle.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5)
            cell.movieTitle.font = cell.movieTitle.font.withSize(14)
            cell.movieTitle.textAlignment = .center
            cell.movieTitle.textColor = UIColor.white
            cell.movieTitle.numberOfLines = 2
            cell.movieTitle.text = romanceR[indexPath.row].title
            
            cell.moviePoster.image = romanceI[romanceR[indexPath.row].id]
            cell.addSubview(cell.moviePoster)
            cell.addSubview(cell.movieTitle)
            return cell as UICollectionViewCell
        }
    }
    
    func fetchSearchResults() {
        spinner.startAnimating()
        DispatchQueue.global().async {
            let urlaction = URL(string: "https://api.themoviedb.org/3/discover/movie?api_key=f37970f052856742371d3453baf5bf09&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_genres=28")
            let urlromance = URL(string: "https://api.themoviedb.org/3/discover/movie?api_key=f37970f052856742371d3453baf5bf09&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_genres=10749")
            let urlcomedy = URL(string: "https://api.themoviedb.org/3/discover/movie?api_key=f37970f052856742371d3453baf5bf09&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_genres=35")
            let urlmystery = URL(string: "https://api.themoviedb.org/3/discover/movie?api_key=f37970f052856742371d3453baf5bf09&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_genres=9648")
            
            let dataa = try! Data(contentsOf: urlaction!)
            let datar = try! Data(contentsOf: urlromance!)
            let datac = try! Data(contentsOf: urlcomedy!)
            let datam = try! Data(contentsOf: urlmystery!)
            
            self.actionR = try! JSONDecoder().decode(APIResults.self, from: dataa).results
            self.romanceR = try! JSONDecoder().decode(APIResults.self, from: datar).results
            self.comedyR = try! JSONDecoder().decode(APIResults.self, from: datac).results
            self.mysteryR = try! JSONDecoder().decode(APIResults.self, from: datam).results
            
            print(self.actionR, self.romanceR, self.comedyR, self.mysteryR)
            
            self.cacheImages()
            
            DispatchQueue.main.async {
                self.actionView.reloadData()
                self.romanceView.reloadData()
                self.comedyView.reloadData()
                self.mysteryView.reloadData()
                
                self.spinner.stopAnimating()
            }
        }
        
        
    }
    
    func cacheImages() {
        for item in actionR {
            let id = item.id
            let url = URL(string: "https://image.tmdb.org/t/p/w500" + item.poster_path!)
            let data = try? Data(contentsOf: url!)
            let image = UIImage(data:data!)
            actionI[id!] = image!
        }
        for item in romanceR {
            let id = item.id
            let url = URL(string: "https://image.tmdb.org/t/p/w500" + item.poster_path!)
            let data = try? Data(contentsOf: url!)
            let image = UIImage(data:data!)
            romanceI[id!] = image!
        }
        for item in comedyR {
            let id = item.id
            let url = URL(string: "https://image.tmdb.org/t/p/w500" + item.poster_path!)
            let data = try? Data(contentsOf: url!)
            let image = UIImage(data:data!)
            comedyI[id!] = image!
        }
        for item in mysteryR {
            let id = item.id
            let url = URL(string: "https://image.tmdb.org/t/p/w500" + item.poster_path!)
            let data = try? Data(contentsOf: url!)
            let image = UIImage(data:data!)
            mysteryI[id!] = image!
        }
    }
    
}
