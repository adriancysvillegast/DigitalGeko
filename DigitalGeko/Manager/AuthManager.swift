//
//  AuthManager.swift
//  DigitalGeko
//
//  Created by Adriancys Jesus Villegas Toro on 22/11/23.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase


final class AuthManager {
    
    // MARK: - Properties
    static let shared = AuthManager()
    
    var db: DatabaseReference?
    
    var email: String? = {
        let user = Auth.auth().currentUser
        if let email = user?.email {
            return email
        }else {
            return ""
        }
    }()
    
    
    //    db = Database.database().reference(fromURL: "https://digitalgeko-c5d48-default-rtdb.firebaseio.com/")
    init(db: DatabaseReference = Database.database().reference(fromURL: "https://digitalgeko-c5d48-default-rtdb.firebaseio.com/") ) {
        self.db = db
    }
    
    
    // MARK: - Methods
    
    func createNewUser(email: String,
                       password: String,
                       userName: String,
                       phoneNumber: String,
                       success: @escaping(Bool) -> Void) {
        Auth.auth().createUser(
            withEmail: email,
            password: password
        ) { authResponse, error in
            
            guard let response = authResponse, error == nil else {
                success(false)
                return
            }
            
            
            self.saveUserName(user: response.user, userName: userName, number: phoneNumber)
            success(true)
            print(response.user)
            
        }
    }
    
    
    func logIn(email: String,
               password: String,
               success: @escaping (Bool) -> Void ) {
        Auth.auth().signIn(
            withEmail: email,
            password: password
        ) {  authResponse, error in
            
            if error != nil {
                success(false)
            }else {
                success(true)
            }
            
        }
    }
    
    
    func saveUserName(user: User, userName: String, number: String) {
//        print(user.email)
        self.db?.child("users").child(user.uid).setValue(["username" : userName])
        self.db?.child("phoneNumbers").child(user.uid).setValue(["phone" : number])
        self.db?.child("emails").child(user.uid).setValue(["email" : user.email])
    }
    
    
    func getUserName(completion: @escaping (String?) -> Void){
        let user = Auth.auth().currentUser
        if let userID = user?.uid {
            db?.child("users/\(userID)/username").getData(completion:  { error, snapshot in
                guard error == nil else {
                    print(error!.localizedDescription)
                    return;
                }
                let userName = snapshot?.value as? String ?? "Unknown"
                completion(userName)
            });
        }
        
    }
    
    
    func getUserNumber(completion: @escaping (String?) -> Void) {
        let user = Auth.auth().currentUser
        if let userID = user?.uid {
            db?.child("phoneNumbers/\(userID)/phone").getData(completion:  { error, snapshot in
                guard error == nil else {
                    print(error!.localizedDescription)
                    return;
                }
                let phone = snapshot?.value as? String ?? "Unknown"
                completion(phone)
            });
        }
    }
    
    func getEmail(completion: @escaping (String?) -> Void) {
        let user = Auth.auth().currentUser
        if let userID = user?.uid {
            db?.child("emails/\(userID)/email").getData(completion:  { error, snapshot in
                guard error == nil else {
                    print(error!.localizedDescription)
                    return;
                }
                let email = snapshot?.value as? String ?? "Unknown"
                completion(email)
            });
        }
    }
    
    
    func logOut() -> Bool {
        do {
            try Auth.auth().signOut()
            return true
        } catch  {
            return false
        }
    }
    
}
