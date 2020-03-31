//
//  ViewController.swift
//  RandomDogImage
//
//  Created by Hari Prasad on 3/24/20.
//  Copyright © 2020 Hari Prasad. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
  
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var pickerView: UIPickerView!
    
     var breeds: [String] = []
     let randomImageEndPoint = DogAPI.EndPoint.randomImageFromAllDogsCollection.url
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerView.dataSource = self
        pickerView.delegate = self
        
        DogAPI.requestListAllBreeds(completionHandler: handleListAllBreedsRespinse(breeds:error:))
        
        // Do any additional setup after loading the view.
        print(DogAPI.EndPoint.randomImageFromAllDogsCollection.url)
        
       
        
//        let task = URLSession.shared.dataTask(with: randomImageEndPoint) {
//
//            (data, response, error) in
//                guard let data = data else {
//                    return
//                }
//                 print(data)
            //To use general mechanism
//            do {
//                let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
//                           let url = json["message"] as! String
//                           print(url)
//            } catch {
//                print(error)
//            }
            
//            do {
//                let decoder = JSONDecoder()
//                let imageData = try decoder.decode(DogImage.self, from: data)
//                print(imageData)
//
//                print(imageData.message)
//
//                guard let imageURL = URL(string: imageData.message) else {
//                    return
//                }
                
//                DogAPI.requestImageFile(url: imageURL, completionHandler: {(image, error) in
//                   DispatchQueue.main.async {
//                                          self.imageView.image = image
//                                      }
//                })
                
                //DogAPI.requestImageFile(url: imageURL, completionHandler: self.handleImageFileResponse(image:error:))
//                let imageTask = URLSession.shared.dataTask(with: imageURL, completionHandler:  {
//                    (data, response, error) in
//                    guard let data = data else {
//                        return
//                    }
//                    let downloadedImage = UIImage(data: data)
//                    DispatchQueue.main.async {
//                        self.imageView.image = downloadedImage
//                    }
//                })
//                imageTask.resume()
                
//            } catch {
//                print(error)
//            }
//
//
//        }
//        task.resume()
        
       
           
        
            
    }
    
    func handleImageFileResponse(image: UIImage?, error: Error?) {
        DispatchQueue.main.async {
                               self.imageView.image = image
                           }
    }
    
    func handleRandomImageResponse(imageData: DogImage?, error: Error?) {
        guard let imageData = imageData else {
            return
        }
        
        guard let imageURL = URL(string: imageData.message) else {
            return
        }
        DogAPI.requestImageFile(url: imageURL, completionHandler: self.handleImageFileResponse(image:error:))
    }
    
    func handleListAllBreedsRespinse(breeds: [String], error: Error?) {
        self.breeds = breeds
        DispatchQueue.main.async {
            self.pickerView.reloadAllComponents()
        }
    }


}

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return breeds.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return breeds[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
         //DogAPI.requestRandomImage(url: randomImageEndPoint, completionHandler: self.handleRandomImageResponse(imageData:error:))
        
        DogAPI.requestRandomImageForBreed(breed: breeds[row], completionHandler: self.handleRandomImageResponse(imageData:error:))
    }
    
}

