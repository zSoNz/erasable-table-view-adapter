//
//  UITableView+Extensions.swift
//  TableAdapter
//
//  Created by IDAP Developer on 8/7/19.
//  Copyright © 2019 Bendis. All rights reserved.
//

import UIKit

func toString(_ cls: AnyClass) -> String {
    return String(describing: cls)
}

extension UITableView {
    
    public func dequeueReusableCell(withCellClass cellClass: AnyClass, for indexPath: IndexPath) -> UITableViewCell {
        return self.dequeueReusableCell(withIdentifier: toString(cellClass), for: indexPath)
    }
    
    @discardableResult
    public func dequeueReusableCell<Result>(withCellClass cellClass: AnyClass, for indexPath: IndexPath) -> Result
        where Result: UITableViewCell
    {
        let cell = self.dequeueReusableCell(withIdentifier: toString(cellClass), for: indexPath)
        
        guard let value = cell as? Result else {
            fatalError("Dont find identifire")
        }
        
        return value
    }
    
    func register(cells: Set<String>) {
        cells.forEach { type in
            self.register(cell:type)
        }
    }
    
    func register(cells: String...) {
        self.register(cells: Set(cells))
    }
    
    func register(cells: UITableViewCell.Type...) {
        self.register(cells: Set(cells.map { toString($0) }))
    }
    
    func register(cellClass: UITableViewCell.Type) {
        self.register(cell: toString(cellClass))
    }
    
    func register(cell: String) {
        let nib = UINib.init(nibName: cell, bundle: nil)
        self.register(nib, forCellReuseIdentifier: cell)
    }
    
    func register(headerFooters: [String]) {
        headerFooters.forEach { type in
            self.register(headerFooter:type)
        }
    }
    
    func register(headerFooter: String) {
        let nib = UINib.init(nibName: headerFooter, bundle: nil)
        self.register(nib, forHeaderFooterViewReuseIdentifier: headerFooter)
    }
    
    func register(headerFooterClass: AnyClass) {
        self.register(headerFooter: toString(headerFooterClass))
    }
    
    func register(_ cellClass: AnyClass) {
        let nib = UINib(nibName: toString(cellClass), bundle: nil)
        self.register(nib, forCellReuseIdentifier: toString(cellClass))
    }
}

extension UITableViewCell {
    
    static var nib: UINib {
        return UINib(nibName: self.identifire, bundle: nil)
    }
    
    static var identifire: String {
        return String(describing: self)
    }
}
