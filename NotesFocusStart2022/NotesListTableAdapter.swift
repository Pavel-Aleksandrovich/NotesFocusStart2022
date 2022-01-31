//
//  NotesListTableAdapter.swift
//  NotesFocusStart2022
//
//  Created by pavel mishanin on 31.01.2022.
//

import UIKit

protocol NotesListTableAdapterDelegate: AnyObject {
    func didSelectItem(title: String)
}

final class NotesListTableAdapter: NSObject {
    
    private weak var delegate: NotesListTableAdapterDelegate?
    private var dataSource: DiffableDataSource?
    private var notes = Dictionary<SectionIdentifier, [Entity]>()
    
    weak var tableView: UITableView? {
        didSet {
            guard let tableView = tableView else { return }
            
            let dataSource = makeDataSource(for: tableView)
            self.dataSource = dataSource
            self.tableView?.dataSource = dataSource
            self.tableView?.delegate = self
            self.tableView?.register(NotesListCell.self, forCellReuseIdentifier: "NotesListCell")
        }
    }
}
extension NotesListTableAdapter {
    private func makeDataSource(for tableView: UITableView) -> DiffableDataSource {
        let dataSource = DiffableDataSource(tableView: tableView) { tableView, indexPath, itemModel in
            let cell = tableView.dequeueReusableCell(withIdentifier: "NotesListCell", for: indexPath)
            
            if let cell = cell as? NotesListCell {
                
//                cell.update(viewModel: itemViewModel)
            }
            
            return cell
        }
        return dataSource
    }
}

extension NotesListTableAdapter: UITableViewDelegate {
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let section = SectionIdentifier.allCases[indexPath.section]
//        let notesInSection = self.notes[section]
//        let note = notesInSection?[indexPath.row]
//
//        guard let note = note else {return}
//        delegate?.didSelectItem(title: note.title)
//    }
}
