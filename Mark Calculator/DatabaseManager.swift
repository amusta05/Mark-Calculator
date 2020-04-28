//
//  DatabaseManager.swift
//  Mark Calculator
//
//  Created by Areeb Mustafa on 2020-04-27.
//  Copyright © 2020 Areeb Mustafa. All rights reserved.
//

import Foundation
import SQLite3

struct DatabaseManager {
    
    let dbPath: String = "myDb.sqlite"
    var db:OpaquePointer?
    init(){
        self.db = openDatabase()
        self.createTable()
    }
    func openDatabase() -> OpaquePointer?
    {
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent(dbPath)
        var db: OpaquePointer? = nil
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK
        {
            print("error opening database")
            return nil
        }
        else
        {
            print("Successfully opened connection to database at \(dbPath)")
            return db
        }
    }
    func createTable() -> Void {
        let courseTable = "CREATE TABLE IF NOT EXISTS Course (courseName TEXT, weight FLOAT,currentMark FLOAT,finalExamWorth FLOAT,totalPercentOfCourse FLOAT);"
        var courseTableStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, courseTable, -1, &courseTableStatement, nil) == SQLITE_OK
        {
            if sqlite3_step(courseTableStatement) == SQLITE_DONE
            {
                print("Course table created.")
            } else {
                print("Course table could not be created.")
            }
        } else {
            print("CREATE TABLE statement could not be prepared.")
        }
        sqlite3_finalize(courseTableStatement)
        
        let markTable = "CREATE TABLE if not EXISTS Mark(courseName TEXT, worth FLOAT,yourMark FLOAT,percentOfTotalMark FLOAT);"
        var markTableStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, markTable, -1, &markTableStatement, nil) == SQLITE_OK
        {
            if sqlite3_step(markTableStatement) == SQLITE_DONE
            {
                print("Mark table created.")
            } else {
                print("Mark table could not be created.")
            }
        } else {
            print("CREATE TABLE statement could not be prepared.")
        }
        sqlite3_finalize(markTableStatement)
        
    }
    func insertCourse(courseName: String,weight: Float,currentMark :Float,finalExamWorth: Float, totalPercentOfCourse:Float ) -> Void {
        let insertStatementString = "INSERT INTO Course (courseName,weight,currentMark,finalExamWorth,totalPercentOfCourse) VALUES (?, ?, ?, ?, ?);"
        var insertStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            sqlite3_bind_text(insertStatement, 1, (courseName as NSString).utf8String, -1, nil)
            sqlite3_bind_double(insertStatement, 2, Double(weight) )
            sqlite3_bind_double(insertStatement, 3, Double(currentMark))
            sqlite3_bind_double(insertStatement, 4, Double(finalExamWorth))
            sqlite3_bind_double(insertStatement, 5, Double(totalPercentOfCourse))
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("Successfully inserted row.")
            } else {
                print("Could not insert row.")
            }
        } else {
            print("INSERT statement could not be prepared.")
        }
        sqlite3_finalize(insertStatement)
    }
    
    func insertMark(courseName: String, worth: Float,yourMark: Float,percentageOfMark: Float) -> Void {
        
        let insertStatementString = "INSERT INTO Mark (courseName,worth,yourMark,percentOfTotalMark) VALUES (?, ?, ?, ?);"
        var insertStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            sqlite3_bind_text(insertStatement, 1, (courseName as NSString).utf8String, -1, nil)
            sqlite3_bind_double(insertStatement, 2, Double(worth))
            sqlite3_bind_double(insertStatement, 3, Double(yourMark))
            sqlite3_bind_double(insertStatement, 4, Double(percentageOfMark))
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("Successfully inserted row.")
            } else {
                print("Could not insert row.")
            }
        } else {
            print("INSERT statement could not be prepared.")
        }
        sqlite3_finalize(insertStatement)
        
    }
    func close() -> Void {
        sqlite3_close(db)
    }
    
    func deleteTables() -> Void {
        let dropCourse = "DELETE FROM Course;"
        var statement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, dropCourse, -1, &statement, nil) == SQLITE_OK {
        
            if sqlite3_step(statement) == SQLITE_DONE{
                print("Successfully deleted course.")
            }else{
                print("Could not delete Course.")
            }
        }
        else{
            print("Delete statement could not be prepared.")
        }
        sqlite3_finalize(statement)
        
        let dropMark = "DELETE FROM Mark;"
        var markStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, dropMark, -1, &markStatement, nil) == SQLITE_OK {
        
            if sqlite3_step(markStatement) == SQLITE_DONE{
                print("Successfully deleted Mark.")
            }else{
                print("Could not delete Mark.")
            }
        }
        else{
            print("Delete statement could not be prepared.")
        }
        sqlite3_finalize(markStatement)
        
        
    }
}
