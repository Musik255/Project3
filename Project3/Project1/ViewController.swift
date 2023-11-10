//
//  ViewController.swift
//  Project1
//
//  Created by Павел Чвыров on 07.11.2023.
//

import UIKit

class ViewController: UITableViewController {
    
    var pictures = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(shareProgram))
        
        title = "Storm Viewer"
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)

        for item in items {
            if item.hasPrefix("nssl") {
                pictures.append(item)
            }
        }
        pictures.sort(by: <)
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
    }
    
   
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        cell.textLabel?.text = pictures[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let vcPicture = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController{
            
            vcPicture.selectedImage = pictures[indexPath.row]
            vcPicture.indexNumber = indexPath.row + 1
            vcPicture.filesAmount = pictures.count
            navigationController?.pushViewController(vcPicture, animated: true)
            
        }
    }
    @objc func shareProgram(){
        let vc = UIActivityViewController(activityItems: ["Download This app [nameApp]"], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
    

}

