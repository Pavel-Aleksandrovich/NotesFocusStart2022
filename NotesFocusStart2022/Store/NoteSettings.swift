//
//  NoteSettings.swift
//  NotesFocusStart2022
//
//  Created by pavel mishanin on 03.02.2022.
//

import Foundation

protocol NoteSettings {
    var tasks: [NoteEntity]! { get set }
    func saveTask(task: NoteEntity)
    func removeTask(index: Int)
    func numberOfTasks() -> Int
    func getTaskByIndex(index: Int) -> NoteEntity
    func updateTaskByIndex(index: Int, task: NoteEntity)
}

final class NoteSettingsImpl: NoteSettings {
    
    private enum SettingsKey {
        static let noteEntity = "noteEntity"
    }
    
    var tasks: [NoteEntity]! {
        get {
            guard let data = UserDefaults.standard.object(forKey: SettingsKey.noteEntity) as? Data,
                  let decodeModel = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [NoteEntity] else { return [NoteEntity(title: "title", descriptionText: "description", noteImage: #imageLiteral(resourceName: "DefaultProfileImage"))] }
            return decodeModel
        } set {
            if let model = newValue {
                if let saveData = try? NSKeyedArchiver.archivedData(withRootObject: model, requiringSecureCoding: false) {
                    UserDefaults.standard.set(saveData, forKey: SettingsKey.noteEntity)
                }
            }
        }
    }
    
    func saveTask(task: NoteEntity) {
        tasks.insert(task, at: 0)
    }

    func removeTask(index: Int) {
        tasks.remove(at: index)
    }

    func numberOfTasks() -> Int {
        return tasks.count
    }

    func getTaskByIndex(index: Int) -> NoteEntity {
        return tasks[index]
    }

    func updateTaskByIndex(index: Int, task: NoteEntity) {
        tasks.remove(at: index)
        tasks.insert(task, at: index)
    }
}
