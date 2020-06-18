//
//  Subject.swift
//  MyWorkbook
//
//  Created by abi01373 on 2020/06/06.
//  Copyright © 2020 zhenya. All rights reserved.
//

import Firebase
import RxSwift

struct Subject {
    var id: String
    var user: String
    var content: String
    var date: Date
}

class SubjectModel {
    
    let db: Firestore
    
    var listener: ListenerRegistration?
    
    init() {
        self.db = Firestore.firestore()
        db.settings.isPersistenceEnabled = true
    }
    
    func create(with content: String) -> Observable<Void> {
        return Observable.create { [unowned self] observer in
            self.db.collection("subjects").addDocument(data: [
                "user": (Auth.auth().currentUser?.uid)!,
                "content": content,
                "date": Date()
            ]) { error in
                if let e = error {
                    print("エッらら", e)
                    observer.onError(e)
                    return
                }
                observer.onNext(())
            }
            return Disposables.create()
        }
    }
    
    func read() -> Observable<QuerySnapshot> {
//        let options = QueryListenOptions()
//        options.includeQueryMetadataChanges(true)
        
        return Observable.create { [unowned self] observer in
            self.listener = self.db.collection("subjects")
                .order(by: "date")
                .addSnapshotListener { snapshot, error in
                    guard let snap = snapshot else {
                        print("Error fetching document: \(error!)")
                        observer.onError(error!)
                        return
                    }
                    for diff in snap.documentChanges {
                        if diff.type == .added {
                            print("New data: \(diff.document.data())")
                        }
                    }
                    print("Current data: \(snap)")
                    
                    observer.onNext(snap)
            }
            return Disposables.create()
        }
    }
    
    func update(_ subject: Subject) -> Observable<Void> {
        return Observable.create { [unowned self] observer in
            self.db.collection("subjects").document(subject.id).updateData([
                "content": subject.content,
                "date": subject.date
                ]) { error in
                if let e = error {
                    observer.onError(e)
                    return
                }
                observer.onNext(())
            }
            return Disposables.create()
        }
    }
    
    func delete(_ documentID: String) -> Observable<Void> {
        return Observable.create { [unowned self] observer in
            self.db.collection("subjects").document(documentID).delete() { error in
                if let e = error {
                    observer.onError(e)
                    return
                }
                observer.onNext(())
            }
            return Disposables.create()
        }
    }
}
