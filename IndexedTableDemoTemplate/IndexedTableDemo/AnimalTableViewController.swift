//
//  AnimalTableViewController.swift
//  IndexedTableDemo
//
//  Created by Simon Ng on 17/11/14.
//  Copyright (c) 2014 AppCoda. All rights reserved.
//

import UIKit

class AnimalTableViewController: UITableViewController {
    
    var animalsDict = [String: [String]]()
    var animalSectionTitles = [String]()
    
    let animals = ["Bear", "Black Swan", "Buffalo", "Camel", "Cockatoo", "Dog", "Donkey", "Emu", "Giraffe", "Greater Rhea", "Hippopotamus", "Horse", "Koala", "Lion", "Llama", "Manatus", "Meerkat", "Panda", "Peacock", "Pig", "Platypus", "Polar Bear", "Rhinoceros", "Seagull", "Tasmania Devil", "Whale", "Whale Shark", "Wombat"]
    
    let animalIndexTitles = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // generate the animal dictionary
        
        createAnimalDict()

    }


    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        return animalSectionTitles.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        
        let animalKey = animalSectionTitles[section]
        if let animalValues = animalsDict[animalKey] {
            return animalValues.count
        }
        
        return 0
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) 

        // Configure the cell...
        
        let animalKey = animalSectionTitles[indexPath.section]
        if let animalValues = animalsDict[animalKey] {
            cell.textLabel?.text = animalValues[indexPath.row]
        
        // Convert the animal name to lower case and 
        // then replace all occurences of a space with an underscore
        let imageFilename = animalValues[indexPath.row].lowercaseString.stringByReplacingOccurrencesOfString(" ", withString: "_", options: [], range: nil)
        cell.imageView?.image = UIImage(named: imageFilename)
    }

        return cell
    }
    
    func createAnimalDict() {
        for animal in animals {
            // get the first letter of the animal name and build the dictionary
            
            let animalKey = animal.substringToIndex(animal.startIndex.advancedBy(1))
            if var animalValues = animalsDict[animalKey] {
                animalValues.append(animal)
                animalsDict[animalKey] = animalValues
            } else {
                animalsDict[animalKey] = [animal]
            }
        }
        
        // get the section titles from the dictionary's keys and sort them in ascending order
        
        animalSectionTitles = [String](animalsDict.keys)
        animalSectionTitles = animalSectionTitles.sort({ $0 < $1 })
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return animalSectionTitles[section]
    }
    
    override func sectionIndexTitlesForTableView(tableView: UITableView) -> [String]? {
        
        return animalIndexTitles
    }
    
    override func tableView(tableView: UITableView, sectionForSectionIndexTitle title: String, atIndex index: Int) -> Int {
        guard let index = animalSectionTitles.indexOf(title) else {
            
            return -1
        }
        
        return index
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 50
    }
    
    override func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let headerView = view as! UITableViewHeaderFooterView
        headerView.textLabel?.textColor = UIColor.orangeColor()
        headerView.textLabel?.font = UIFont(name: "Avenir", size: 25.0)
    }
}
