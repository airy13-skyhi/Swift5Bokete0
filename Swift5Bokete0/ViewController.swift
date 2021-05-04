//
//  ViewController.swift
//  Swift5Bokete0
//
//  Created by Manabu Kuramochi on 2021/05/04.
//

import UIKit
import Alamofire
import SwiftyJSON
import SDWebImage
import Photos



class ViewController: UIViewController {
    
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var odaiImageView: UIImageView!
    @IBOutlet weak var commentTextView: UITextView!
    
    var count = 0
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        commentTextView.layer.cornerRadius = 20.0
        
        PHPhotoLibrary.requestAuthorization { (status) in
            
            switch(status) {
            
            case .authorized:
                break
            case .notDetermined:
                break
            case .restricted:
                break
            case .denied:
                break
            case .limited:
                break
            @unknown default:
                break
            }
            
        }
        getImages(keyword: "funny")
        
    }
    
    //Your API key: 21455919-94e1aab5f50ee6471d2e442fb
    
    func getImages(keyword:String) {
        
        let url = "https://pixabay.com/api/?key=21455919-94e1aab5f50ee6471d2e442fb&q=\(keyword)"
        
        //Alamofireを使ってhttpリクエストを投げる
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default).responseJSON { (response) in
            
            switch response.result {
            
            
            case .success:
                let json:JSON = JSON(response.data as Any)
                let iamgeString = json["hits"][self.count]["webformatURL"].string
                self.odaiImageView.sd_setImage(with: URL(string: iamgeString!), completed: nil)
                
            case .failure(let error):
                print(error)
            }
            
        }
        
        //帰ってきた値のJSON解析を実行
        //imageView.imageに貼り付け
        
    }
    
    
    @IBAction func nextOdai(_ sender: Any) {
        
        count += 1
        
        if searchTextField.text == "" {
            
            getImages(keyword: "funny")
            
        }else {
            
            getImages(keyword: searchTextField.text!)
        }
        
    }
    
    
    
    @IBAction func searchAction(_ sender: Any) {
        
        self.count = 0
        
        if searchTextField.text == "" {
            
            getImages(keyword: "funny")
            
        }else {
            
            getImages(keyword: searchTextField.text!)
        }
        
        
    }
    
    
    @IBAction func done(_ sender: Any) {
        
        
        performSegue(withIdentifier: "done", sender: nil)
    }
    
    
}

