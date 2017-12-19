//
//  DoctorModel.swift
//  LIROS
//
//  Created by Fool on 10/20/17.
//  Copyright © 2017 Fulgent Wake. All rights reserved.
//

import Foundation
var commonMedsList = ["", "Amoxicillin 500 mg —-> 1 by mouth three times daily x 10 days, dispense # 30, no refill", "Amoxicilin 875 mg —-> 1 by mouth twice daily x 10 days, no refill", "Augmentin 875/125 mg —-> 1 by mouth twice daily x 10 days,", "Levaquin (Levoflaxacin) 750 mg —-> 1 by mouth once daily x 5 days, no refill", "Levaquin (Levoflaxacin) 500 mg —-> 1 by mouth once daily x 7 days, No refill", "Zithromax Z pack 5 day = Azithromycin 250 mg —-> 2 po at once on 1st day, then 1 by mouth once daily x 4 more days, # 6 tabs, no Refill", "Bactrim DS (Tirmethaprim/Sulfamethoxizole) 800/160 mg —-> 1 by mouth twice daily x 10 days", "Cleocin (Clindamycin) 150 mg —->", "Cleocin (Clindamycin) 300 mg", "Keflex (Cephalexin) 500 mg", "Omnicef (Cefdinir) 300 mg", "Prednisone 5 day", "Prednisone Taper", "Medial DosePack"]
let jointList = ["", "Right Knee", "Left Knee", "Both Knees", "Right Shoulder", "Left Shoulder", "Both Shoulders", "Right Elbow", "Left Elbow", "Both Elbows"]
let kneeList = ["", "Right Knee", "Left Knee", "Both Knees"]

struct DataReview:StructsWithDescriptionOutput {
    func getOutputFor(_ id:Int) -> String? {
        switch id {
        case 1: return "Labs reviewed"
        case 2: return "Tests reviewed"
        case 3: return "Out patient fasting labs"
        case 4: return "Get records"
        case 5: return "Continue current pain dosage"
        case 6: return "Colonoscopy results reviewed"
        case 7: return "Stool card results reviewed"
        case 8: return "Diabetic eye exam results reviewed"
        case 9: return "Mammogram results reviewed"
        case 15: return "Patient declines colonoscopy"
        case 16: return "Patient declines stool cards"
        case 17: return "Patient declines diabetic eye exam"
        case 18: return "Patient declines mammogram"
        default: return nil
        }
    }
    
    func processSectionData(_ data:[(Int, String?)]) -> String {
        var finalResult = String()
        let resultsStrings = getDescriptionOfItem(data, fromStruct: self) ?? [String]()
        
        if !resultsStrings.isEmpty {
            finalResult = resultsStrings.joined(separator: "\n")
        }
        return finalResult
    }
}

struct Education:StructsWithDescriptionOutput {
    func getOutputFor(_ id:Int) -> String? {
        switch id {
        case 1: return "Weight loss diet with calorie restriction and food diary counseled and admonished, info given."
        case 2: return "Diabetic diet and lifestyle counseling and info given, 45 gm carb per meal."
        case 3: return "Low fat, low cholesterol diet and exercise counseling and info given."
        case 4: return "Low salt and cardiac diet counseling and info given, DASH diet, 2400 mg Sodium per day."
        case 5: return "Hypertension goals, lifestyle management counseling and info given."
        case 6: return "Dietary fiber education and info given."
        case 7: return "Coumadin diet education with Vitamin K food content info given."
        case 8: return "Exercise counseling, guidance and education given."
        case 9: return "Tobacco cessation admonished: counseling and info given (3-10 min)."
        case 10: return "Stress and anxiety management counseling given."
        case 11: return "Treatment agreement discussed and reviewed with patient. Signed copy given to patient."
        case 12: return "Stroke warning signs discussed and info given."
        case 13: return "Depression management counseling and resources given."
        case 14: return "Adverse health consequences of alcohol discussed and alcohol cessation admonished."
        case 15: return "Gastroesophageal Reflux diet and lifestyle modifications discussed and info given."
        case 16: return "Thyroid symptoms discussed."
        default: return nil
        }
    }
    
    func processSectionData(_ data:[(Int, String?)]) -> String {
        var finalResult = String()
        let resultsStrings = getDescriptionOfItem(data, fromStruct: self) ?? [String]()
        
        if !resultsStrings.isEmpty {
            finalResult = "Patient education done:\n\(resultsStrings.joined(separator: "\n"))"
        }
        return finalResult
    }
}

struct Lab:StructsWithDescriptionOutput {
    func getOutputFor(_ id:Int) -> String? {
        switch id {
        case 1: return "Urine Dip, consent signed"
        case 2: return "UCG, consent signed"
        case 3: return "m UDS, consent signed"
        case 4: return "UDS, consent signed"
        case 5: return "Rapid Flu A&B Swab, consent signed"
        case 10: return "Glucometer finger blood sugar done in office today = "
        default: return nil
        }
    }
    
    func processSectionData(_ data:[(Int, String?)]) -> String {
        var finalResult = String()
        let resultsStrings = getDescriptionOfItem(data, fromStruct: self) ?? [String]()
        
        if !resultsStrings.isEmpty {
            finalResult = "Lab(s) ordered:\n\(resultsStrings.joined(separator: "\n"))"
        }
        return finalResult
    }
}

struct Procedures /*:StructsWithDescriptionOutput*/ {
    
    func processProceduresUsing(_ data:[(Int, String?)]) -> String {
        var resultArray = [String]()
        var results = String()
        for item in data {
            switch item.0 {
            case 1: resultArray.append("Digital rectal exam.")
            case 2: resultArray.append("Hemoccult Stool cards x 3 given for colon cancer screening.")
            case 3: resultArray.append("Incision and drainage of abscess, consent signed.")
            case 4: resultArray.append("EKG, consent signed.")
            case 10: resultArray.append("Cryo x \(item.1!), consent signed.")
            case 11: resultArray.append("Skin tag removal x \(item.1!), consent signed.")
            case 12: resultArray.append("Suture/staple removal x \(item.1!), consent signed.")
            default: continue
            }
        }
        
        if !resultArray.isEmpty {
            results = "Office procedure(s) performed:\n\(resultArray.joined(separator: "\n"))"
        }
        return results
    }
}

struct Injections:StructsWithDescriptionOutput {
    func getOutputFor(_ id:Int) -> String? {
        switch id {
        case 1: return "Decadron 4 mg/1 ml + Kenalog 40 mg/1 ml"
        case 2: return "Celestone 6 mg/1 ml"
        case 3: return "Solumedrol 125 mg"
        case 4: return "B12 1000 mcg/1 ml"
        case 5: return "Phenergan 25 mg"
        case 6: return "Toradol (Ketoralac)"
        case 7: return "Testosterone Cypionate 200 mg/1 ml"
        case 8: return "Estradiol Cypionate 5 mg/1ml"
        case 9: return "PPD (Purified Protein Derivative) Mantoux TB Skin Test 0.1 ml/5 TU"
        case 10: return "Flu shot 0.5 ml"
        case 11: return "Pneumovax 23: 0.5 ml"
        case 12: return "Tdap 0.5 ml"
        case 13: return "Nubain 10 mg + Phenergan 25 mg"
        case 14: return "Rocephin Lidocaine"
        case 15: return "DepoProvera 150 mg/1 ml"
        case 16: return "Procrit/Epogen 10,000 u"
        case 20: return "Arthrocentesis "
        case 21: return "Synvisc ONE "
        case 22: return "Trigger point injection with Lidocaine 1 ml + Celestone 6 mg/1 ml "
        case 25: return ""
        case 30: return "Prevnax 13: 0.5 ml IM, Rx written and given to patient."
        default: return nil
        }
    }
    
    func processSectionData(_ data:[(Int, String?)]) -> String {
        var finalResult = String()
        let resultsStrings = getDescriptionOfItem(data, fromStruct: self) ?? [String]()
        
        if !resultsStrings.isEmpty {
            finalResult = "Injection(s) given:\n\(resultsStrings.joined(separator: "\n"))"
        }
        return finalResult
    }
}
