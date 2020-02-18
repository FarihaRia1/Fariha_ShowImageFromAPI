//
//  ViewController.swift
//  FarihaShowingImageAPI
//
//  Created by apple on 2/17/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit
import AlamofireImage

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    
    var data = [ApiModel]()
    
    var name = [String]()
    var imgName = [String]()
    
 

    @IBOutlet weak var mytableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        Dataloadingg()
        mytableview.rowHeight = 358
        // Do any additional setup after loading the view.
    }
    
    func Dataloadingg() {
        let url = URL(string: "https://jsonplaceholder.typicode.com/photos")
        URLSession.shared.dataTask(with: url!){(data, response, error) in
            if error == nil {
                do{
                    let myData = try!JSONDecoder().decode([ApiModel].self, from: data!)
                    DispatchQueue.main.async {
                        for item in myData{
                            self.name.append(item.title)
                            self.imgName.append(item.url)
                            //print(self.imageName)
                        }
                        self.mytableview.reloadData()
                    }
                }catch{
                    print(":( Nothing Found")
                }
            }
        }.resume()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imgName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! MyTableViewCell
        
        if let imgUrl = imgName[indexPath.row] as? String {
            if let url = URL(string: imgUrl){
                cell.myimage.af_setImage(withURL: url)
            }
        }

        
        return cell
    }
    


    
}

