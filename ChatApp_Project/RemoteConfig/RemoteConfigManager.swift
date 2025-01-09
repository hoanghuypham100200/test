//
//  RemoteConfigManager.swift
//  ChatApp_Project
//
//  Created by Huy on 31/12/24.
//

import FirebaseRemoteConfig

class RemoteConfigManager {
    private let remoteConfig = RemoteConfig.remoteConfig()

    init() {
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 0 // Minimum fetch interval (1 hour)
        remoteConfig.configSettings = settings

        // Optional: Set default values for keys
        remoteConfig.setDefaults([
            "version_DS": "v1" as NSObject
        ])
    }

    func fetchRemoteConfig(completion: @escaping (Bool) -> Void) {
        remoteConfig.fetchAndActivate { status, error in
            if let error = error {
                print("Error fetching remote config: \(error)")
                completion(false)
                return
            }
            completion(status == .successFetchedFromRemote || status == .successUsingPreFetchedData)
        }
    }

    func getValue(forKey key: String) -> String {
        return remoteConfig.configValue(forKey: key).stringValue
    }
}


class RemoteConfigFileManager {
    private let remoteConfig = RemoteConfig.remoteConfig()

    init() {
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 0 // Minimum fetch interval (1 hour)
        remoteConfig.configSettings = settings

        // Optional: Set default values for keys
        remoteConfig.setDefaults([
            "total_files": 10 as NSObject
        ])
    }

    func fetchRemoteConfig(completion: @escaping (Bool) -> Void) {
        remoteConfig.fetchAndActivate { status, error in
            if let error = error {
                print("Error fetching remote config: \(error)")
                completion(false)
                return
            }
            completion(status == .successFetchedFromRemote || status == .successUsingPreFetchedData)
        }
    }

    func getValue(forKey key: String) -> String {
        return remoteConfig.configValue(forKey: key).stringValue
    }
}
