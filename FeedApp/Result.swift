//
//  Result.swift
//  FeedApp
//
//  Created by Дмитрий Мартьянов on 24.01.2022.
//

import Foundation

public enum Result<A>{
    case success(A)
    case failure(String)
}
