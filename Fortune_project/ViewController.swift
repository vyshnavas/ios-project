//
//  ViewController.swift
//  Fortune_project
//
//  Created by Apple on 3/10/23.
//

import UIKit

class ViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {
    
    @IBOutlet weak var myTable: UICollectionView!
    var getdata = NSMutableData()
        var jsondata = NSArray()
        var dict = NSDictionary()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return jsondata.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let newcell = collectionView.dequeueReusableCell(withReuseIdentifier: "second", for: indexPath)as! New_CollectionViewCell
        
        self.dict = jsondata[indexPath.row]as! NSDictionary
        newcell.nameobj.text = String(describing: self.dict["title"]!)
        
        let imgurl = String(describing: self.dict["image"]!)
        let urlimg = URL(string: imgurl)
        let dataimg = try? Data(contentsOf: urlimg!)
        newcell.imgobj.image = UIImage(data: dataimg!)
        
        
        return newcell
        
    }
    
    

  
        override func viewDidLoad() {
            super.viewDidLoad()
           let url_str = URL(string: "https://test.dev-fsit.com/api/image-list")
           let url_req = URLRequest(url: url_str!)
            let task = URLSession.shared.dataTask(with: url_req) {(data,request,error) in
                if let mydata = data
                {
                   print("mydata-->>",mydata)
                    do
                    {
                        self.getdata.append(mydata)
                        self.jsondata = try JSONSerialization.jsonObject(with: self.getdata as Data, options: [])as! NSArray
                        
                        print("jsondata-->",self.jsondata)
                        do
                        {
                            DispatchQueue.main.async {
                                self.myTable.reloadData()
                            }
                        }
                    }
                    catch
                    {
                        print("error--->>",error.localizedDescription)
                    }
                }
            }
            task.resume()
        }


    }

