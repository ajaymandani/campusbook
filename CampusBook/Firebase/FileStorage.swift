//
//  FileStorage.swift
//  CampusBook
//
//  Created by Ajay Mandani on 2023-01-19.
//
import UIKit
import Foundation
import FirebaseStorage
import ProgressHUD
let storage = Storage.storage()

class FileStorage{
    
   class func saveUserImage(image:UIImage,location:String,completion:@escaping(_ docString:String?)->Void){
        print(location)
      
        let storageRef = storage.reference(forURL: kpathref).child(location)
        
        let imagedata = image.jpegData(compressionQuality: 0.7)
        var task:StorageUploadTask!
        task = storageRef.putData(imagedata!, metadata: nil,completion: { docUrl, error in
            task.removeAllObservers()
            ProgressHUD.dismiss()

            if error != nil{
                completion(nil)
                print(error!.localizedDescription)
                return
            }

            storageRef.downloadURL { url,error  in
                completion(url!.absoluteString)
            }

        })
        
        task.observe(StorageTaskStatus.progress) { snap in
            let progress = snap.progress!.completedUnitCount/snap.progress!.totalUnitCount


                ProgressHUD.showProgress(CGFloat(progress))

        }
        
    }
    
    class func saveFileLocally(filedata:NSData,filename:String){
        let docurl = getDocument().appendingPathComponent(filename, conformingTo: .image)
        filedata.write(to: docurl, atomically: true)
    }
    
    class func downloadImageUrl(imageurl:String,completion:@escaping(_ img:UIImage?)->Void){
            

        let newName = (imageurl.components(separatedBy: "_").last?.components(separatedBy: "?").first?.components(separatedBy: ".").first)!
        print(newName)
        if fileexist(path: newName)
        {
            if let contentoffile = UIImage(contentsOfFile: fileInDocDirectory(fileName: newName))
            {
                completion(contentoffile)
            }else{
                completion(UIImage(named: "avatar"))
            }
        }else{
            
            if imageurl != "" {
                let docurl = URL(string: imageurl)
                let urlsess = URLSession.shared
                let datatask  = urlsess.dataTask(with: docurl!) { data, res, err in
                    if err == nil{
                        completion(UIImage(data: data!))

                    }else{
                        completion(UIImage(named: "avatar"))

                    }
                }
                datatask.resume()
            }
            
        }
        
    }

    
}


func fileInDocDirectory(fileName:String)->String{
   return getDocument().appendingPathComponent(fileName, conformingTo: .image).path
}

func getDocument()->URL{
    return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    
}

func fileexist(path:String)->Bool{
    return FileManager.default.fileExists(atPath: fileInDocDirectory(fileName: path))
}
