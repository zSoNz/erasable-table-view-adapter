//
//  ViewController.swift
//  TableAdapter
//
//  Created by IDAP Developer on 8/7/19.
//  Copyright © 2019 Bendis. All rights reserved.
//
//

import UIKit

import TableAdapter

class ViewController: UIViewController {
    
    @IBOutlet var table: UITableView?
    
    //MARK: -
    //MARK: Variables
    
    var adapter: TableAdapter?
    
    private let animals = [Animal(name: "Cow"), Animal(name: "Horse")]
    private let fruits = [Fruit(name: "Apple"), Fruit(name: "Peach")]
    
    //MARK: -
    //MARK: View Life Cylce
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Creating instance of adapter
        self.adapter = TableAdapter(
            table: self.table,
            cells: [AnimalTableViewCell.self, FruitTableViewCell.self, EmptyTableViewCell.self]
        )
        
        // Adding handling of UITableView events, like "reloadData" or "didSelectRow"
        self.adapter?.eventHandler = { [weak self] in
            self?.handle(tableEvents: $0)
        }
        
        // Adding wrapers of models in sections
        self.adapter?.sections = self.sections()
    }
    
    //MARK: -
    //MARK: Private
    
    private func sections() -> [Section] {
        // Views for footer and header sections creation
        let yellowView = UIView()
        yellowView.backgroundColor = .yellow
        
        let blueView = UIView()
        blueView.backgroundColor = .blue
        
        let firstSection = Section(
            cell: AnimalTableViewCell.self,
            models: self.animals,
            sectionDelimetrs: SectionDelimetrs(footer: .init(view: blueView, height: 20)),
            eventHandler: { [weak self] in self?.handle(animalEvents: $0) }
        )
        
        let secondSection = Section(
            cell: FruitTableViewCell.self,
            models: self.fruits,
            isEditing: true,
            sectionDelimetrs: SectionDelimetrs(header: .init(view: yellowView, height: 20))
        )
        
        let thirdSection = Section(
            cell: EmptyTableViewCell.self,
            count: 3
        )
        
        return [firstSection, secondSection, thirdSection]
    }
    
    //MARK: -
    //MARK: Handlers
    
    private func handle(tableEvents: TableViewEvents) {
        switch tableEvents {
        case let .didSelect(indexPath):
            if indexPath.section == 0 {
                print("Selected animal is \(self.animals[indexPath.row])")
            } else if indexPath.section == 1 {
                print("Selected fruit is \(self.fruits[indexPath.row])")
            }
        case .didRemove(_):
            break
        case .loadNext:
            break
        case .didReloadData:
            break
        }
    }
    
    private func handle(animalEvents: AnimalTableViewCellEvents) {
        switch animalEvents {
        case .buttonDidTapped:
            print("Button on animal section did taped")
        }
    }
}
