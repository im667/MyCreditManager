//
//  main.swift
//  MyCreditManager
//
//  Created by 권오현 on 2022/11/20.
//

import Foundation

//model
struct Student {
    var name: String
    var attribute: [String:Double]
}

enum InputType: String {
    case addStudent = "1"
    case deleteStudent = "2"
    case addGrade = "3"
    case deleteGrade = "4"
    case getGradeAverage = "5"
    case end = "X"
}

let commandmsg = "원하는 기능을 입력해 주세요. \n 1: 학생추가, 2: 학생삭제, 3: 성적추가(변경), 4: 성적삭제, 5: 평점보기, X: 종료"
var flag = true
var data = [Student]()


func start(){
    while flag {
        print(commandmsg)
        let input = InputType(rawValue:readLine()!)
        switch input {
        case .addStudent:
            addStudent()
        
        case .deleteStudent:
            deleteStudent()
       
        case .addGrade:
            addGrade()
        case .deleteGrade:
            deleteGrade()
        case .getGradeAverage:
            getGradeAverage()
        case .end:
            flag = false
            print("프로그램을 종료합니다...")
            return
        default:
            print("뭔가 입력이 잘못되었습니다. 1~5사이의 숫자 혹은 X를 눌러주세요.")
        }
    }
}

func addStudent(){
    print("추가할 학생의 이름을 입력해 주세요.")
    let name = readLine()
    let studentName = String(name ?? "")
    let item = Student(name: studentName, attribute: ["":0])
    
    if data.contains(where: {
               studentName == $0.name
            }) {
                print("\(studentName) 학생은 이미 존재합니다. 추가하지 않습니다.")
                return
            } else {
                data.append(item)
                return
            }
    
        }
   


func deleteStudent(){
    print("삭제할 학생의 이름을 입력해 주세요.")
    let name = readLine()
    let studentName = String(name ?? "")
   
    for (idx, student) in data.enumerated() {
        if studentName == student.name {
            data.remove(at: idx)
            print("\(studentName) 학생을 삭제하였습니다.")
            return
            }
        }
}

func addGrade(){
    print("성적을 추가할 학생의 이름, 과목 이름, 성적(A+, A, F 등)을 띄어쓰기로 구분하여 차례로 작성해주세요 \n 입력예)Mickey Swift A+ \n 만약에 학생의 성적 중 해당과목이 존재하면 기존 점수가 갱신됩니다.")
    let input = readLine()!.split(separator: " ").map { String($0) }
   
    if input.count == 3 {
        
        
        let studentName = input[0]
        let subject = input[1]
        let grade = input[2].uppercased()
        
        for (idx, student) in data.enumerated() {
           
            if data.contains(where: {
                       studentName == $0.name
                    }) {
                data[idx].attribute.updateValue(gradeToDouble(grade: grade) , forKey: subject)
                print("\(studentName) 학생의 \(subject)과목이 \(grade)로 추가(변경)되었습니다.")
                return
            } else {
                print("입력이 잘못 되었습니다. 다시 확인해주세요.")
                return
            }
        }
        
    } else {
        
        print("입력이 잘못 되었습니다. 다시 확인해주세요.")
        return
    }
    
}

func deleteGrade(){
    print("성적을 추가할 학생의 이름, 과목 이름을 띄어쓰기로 구분하여 차례로 작성해주세요.")
    let input = readLine()!.split(separator: " ").map { String($0) }
   
    if input.count == 2 {
        
        
        let studentName = input[0]
        let subject = input[1]
        
        
        for (idx, student) in data.enumerated() {
           
            if studentName == student.name {
                data[idx].attribute[subject] = nil
                print("\(studentName) 학생의 \(subject)과목이 삭제 되었습니다.")
                return
            }
        }
        
    } else {
        
        print("입력이 잘못 되었습니다. 다시 확인해주세요.")
        return
    }
}

func getGradeAverage(){
    print("평점을 알고싶은 학생의 이름을 입력해주세요.")
    let name = readLine()
    let studentName = String(name ?? "")
   
    var total:Double = 0.0
    var subjectCount:Double = 0
    if data.contains(where: {
               studentName == $0.name
            }) {
        for subject in data {

             for item in subject.attribute {
                     if !item.key.isEmpty {
                         print(String("\(item.0):\(item.1)"))
                         total += item.value
                         subjectCount += 1
                        }
                    }
                }
                print("평점:\(Double(total/subjectCount))")
                return
               
            } else {
                print("\(studentName) 학생을 찾지 못했습니다.")
                return
            }
}

func gradeToDouble(grade: String)->Double{
    switch grade {
        
    case "A+":
        return 4.5
    case "A":
        return 4.0
    case "B+":
        return 3.5
    case "B":
        return 3.0
    case "C+":
        return 2.5
    case "C":
        return 2.0
    case "D+":
        return 1.5
    case "D":
        return 1.0
    case "F":
        return 0.0
        
    default:
        print("입력이 잘못되었습니다. 다시 확인해주세요.")
        return 0.0
    }
}


start()


