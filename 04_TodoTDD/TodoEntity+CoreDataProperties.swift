//
//  TodoEntity+CoreDataProperties.swift
//  04_TodoTDD
//
//  Created by rae on 2021/11/24.
//
//

import Foundation
import CoreData


extension TodoEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TodoEntity> {
        return NSFetchRequest<TodoEntity>(entityName: "TodoEntity")
    }

    @NSManaged public var address: String?
    @NSManaged public var desc: String?
    @NSManaged public var title: String?

}

extension TodoEntity : Identifiable {

}
