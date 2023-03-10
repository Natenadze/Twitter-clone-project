//
//  ProfileFilterView.swift
//  Twitter Clone
//
//  Created by Davit Natenadze on 03.03.23.
//

import UIKit

private let reuseIdentifier = "ProfileFilterCell"

protocol ProfileFilterViewDelegate: AnyObject {
    func filterView(_ view: ProfileFilterView, didSelect indexpath: IndexPath)
}

class ProfileFilterView: UIView {
    
    // MARK: - Properties
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    let selectedIndexPath = IndexPath(row: 0, section: 0)
    
    
    weak var delegate: ProfileFilterViewDelegate?
    
    // MARK: - Override func
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
        style()
        layout()
        
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        collectionView.register(ProfileFilterCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
}




// MARK: - Style & Layout

extension ProfileFilterView {
    
    func style() {
        // tweets are selected by default
        collectionView.selectItem(at: selectedIndexPath, animated: true, scrollPosition: .left)
    }
    
    func layout() {
        addSubview(collectionView)
    
        // frame = superView frame
        collectionView.addConstraintsToFillView(self)
    }
}


// MARK: - delegate

extension ProfileFilterView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        delegate?.filterView(self, didSelect: indexPath)
    }
}


// MARK: - FlowLayout delegate

extension ProfileFilterView: UICollectionViewDelegateFlowLayout {
 
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        // automatic count of elements
        let count = CGFloat(ProfileFilterOptions.allCases.count)
        // fill equally all elements
       return  CGSize(width: frame.width/count - 4, height: frame.height)
    }
    
    // add spacing between cells
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        1
    }
}

// MARK: - Data Source

extension ProfileFilterView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        ProfileFilterOptions.allCases.count  // returns 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ProfileFilterCell
        
        let option = ProfileFilterOptions(rawValue: indexPath.row)
        cell.option = option
//        cell.titleLabel.text = option?.desctiption
                                          
                                          
        
        return cell
    }
    
    
}

