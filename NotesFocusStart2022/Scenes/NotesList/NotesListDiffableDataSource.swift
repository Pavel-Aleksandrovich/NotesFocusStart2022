//
//  NotesListDiffableDataSource.swift
//  NotesFocusStart2022
//
//  Created by pavel mishanin on 31.01.2022.
//

import UIKit

enum SectionIdentifier: String, CaseIterable {
    case listNotes = "listNotes"
}

typealias Snapshot = NSDiffableDataSourceSnapshot<SectionIdentifier, NoteEntity>
typealias TableViewData = Dictionary<SectionIdentifier, [NoteEntity]>

final class DiffableDataSource: UITableViewDiffableDataSource<SectionIdentifier, NoteEntity> {
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return SectionIdentifier.allCases[section].rawValue
    }
}
