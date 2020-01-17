//
//  TableAdapter.swift
//  TableAdapter
//
//  Created by IDAP Developer on 8/7/19.
//  Copyright © 2019 Bendis. All rights reserved.
//

import UIKit

/**
 TableViewEvents default table event wrapper in enum.
*/
public enum TableViewEvents {
    
    case didReloadData /// Called after table reload own data.
    case didSelect(IndexPath) /// Called after user tap on row.
    case didRemove(IndexPath) /// Called after user remove row.
    case loadNext /// Created for pagination, called when user receives bottom of table view.
}

/**
 TableAdapter wrapper for UITableView class, represent default table delegate functions in more comfortable way.
*/
public class TableAdapter: NSObject, UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate {
    
    //MARK: -
    //MARK: Accesors
    
    /// Sections will be equal with count of section in table, all rows inside section model be equal of count rows in section.
    public var sections = [Section]() {
        didSet {
            self.table?.reloadData()
            UIView.animate(
                withDuration: 0.0,
                delay: 0,
                options: [.overrideInheritedOptions],
                animations: { self.table?.reloadData() },
                completion: { _ in self.eventHandler?(.didReloadData) }
            )
        }
    }
    
    /// Closure for handling default table events, like  "reloadData" or "didSelectRow".
    public var eventHandler: F.Handler<TableViewEvents>?
    
    private var isEndDragging: Bool = true
    private weak var table: UITableView?
    
    //MARK: -
    //MARK: Initializations
    
    /**
        Initializator for Table Adapter.
        
        @param table TableView what be wrapped.
        @param models Array of cells type, what be registered for dequeReusableCell func.
    */
    public init(table: UITableView?, cells: [UITableViewCell.Type]) {
        self.table = table
        
        super.init()
        
        table?.dataSource = self
        table?.delegate = self
        cells.forEach {
            self.table?.register($0)
        }
    }
    
    //MARK: -
    //MARK: TableView DataSource & Delegate
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return self.sections.count
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sections[section].models.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = self.sections[indexPath.section]
        
        let cell = tableView.dequeueReusableCell(withCellClass: section.cell, for: indexPath)
        
        let value = cell as? AnyCellType
        let model = section.models[indexPath.row]
        
        value?.fill(with: model, eventHandler: section.eventHandler)
        
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.eventHandler?(.didSelect(indexPath))
    }
    
    public func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            self.sections[indexPath.section].models.remove(at: indexPath.row)
            self.eventHandler?(.didRemove(indexPath))
        default:
            break
        }
    }
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return self.sections[section].sectionDelimetrs.header?.view
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return self.sections[section].sectionDelimetrs.header?.height ?? 0
    }
    
    public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return self.sections[section].sectionDelimetrs.footer?.view
    }
    
    public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return self.sections[section].sectionDelimetrs.footer?.height ?? 0
    }
    
    // MARK: - UIScrollViewDelegate
    
    public func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return self.sections[indexPath.section].isEditing
    }
    
    public func scrollViewWillEndDragging(_ scrollView: UIScrollView,
                                   withVelocity velocity: CGPoint,
                                   targetContentOffset: UnsafeMutablePointer<CGPoint>)
    {
        let distance = scrollView.contentSize.height - (targetContentOffset.pointee.y + scrollView.bounds.height)
        let isNeedLoad = scrollView.contentSize.height > scrollView.frame.height
        if distance < 20 && velocity.y > 0 && isNeedLoad {
            self.eventHandler?(.loadNext)
        }
    }
    
    public func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.isEndDragging = false
    }
    
    public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        self.isEndDragging = true
    }
}
