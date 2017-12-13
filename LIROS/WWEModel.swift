//
//  WWEModel.swift
//  LIROS
//
//  Created by Fool on 12/13/17.
//  Copyright © 2017 Fulgent Wake. All rights reserved.
//

import Foundation

struct WellWomenExam {
	let lastPapChoices = ["", "1 year ago", "2 years ago", "3 or more years ago"]
	let periodFrequencyChoices = ["", "14", "21", "24", "26", "28", "30", "32", "34"]
	let periodLengthChoices = ["", "1", "2", "3", "4", "5", "6", "7", "8"]
	let bloodFlowChoices = ["", "light", "moderate", "heavy"]
	let birthControlMethods = ["", "OCP", "condoms", "diaphram", "IUD", "depo injection"]
	let selfExamFrequencyChoices = ["", "weekly", "monthly", "twice per month", "every few months", "yearly"]
	
	let zeroToFourChoices = ["", "0", "1", "2", "3", "4"]
	lazy var zeroToFiveChoices = zeroToFourChoices + ["5"]
	lazy var zeroToSixChoices = zeroToFiveChoices + ["6"]
	
	func processFxMatricesData(_ data:[(matrix:Int, selections:[Int])]) -> String {
		var resultArray = [String]()
		var results = String()
		for item in data {
			resultArray.append("\(FxSection.item.matrix): \()")
		}
		return results
	}
}

enum FxSection:Int {
	case breast = 1
	case colon
	case uterine
	case overian
	case osteoporosis
	case heart
	
	var fullValue: String {
		switch self {
		case .breast: return "Breast cancer"
		case .colon: return "Colon cancer"
		case .uterine: return "Uterine cancer"
		case .overian: return "Overian cancer"
		case .osteoporosis: return "Osteoporosis"
		case .heart: return "Heart disease"
		}
	}
}

enum FamilyRelationship:Int {
	case mother = 0
	case father
	case brother
	case sister
	case maternalGrandmother
	case maternalGrandfather
	case paternalGrandmother
	case paternalGrandfather
	case maternalAunt
	case maternalUncle
	case paternalAunt
	case paternalUncle
	case cousin
	case son
	case daughter
	case none
	
	var fullValue: String {
		switch self {
		case .mother: return "mother"
		case .father: return "father"
		case .brother: return "brother"
		case .sister: return "sister"
		case .maternalGrandmother: return "maternal grandmother"
		case .maternalGrandfather: return "maternal grandfather"
		case .paternalGrandmother: return "paternal grandmother"
		case .paternalGrandfather: return "paternal grandfather"
		case .maternalAunt: return "maternal aunt"
		case .maternalUncle: return "maternal uncle"
		case .paternalAunt: return "paternal aunt"
		case .paternalUncle: return "paternal uncle"
		case .cousin: return "cousin"
		case .son: return "son"
		case .daughter: return "daughter"
		case .none: return "no history"
		}
	}
}


enum WWEQuestions:String {
	case LastMammogram = "When was your last mammogram?"
	case LastPeriod = "When was your last period?"
	case LastPAP = "When was your last PAP test?"
	case LastPAPNormal = "Were the results normal?"
	case EverHadAbnormalPAP = "Have you ever had an abnormal PAP test?"
	case DateOfAbnormalPAP = "Abnormal PAP results on:"
	case FrequencyOfPeriod = "How often do you usually get your period?"
	case PeriodsRegular = "Are your periods usually regular?"
	case PeriodLength = "How many days do your periods usually last?"
	case BloodFlow = "The blood flow is:"
	case BleedingBetween = "Do you have any bleeding between periods?"
	case VaginalDischarge = "Do you have any vaginal discharge?"
	case SexuallyActive = "Are you sexually active?"
	case UseBirthControl = "If yes, do you and your partner use birth control?"
	case BirthControlMethod = "Method:"
	case STD = "Have you ever had a sexually transmitted disease?"
	case DES = "Has your mother ever been exposed to DES?"
	case FertilityMedicines = "Have you ever used fertility medicines?"
	case HotFlashes = "Do you have hot flashes?"
	case HormoneReplacement = "Are you on hormone replacement?"
	case Smoke = "Do you smoke?"
	case SelfBreastExams = "How often do you perform self breast-exams?"
	case HXBreastProblems = "Do you have a history of breast problems?"
	case BeenAbused = "Have you ever been abused?"
	case FeelSafe = "Do you feel safe?"
	//"\(finalFamilyHistory(historyList: familyHistory)!)" +
	case Allergies = "Do you have any allergies?"
	case Allergens = ""
	//"On a scale of 0 to 10, with 0 being no symptoms and 10 being severe symptoms, how would you describe the following:\n" +
	case PeriodPain = "Pain during your usual period:"
	case SexPain = "Pain during sex:"
	case PMSPain = "PMS (premenstrual tension syndrome):"
	//"If you have been pregnant, please indicate how many:\n" +
	case Pregnancies = "Pregnancies:"
	case Abortions = "Abortions:"
	case Miscarriages = "Miscarriages:"
	case LivingChildren = "Living children:"
	case LiveBirths = "Full-term live births:"
	case PrematureBirths = "Premature births:"
	case OtherConcerns = "Please list any other concerns:"
}
