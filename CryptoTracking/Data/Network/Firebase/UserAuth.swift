//
//  UserAuth.swift
//  CryptoTracking
//
//  Created by DuyThai on 13/11/2023.
//

import Foundation
import FirebaseCore
import FirebaseAuth
struct UserAuth: Codable {
    var uid: String
    var displayName: String?
    var email: String?
    var photoURL: URL?
    var phoneNumber: String?
    var refreshToken: String?
    // Add other properties you need

    init(authDataResult: AuthDataResult) {
        uid = authDataResult.user.uid
        displayName = authDataResult.user.displayName
        email = authDataResult.user.email
        photoURL = authDataResult.user.photoURL
        phoneNumber = authDataResult.user.phoneNumber
        refreshToken = authDataResult.user.refreshToken
        // Extract and assign other properties
    }

}

class UserManager {
    static let shared = UserManager()

    private let userDefaults = UserDefaults.standard
    private let userKey = "LoggedInUser"

    // Function to save the user after a successful login
    func saveLoggedInUser(currentUser: AuthDataResult) {
            let user = UserAuth(authDataResult: currentUser)

            do {
                let userData = try JSONEncoder().encode(user)
                userDefaults.set(userData, forKey: userKey)
            } catch {
                print("Error encoding user data: \(error)")
            }
    }

    // Function to retrieve the saved user
    func getLoggedInUser() -> UserAuth? {
        if let userData = userDefaults.data(forKey: userKey) {
            do {
                let user = try JSONDecoder().decode(UserAuth.self, from: userData)
                return user
            } catch {
                print("Error decoding user data: \(error)")
                return nil
            }
        }
        return nil
    }

    // Function to remove the saved user (e.g., on logout)
    func removeLoggedInUser() {
        userDefaults.removeObject(forKey: userKey)
    }
}
