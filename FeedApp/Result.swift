//
//  Result.swift
//  FeedApp
//
//  Created by Дмитрий Мартьянов on 24.01.2022.
//

import Foundation

public enum Result<Model>{
    case success(Model)
    case failure(String)
}
