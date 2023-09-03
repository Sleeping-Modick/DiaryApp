//
//  FirestoreManager.swift
//  DiaryApp
//
//  Created by t2023-m0056 on 2023/09/01.
//

<<<<<<< HEAD
import Foundation
import FirebaseFirestore

final class FirestoreService {
    let db = Firestore.firestore()
    
    func getPostData(completion: @escaping ([Post]?) -> Void) {
        var names: [[String:Any]] = [[:]]
        var post: [Post]?
        
        db.collection("Post").getDocuments { (querySnapshot, error) in
=======
import FirebaseFirestore
import Foundation

final class FirestoreService {
//    let db = Firestore.firestore()
    static let db = Firestore.firestore()

    func getPostData(completion: @escaping ([Post]?) -> Void) {
        var names: [[String: Any]] = [[:]]
        var post: [Post]?

        FirestoreService.db.collection("Post").getDocuments { querySnapshot, error in
>>>>>>> 3efe6a1 ([MERGE]: feature/firebase-operation)
            if let error = error {
                print("Error getting documents: \(error)")
                completion(post) // 호출하는 쪽에 빈 배열 전달
                return
            }
            for document in querySnapshot!.documents {
                names.append(document.data())
            }
            names.remove(at: 0)
            post = self.dictionaryToObject(objectType: Post.self, dictionary: names)
            completion(post) // 성공 시 이름 배열 전달
        }
    }
<<<<<<< HEAD
    
    func addPostDocument(content: String, goal: String, image: String, tag: Array<String>, temperature: String, weather: String, weatherIcon: String, completion: @escaping (String) -> Void) {
        // Add a new document with a generated ID
        db.collection("Info").document(goal).setData([
=======

    func addPostDocument(content: String, goal: String, image: String, tag: [String], temperature: String, weather: String, weatherIcon: String, completion: @escaping (String) -> Void) {
        // Add a new document with a generated ID
        FirestoreService.db.collection("Post").document(goal).setData([
>>>>>>> 3efe6a1 ([MERGE]: feature/firebase-operation)
            "content": content,
            "goal": goal,
            "image": image,
            "tag": tag,
            "temperature": temperature,
            "weather": weather,
            "weatherIcon": weatherIcon,
        ]) { err in
            if let err = err {
<<<<<<< HEAD
                print("Error adding document: \(err)")
            } else {
                completion("Post Document added")
=======
                print("### Error adding document: \(err)")
            } else {
                completion("#### Post Document added")
                print("### 현재 Firebase 에 저장된 데이터들 : \(FirestoreService.db.collection("Info").document(goal))")
>>>>>>> 3efe6a1 ([MERGE]: feature/firebase-operation)
            }
        }
    }
}

extension FirestoreService {
<<<<<<< HEAD
    func dictionaryToObject<T:Decodable>(objectType:T.Type,dictionary:[[String:Any]]) -> [T]? {
        
=======
    func dictionaryToObject<T: Decodable>(objectType: T.Type, dictionary: [[String: Any]]) -> [T]? {
>>>>>>> 3efe6a1 ([MERGE]: feature/firebase-operation)
        guard let dictionaries = try? JSONSerialization.data(withJSONObject: dictionary) else { return nil }
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        guard let objects = try? decoder.decode([T].self, from: dictionaries) else { return nil }
        return objects
    }
<<<<<<< HEAD
    
    func dicToObject<T:Decodable>(objectType:T.Type,dictionary:[String:Any]) -> T? {
        
=======

    func dicToObject<T: Decodable>(objectType: T.Type, dictionary: [String: Any]) -> T? {
>>>>>>> 3efe6a1 ([MERGE]: feature/firebase-operation)
        guard let dictionaries = try? JSONSerialization.data(withJSONObject: dictionary) else { return nil }
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        guard let objects = try? decoder.decode(T.self, from: dictionaries) else { return nil }
        return objects
    }
}
