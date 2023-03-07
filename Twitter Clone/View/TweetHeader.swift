//
//  TweetHeader.swift
//  Twitter Clone
//
//  Created by Davit Natenadze on 07.03.23.
//

import UIKit

class TweetHeader: UICollectionReusableView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
    
    
}

// MARK: - Style & Layout

extension TweetHeader {
    
    func style() {
        backgroundColor = .green
    }
    
    func layout() {
        
    }
}
