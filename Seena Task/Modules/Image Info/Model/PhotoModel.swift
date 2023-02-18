//
//  PhotoModel.swift
//  Seena Task
//
//  Created by Ma7rous on 18/02/2023.
//

import Foundation


struct UploadResult: Codable, CustomDebugStringConvertible {
  let deletehash: String
  let link: URL

  var debugDescription: String {
    return "<UploadResult:\(deletehash)> \(link)"
  }
}
