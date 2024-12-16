//
//  getData.swift
//  AdventureDoToList
//
//  Created by Huy on 12/12/24.
//

import Foundation


func loadItems(from fileName: String) -> [Item]? {
    guard let fileURL = Bundle.main.url(forResource: fileName, withExtension: "json") else {
        print("File \(fileName).json not found in bundle.")
        return nil
    }
    
    do {
        let data = try Data(contentsOf: fileURL)
        let items = try JSONDecoder().decode([Item].self, from: data)
        return items
    } catch {
        print("Error reading or decoding JSON: \(error)")
        return nil
    }
}
