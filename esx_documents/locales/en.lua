Locales['en'] = {
    ['document_deleted'] = "Document was ~g~deleted~w~.",
    ['document_delete_failed'] = "Document delete ~r~failed~w~.",

}
Config.Documents['en'] = {
      ["public"] = {
	  	 {
          headerTitle = "POLICE - CRIME REPORT",
          headerSubtitle = "Report of Crime by Citizen/Statement of Facts.",
		  headerlogo="header_vicpolice",
          elements = {
            { label = "Complainant FIRSTNAME", type = "input", value = "", can_be_emtpy = false },
            { label = "Complainant LASTNAME", type = "input", value = "", can_be_emtpy = false },
			 { label = "DETAILS", type = "textarea", value = "", can_be_emtpy = true },
          } 
        },
        {
          headerTitle = "STATUTORY DECLARATION",
          headerSubtitle = "Declaration made by Citizen",
          elements = {
		    { label = "DATE OF DECLARATION", type = "input", value = "", can_be_emtpy = false },
		  	{ label = "INFORMATION", type = "textarea", value = "I make the following statutory declaration under the Oaths and Affirmations Act 2018. I declare that the contents of this statutory declaration are true and correct and I make it knowing that making a statutory declaration that I know to be untrue is an offence.", can_be_emtpy = false, can_be_edited = false },
            { label = "STATUTORY DECLARATION CONTENT", type = "textarea", value = "", can_be_emtpy = false },
          }
        },
        {
          headerTitle = "WITNESS STATEMENT",
          headerSubtitle = "Statement of a Whitness",
          elements = {
            { label = "DATE OF OCCURENCE", type = "input", value = "", can_be_emtpy = false },
			{ label = "TITLE", type = "input", value = "", can_be_emtpy = false },
            { label = "TESTIMONY CONTENT", type = "textarea", value = "", can_be_emtpy = false },
	
          }
        },
		 {
          headerTitle = "CONTRACT",
          headerSubtitle = "Legal Contract agreed by a single party, all parties must sign their own copies",
          elements = {
		    { label = "DATE", type = "input", value = "", can_be_emtpy = false },
			{ label = "FROM & TO (Enforcement Dates)", type = "input", value = "", can_be_emtpy = false },
            { label = "AGREED TERMS", type = "textarea", value = "", can_be_emtpy = false },
			{ label = "PENALTY FOR NON COMPLIANCE", type = "textarea", value = "", can_be_emtpy = false },
          }
        },
		
		 {
          headerTitle = "LETTER",
          headerSubtitle = "General Letter",
          elements = {
		    { label = "DATE", type = "input", value = "", can_be_emtpy = false },
			{ label = "TO", type = "input", value = "", can_be_emtpy = false },
            { label = "LETTER BODY", type = "textarea", value = "", can_be_emtpy = false },
			{ label = "FROM", type = "input", value = "", can_be_emtpy = false },
          }
        },
        {
          headerTitle = "VEHICLE CONVEY STATEMENT",
          headerSubtitle = "Vehicle movement/tow authorisation towards another citizen.",
          elements = {
            { label = "PLATE NUMBER", type = "input", value = "", can_be_emtpy = false },
            { label = "CITIZEN NAME", type = "input", value = "", can_be_emtpy = false },
            { label = "AGREED PRICE", type = "input", value = "", can_be_empty = false },
            { label = "OTHER INFORMATION", type = "textarea", value = "", can_be_emtpy = true },
          }
        },
        {
          headerTitle = "DEBT STATEMENT TOWARDS CITIZEN",
          headerSubtitle = "Official debt statement towards another citizen.",
          elements = {
            { label = "CREDITOR FIRSTNAME", type = "input", value = "", can_be_emtpy = false },
            { label = "CREDITOR LASTNAME", type = "input", value = "", can_be_emtpy = false },
            { label = "AMOUNT DUE", type = "input", value = "", can_be_empty = false },
            { label = "DUE DATE", type = "input", value = "", can_be_empty = false },
            { label = "OTHER INFORMATION", type = "textarea", value = "", can_be_emtpy = true },
          }
        },
        {
          headerTitle = "DEBT CLEARANCE DECLARATION",
          headerSubtitle = "Declaration of debt clearance from another citizen.",
          elements = {
            { label = "DEBTOR FIRSTNAME", type = "input", value = "", can_be_emtpy = false },
            { label = "DEBTOR LASTNAME", type = "input", value = "", can_be_emtpy = false },
            { label = "DEBT AMOUNT", type = "input", value = "", can_be_empty = false },
            { label = "OTHERINFORMATION", type = "textarea", value = "I HEREBY DECLARE THAT THE AFOREMENTIONED CITIZEN HAS COMPLETED A PAYMENT WITH THE AFOREMENTIONED DEBT AMOUNT", can_be_emtpy = false, can_be_edited = false },
          } 
        }
      },
      ["police"] = {
        
		{
          headerTitle = "POLICE - SEARCH RECEIPT",
          headerSubtitle = "Record of a Police Search",
		  headerlogo="header_vicpolice",
          elements = {
            { label = "FIRSTNAME", type = "input", value = "", can_be_emtpy = false },
            { label = "LASTNAME", type = "input", value = "", can_be_emtpy = false },
			{ label = "ADDRESS/REGO (IF ANY)", type = "input", value = "", can_be_emtpy = true },
			{ label = "PERSON/VEHICLE/PROPERTY", type = "input", value = "", can_be_empty = false },
			{ label = "REASON FOR SEARCH", type = "input", value = "", can_be_empty = false },
            { label = "DATE/TIME OCCURED", type = "input", value = "", can_be_empty = false },
			{ label = "FINDING", type = "textarea", value = "", can_be_empty = false },
			{ label = "SEIZED", type = "textarea", value = "", can_be_empty = false },
          } 
        },
		
		 {
          headerTitle = "POLICE - REQUEST FOR SEARCH WARRANT",
          headerSubtitle = "Request for a Search Warrant to be granted for the Search of a person or property",
		   headerlogo="header_vicpolice",
          elements = {
			{ label = "PROBABLE CAUSE TO PERMIT SEARCH (BE DETAILED)", type = "textarea", value = "", can_be_empty = false },
            { label = "PERMIT LAWFUL SEARCH OF ANY ON/WITHIN/IN CONTROL OF:", type = "textarea", value = "", can_be_empty = false },
            { label = "VALID UNTIL", type = "input", value = "", can_be_empty = false },
            
          } 
        },
		
		{
          headerTitle = "POLICE - NOTICE OF DEFECTIVE VEHICLE",
          headerSubtitle = "Notice of a Defective Vehicle to Driver/Owner",
		  headerlogo="header_vicpolice",
          elements = {

            { label = "REASONS FOR DEFECTIVE VEHICLE:", type = "textarea", value = "", can_be_empty = false },
            { label = "DO NOT DRIVE OR OPERATE THIS VEHICLE AFTER: ", type = "input", value = "[DATE/TIME]", can_be_empty = false },
			 { label = "DEFECT TYPE", type = "input", value = "MINOR/MAJOR", can_be_empty = false },
            
          } 
        },
		
		{
          headerTitle = "STATE OF VICTORIA - SUMMONS",
          headerSubtitle = "Notice to appear at Court",
		  headerlogo="header_court",
          elements = {

            { label = "FIRSTNAME", type = "input", value = "", can_be_emtpy = false },
            { label = "LASTNAME", type = "input", value = "", can_be_emtpy = false },
			{ label = "ADDRESS", type = "input", value = "", can_be_emtpy = false },
			{ label = "COURT", type = "textarea", value = "[DATE/TIME] Melbourne Court House - Macdonald St, Rancho", can_be_emtpy = false },
            
          } 
        },		
		
		
		{
          headerTitle = "POLICE - FIELD CONTACT REPORT",
          headerSubtitle = "Police Intelligence Record of event, activity or unusual behaviour.",
		  headerlogo="header_vicpolice",
          elements = {

            { label = "DATE/TIME:", type = "input", value = "[DATE/TIME]", can_be_empty = false },
			{ label = "CALLSIGN", type = "input", value = "[MTT/MEL/BGO/TRF]", can_be_empty = false },
			{ label = "ADDRESS OBSERVED", type = "input", value = "[STREET, SUBURB]", can_be_empty = false },
            { label = "NAMES / DETAILS OF VEHICLES ", type = "textarea", value = "", can_be_empty = false },
			{ label = "ACTIVITY/BEHAVIOUR OBSERVED ", type = "textarea", value = "", can_be_empty = false },

          } 
        },
		
		 {
          headerTitle = "NOTICE OF DRIVERS LICENCE SUSPENSION",
          headerSubtitle = "Notice from Police advising of suspension of a drivers licence.",
		  headerlogo="header_vicpolice",
          elements = {
            { label = "HOLDER FIRSTNAME", type = "input", value = "", can_be_emtpy = false },
            { label = "HOLDER LASTNAME", type = "input", value = "", can_be_emtpy = false },
            { label = "SUSPENDED ON", type = "input", value = "[DATIME/TIME]", can_be_empty = false },
            { label = "INFORMATION", type = "textarea", value = "YOUR DRIVERS LICENCE IS SUSPENDED UNTIL 6AM THE FOLLOWING DAY (HUMAN TIME). YOU COMMIT AN OFFENCE DRIVING A VEHICLE ON A PUBLIC ROAD OR ROAD RELATED AREA BEFORE THIS TIME. YOU CAN BE ARRESTED FOR NON COMPLIANCE.", can_be_emtpy = false, can_be_edited = false },
          } 
        },
		{
          headerTitle = "MOVE ON NOTICE",
          headerSubtitle = "Notice from Police advising you to move on and stay away.",
		  headerlogo="header_vicpolice",
          elements = {

            { label = "INFORMATION", type = "textarea", value = "YOU MUST MOVE ON AND STAY FROM FROM THE BELOW MENTIONED LOCATION FOR THE PERIOD DESCRIBED. YOU COMMIT AN OFFENCE IF YOU DO NOT COMPLY. POLICE HAVE POWERS OF ARREST INCLUDING THE ABILITY TO FINE AND CHARGE YOU FOR FAILING TO COMPLY WITH A LAWFUL POLICE DIRECTION", can_be_emtpy = false, can_be_edited = false },

			 { label = "TIME PERIOD", type = "input", value = " 8 Hours", can_be_emtpy = false }, { label = "LOCATION", type = "input", value = "", can_be_emtpy = false },
          } 
        },
		
        {
          headerTitle = "SPECIAL GUN PERMIT",
          headerSubtitle = "Special gun permit provided by the police.",
		  headerlogo="header_vicpolice",
          elements = {
            { label = "HOLDER FIRSTNAME", type = "input", value = "", can_be_emtpy = false },
            { label = "HOLDER LASTNAME", type = "input", value = "", can_be_emtpy = false },
            { label = "VALID UNTIL", type = "input", value = "", can_be_empty = false },
            { label = "INFORMATION", type = "textarea", value = "THE AFOREMENTIONED CITIZEN IS ALLOWED AND GRANTED A GUN PERMIT WHICH WILL BE VALID UNTIL THE AFOREMENTIONED EXPIRATION DATE.", can_be_emtpy = false },
          } 
        },
        {
          headerTitle = "CLEAN CITIZEN CRIMINAL RECORD",
          headerSubtitle = "Official clean, general purpose, citizen criminal record.",
		   headerlogo="header_vicpolice",
          elements = {
            { label = "CITIZEN FIRSTNAME", type = "input", value = "", can_be_emtpy = false },
            { label = "CITIZEN LASTNAME", type = "input", value = "", can_be_emtpy = false },
            { label = "VALID UNTIL", type = "input", value = "", can_be_empty = false },
            { label = "RECORD", type = "textarea", value = "THE POLICE HEREBY DECLARES THAT THE AFOREMENTIONED CITIZEN HOLDS A CLEAR CRIMINAL RECORD. THIS RESULT IS GENERATED FROM DATA SUBMITTED IN THE CRIMINAL RECORD SYSTEM BY THE DOCUMENT SIGN DATE.", can_be_emtpy = false, can_be_edited = false },
          }         }
      },
      ["ambulance"] = {
        {
          headerTitle = "MEDICAL REPORT - PATHOLOGY",
          headerSubtitle = "Official medical report provided by a pathologist.",
		  
          elements = {
            { label = "INSURED FIRSTNAME", type = "input", value = "", can_be_emtpy = false },
            { label = "INSURED LASTNAME", type = "input", value = "", can_be_emtpy = false },
            { label = "VALID UNTIL", type = "input", value = "", can_be_empty = false },
            { label = "MEDICAL NOTES", type = "textarea", value = "THE AFOREMENTIONED INSURED CITIZEN WAS TESTED BY A HEALTHCARE OFFICIAL AND DETERMINED HEALTHY WITH NO DETECTED LONGTERM CONDITIONS. THIS REPORT IS VALID UNTIL THE AFOREMENTIONED EXPIRATION DATE.", can_be_emtpy = false },
          }
        },
        {
          headerTitle = "MEDICAL REPORT - PSYCHOLOGY",
          headerSubtitle = "Official medical report provided by a psychologist.",
          elements = {
            { label = "INSURED FIRSTNAME", type = "input", value = "", can_be_emtpy = false },
            { label = "INSURED LASTNAME", type = "input", value = "", can_be_emtpy = false },
            { label = "VALID UNTIL", type = "input", value = "", can_be_empty = false },
            { label = "MEDICAL NOTES", type = "textarea", value = "THE AFOREMENTIONED INSURED CITIZEN WAS TESTED BY A HEALTHCARE OFFICIAL AND DETERMINED MENTALLY HEALTHY BY THE LOWEST APPROVED PSYCHOLOGY STANDARDS. THIS REPORT IS VALID UNTIL THE AFOREMENTIONED EXPIRATION DATE.", can_be_emtpy = false },
          } 
        },
        {
          headerTitle = "MEDICAL REPORT - EYE SPECIALIST",
          headerSubtitle = "Official medical report provided by an eye specialist.",
          elements = {
            { label = "INSURED FIRSTNAME", type = "input", value = "", can_be_emtpy = false },
            { label = "INSURED LASTNAME", type = "input", value = "", can_be_emtpy = false },
            { label = "VALID UNTIL", type = "input", value = "", can_be_empty = false },
            { label = "MEDICAL NOTES", type = "textarea", value = "THE AFOREMENTIONED INSURED CITIZEN WAS TESTED BY A HEALTHCARE OFFICIAL AND DETERMINED WITH A HEALTHY AND ACCURATE EYESIGHT. THIS REPORT IS VALID UNTIL THE AFOREMENTIONED EXPIRATION DATE.", can_be_emtpy = false },
          }
        },
        {
          headerTitle = "MARIJUANA USE PERMIT",
          headerSubtitle = "Official medical marijuana usage permit for citizens.",
          elements = {
            { label = "INSURED FIRSTNAME", type = "input", value = "", can_be_emtpy = false },
            { label = "INSURED LASTNAME", type = "input", value = "", can_be_emtpy = false },
            { label = "VALID UNTIL", type = "input", value = "", can_be_empty = false },
            { label = "MEDICAL NOTES", type = "textarea", value = "THE AFOREMENTIONED INSURED CITIZEN IS GRANTED, AFTER BEING THOROUGHLY EXAMINED BY A HEALTHCARE SPECIALIST, MARIJUANA USAGE PERMIT DUE TO UNDISCLOSED MEDICAL REASONS. THE LEGAL AND PERMITTED AMOUNT A CITIZEN CAN HOLD CAN NOT BE MORE THAN 100grams.", can_be_emtpy = false, can_be_edited = false },
          }
        },
	},

      ["avocat"] = {
        {
          headerTitle = "LEGAL SERVICES CONTRACT",
          headerSubtitle = "Legal services contract provided by a lawyer.",
          elements = {
            { label = "CITIZEN FIRSTNAME", type = "input", value = "", can_be_emtpy = false },
            { label = "CITIZEN LASTNAME", type = "input", value = "", can_be_emtpy = false },
            { label = "VALID UNTIL", type = "input", value = "", can_be_empty = false },
            { label = "INFORMATION", type = "textarea", value = "THIS DOCUMENT IS PROOF OF LEGAL REPRESANTATION AND COVERAGE OF THE AFOREMENTIONED CITIZEN. LEGAL SERVICES ARE VALID UNTIL THE AFOREMENTIONED EXPIRATION DATE.", can_be_emtpy = false },
          } 
        },
		 {
          headerTitle = "STATE OF VICTORIA - SEARCH WARRANT",
          headerSubtitle = "Permits Police or an enforcement agency to search any person or property.",
		  headerlogo="header_court",
          elements = {
			{ label = "INFORMATION", type = "textarea", value = "THIS DOCUMENT IS A SEARCH WARRANT IN THE STATE OF VICTORIA. ENSURE THIS DOCUMENT IS ISSUED BY A JUDGE OR MAGISTRATE TO BE TRUE AND CORRECT. RESISTING A LAWFUL SEARCH WARRANT IS AN OFFENCE. THE BEARER CAN SEARCH ANYTHING AS LABELED BELOW.", can_be_emtpy = false,  can_be_edited = false  },
            { label = "PERMIT LAWFUL SEARCH OF ANY ON/WITHIN/IN CONTROL OF:", type = "textarea", value = "", can_be_empty = false },
            { label = "VALID UNTIL", type = "input", value = "", can_be_empty = false },
            
          } 
        }
      },
	  
	["luxurydealer"] = {
	   {
          headerTitle = "LUXURY AUTOS PROOF OF SALE",
          headerSubtitle = "This receipt does not need to be provided to VicRoads as part of registration transfer. It can be used by the seller and buyer of a vehicle to ensure necessary sale information is recorded by both parties as proof of sale.",
          headerlogo= "luxury_autos",
          elements = {
            { label = "BUSINESS NAME", type = "input", value = "LUXURY AUTOS", can_be_emtpy = false, can_be_edited = false},
            { label = "ABN", type = "input", value = "28129216388", can_be_emtpy = false, can_be_edited = false},
            { label = "REGISTRATION NUMBER", type = "input", value = "", can_be_emtpy = false },
            { label = "MAKE / MODEL / BODY TYPE", type = "input", value = "", can_be_empty = false },
            { label = "NAME", type = "input", value = "", can_be_empty = false },
            { label = "PHONE", type = "input", value = "", can_be_empty = false },
            { label = "DATE OF SALE", type = "input", value = "", can_be_empty = false },
            { label = "TIME OF SALE", type = "input", value = "", can_be_empty = false },
            { label = "SALE PRICE", type = "input", value = "", can_be_empty = false },
            }
        }
		
	},
	 	  
  }
  