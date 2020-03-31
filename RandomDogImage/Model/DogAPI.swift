//
//  DogAPI.swift
//  RandomDogImage
//
//  Created by Hari Prasad on 3/24/20.
//  Copyright © 2020 Hari Prasad. All rights reserved.
//

import Foundation
import UIKit

class DogAPI {
    enum EndPoint {
        case randomImageFromAllDogsCollection
        case randomImageForBreed(String)
        case listAllBreeds
        
        var url: URL {
            return URL(string: self.stringValue)!
        }
        
        var stringValue: String {
            switch self {
            case.randomImageFromAllDogsCollection:
                return "https://dog.ceo/api/breeds/image/random"
            case .randomImageForBreed(let breed):
                return "https://dog.ceo/api/breed/\(breed)/images/random"
            case .listAllBreeds:
                return "https://dog.ceo/api/breeds/list/all"
            default:
                break
            }
        }
    }
    
    class func requestImageFile(url: URL, completionHandler: @escaping (UIImage?, Error?) -> Void) {
        let task = URLSession.shared.dataTask(with: url, completionHandler:  {
        (data, response, error) in
        guard let data = data else {
            completionHandler(nil, error)
            return
        }
        let downloadedImage = UIImage(data: data)
            completionHandler(downloadedImage, nil)
        })
        task.resume()
    }
    
    class func requestRandomImage(url: URL, completionHandler: @escaping (DogImage?, Error?) -> Void) {
        
        let task = URLSession.shared.dataTask(with: url) {
        
        (data, response, error) in
            guard let data = data else {
                completionHandler(nil, error)
                return
            }
            do {
                let decoder = JSONDecoder()
                let imageData = try decoder.decode(DogImage.self, from: data)
                completionHandler(imageData, nil)
            } catch {
                print(error)
            }
        }
        task.resume()
    }
    
    
    class func requestRandomImageForBreed(breed: String, completionHandler: @escaping (DogImage?, Error?) -> Void) {
        let randomImageForBreedEndPoint = DogAPI.EndPoint.randomImageForBreed(breed).url
        let task = URLSession.shared.dataTask(with: randomImageForBreedEndPoint) {
        
        (data, response, error) in
            guard let data = data else {
                completionHandler(nil, error)
                return
            }
            do {
                let decoder = JSONDecoder()
                let imageData = try decoder.decode(DogImage.self, from: data)
                completionHandler(imageData, nil)
            } catch {
                print(error)
            }
        }
        task.resume()
    }
    
    class func requestListAllBreeds(completionHandler: @escaping ([String], Error?) -> Void) {
        let listAllBreedsURL = self.EndPoint.listAllBreeds.url
        let task = URLSession.shared.dataTask(with: listAllBreedsURL) {
            (data, response, error) in
            guard let data = data else {
                    completionHandler([], error)
                    return
                }
                do {
                    let decoder = JSONDecoder()
                    let imageData = try decoder.decode(BreedListResponse.self, from: data)
                    let breeds = imageData.message.keys.map({$0})
                    completionHandler(breeds, nil)
                } catch {
                    print(error)
                }
            }
            task.resume()
    }
}
