//
//  getData.swift
//  navigateBar
//
//  Created by Huy on 10/12/24.
//

import Foundation


func loadApp(from fileName: String) -> [OurApp]? {
    guard let fileURL = Bundle.main.url(forResource: fileName, withExtension: "json") else {
        print("File \(fileName).json not found in bundle.")
        return nil
    }
    
    do {
        let data = try Data(contentsOf: fileURL)
        let items = try JSONDecoder().decode([OurApp].self, from: data)
        return items
    } catch {
        print("Error reading or decoding JSON: \(error)")
        return nil
    }
}



func loadAboutApp(from fileName: String) -> [AboutApp]? {
    guard let fileURL = Bundle.main.url(forResource: fileName, withExtension: "json") else {
        print("File \(fileName).json not found in bundle.")
        return nil
    }
    
    do {
        let data = try Data(contentsOf: fileURL)
        let items = try JSONDecoder().decode([AboutApp].self, from: data)
        return items
    } catch {
        print("Error reading or decoding JSON: \(error)")
        return nil
    }
}



