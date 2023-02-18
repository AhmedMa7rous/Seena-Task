//
//  CodableResponses.swift
//  Seena Task
//
//
//  Created by Ma7rous on 18/02/2023.
//


import Foundation



struct ImgurResponse<T: Codable>: Codable {
  let data: T
}
