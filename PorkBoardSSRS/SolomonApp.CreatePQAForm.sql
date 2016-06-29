:SETVAR	Server	EARTHDEV
:SETVAR	DBName	SolomonApp


:CONNECT $(Server) 
USE [$(DBName]
GO


DECLARE	
	@FormName		varchar (30) = 'PQA Site Assessment'
  , @FormID			int
  , @QuestionNbr	int
  , @Status			varchar (01) = 'A'
  , @Area			varchar (50)
  , @Definition		varchar (500) 
;

/*
	Create new form for PQA Site Assessment
*/

IF NOT EXISTS( SELECT 1 FROM dbo.cft_Form WHERE Form_Name = @FormName )
	INSERT INTO
		dbo.cft_Form( Form_Name, Form_Status )
	SELECT 
		Form_Name	= @FormName
	  , [status]	= @Status ;

SELECT @FormID = FormID FROM dbo.cft_Farm WHERE Form_Name = @FormID ; 

/*
	Add questions
*/

DECLARE	
	@PQAQuestions AS TABLE( 
		QuestionNbr		int				NOT NULL
	  , Area			varchar (50)	NOT NULL
	  , [Definition]	varchar (500)	NOT NULL ) ;

INSERT INTO
	@PQAQuestions
VALUES
    ( 01, 'External Facility', 'Does the site have a log for visitors to the facility?' )
  , ( 02, 'External Facility', 'Does the site have signage or other methods around the facility to control and restrict access for biosecurity compliance?' )
  , ( 03, 'Standard Operating Procedure', 'Does the site have a written SOP for animal handling procedures?' )
  , ( 04, 'Standard Operating Procedure', 'Does the site have a written SOP for piglet processing procedures, specifically castration and tail docking, that complies with AASV guidelines? NA if the site does not farrow piglets.' )
  , ( 05, 'Standard Operating Procedure', 'Does the site have a written SOP for feeding and watering protocols?' )
  , ( 06, 'Standard Operating Procedure', 'Does the site have a written SOP for conducting daily observations?' )
  , ( 07, 'Standard Operating Procedure', 'Does the site have a written SOP for caretaker training?' )
  , ( 08, 'Standard Operating Procedure', 'Does the site have a written SOP for treatment management?' )
  , ( 09, 'Standard Operating Procedure', 'Is there an SOP for needle usage that includes a section on broken needles covering prevention, identification of suspect pigs and protocol for what to do with that animal? NA for sites using needleless systems.' )
  , ( 10, 'Standard Operating Procedure', 'Does the site have a biosecurity SOP?' )
  , ( 11, 'Standard Operating Procedure', 'Does the site have an SOP for rodent control?' )
  , ( 12, 'Office Records', 'Are transporters delivering or picking up pigs from the site TQA Certified?' )
  , ( 13, 'Office Records', 'Do all caretakers have a current PQA Plus Certification or are within 90 days from their new employment date?' )
  , ( 14, 'Office Records', 'Does the site have a valid PQA Plus Site Status?' )
  , ( 15, 'Office Records', 'Is there a written record of emergency backup equipment being periodically tested? NA if the site is outdoors or naturally ventilated.' )
  , ( 16, 'Office Records', 'Does the site have documentation of annual caretaker training specific to their daily duties?' )
  , ( 17, 'Office Records', 'Does the farm have a written zero tolerance policy for willful acts of abuse or neglect?' )
  , ( 18, 'Office Records', 'Does the site have a reporting mechanism in place for caretakers to report abuse or neglect?' )
  , ( 19, 'Office Records', 'Does the site conduct internal site assessments of the facility, animals, caretakers, and procedures (breeding = quarterly; non-breeding = semiannually)?' )
  , ( 20, 'Office Records', 'Does the site have 12 months of records to verify the animals were observed at least once daily?' )
  , ( 21, 'Office Records', 'Does the site have 12 months of mortality records?' )
  , ( 22, 'Office Records', 'Does the site have a valid VCPR?' )
  , ( 23, 'Office Records', 'Does the site have compliant medication and treatment records?' )
  , ( 24, 'Office Records', 'Are medication and treatment records retained for 12 months?' )
  , ( 25, 'Office Records', 'Are VFD’s records retained according to FDA guidelines? NA for sites not using products requiring a VFD.' )
  , ( 26, 'Office Training Records', 'Can caretakers articulate their method for tracking what treatments have been administered and how long each animal has been receiving treatment?' )
  , ( 27, 'Office Training Records', 'Are caretakers able to articulate the training they received specific to their daily duties?' )
  , ( 28, 'Office Training Records', 'Are caretakers responsible for euthanasia able to articulate the site’s euthanasia plan?' )
  , ( 29, 'Office Training Records', 'Can caretakers articulate the site’s zero tolerance policy for willful acts of abuse and how to report abuse?' )
  , ( 30, 'Office Training Records', 'Can caretakers responsible for piglet processing procedures demonstrate or articulate the training they received to conduct the procedure according to the site’s SOP? NA if the site does not farrow piglets.' )
  , ( 31, 'Office', 'Does the site have an operational emergency backup system? NA if the site is outdoors or non-mechanically ventilated.' )
  , ( 32, 'Office', 'Is the euthanasia equipment readily available for use?' )
  , ( 33, 'Office', 'Does the site have a written euthanasia plan that is consistent with the current AASV guidelines?' )
  , ( 34, 'Office', 'Is the written euthanasia plan readily accessible to all caretakers in the facility?' )
  , ( 35, 'Office', 'Does the site have a written emergency action plan and are emergency contact numbers posted?' )
  , ( 36, 'Medications', 'Are animal health products stored properly and not past the expiration date?' )
  , ( 37, 'Medications', 'Is the site using the appropriate needle sizes per PQA Plus recommendations?' )
  , ( 38, 'Medications', 'Are the 16 gauge or larger needles on the site highly detectable?' )
  , ( 39, 'Medications', 'Are used sharps placed in a rigid puncture-resistant container that is labeled properly?' )
  , ( 40, 'Medications', 'Can caretakers articulate the site’s protocol for handling broken needles? NA for a needleless site.' )
  , ( 41, 'Animal Observations', 'Were any willful acts of abuse or neglect observed during the assessment?' )
  , ( 42, 'Animal Observations', 'Are animals euthanized in a timely manner?' )
  , ( 43, 'Animal Observations', 'If euthanasia is observed, are animals handled humanely during the process?' )
  , ( 44, 'Animal Observations', 'If euthanasia is observed, are animals euthanized in place or is suitable equipment available to move nonambulatory animals so they can be humanely euthanized?' )
  , ( 45, 'Animal Observations', 'If euthanasia is observed, do caretakers confirm insensibility and death after the euthanasia method is applied and before being removed from the facility?' )
  , ( 46, 'Animal Observations', 'Are animals handled appropriately for their age?' )
  , ( 47, 'Animal Observations', 'Can animal caretakers articulate or demonstrate appropriate use of equipment during animal handling?' )
  , ( 48, 'Animal Observations', 'Is proper handling equipment available and in good working order with no sharp edges?' )
  , ( 49, 'Animal Observations', 'Are electric prods used on suckling or weaned piglets? NA if suckling or weaned pigs are never on the site' )
  , ( 50, 'Animal Observations', 'Are electric prods used to move nursery, market pigs, sows or boars out of pens?' )
  , ( 51, 'Animal Observations', 'Do pigs show thermoregulatory behaviors that indicate they are too hot or too cold and the air temperature at the pig level is outside the preferred temperature range for the phase of production? If so, has the caretaker taken appropriate actions to minimize heat or cold stress?' )
  , ( 52, 'Animal Observations', 'Do the pigs have access to feed and water according to the site’s written SOP?' )
  , ( 53, 'Animal Observations', 'Are dead animals removed from the living space upon identification?' )
  , ( 54, 'Animal Observations', 'Do pigs show signs of exposure to poor air quality? If so does the ammonia concentration exceed 25 ppm?' )
  , ( 55, 'Animal Observations', 'Do at least 90% of animals observed have adequate space allowance (55f ? 90%)?' )
  , ( 56, 'Animal Observations', 'Do 1% or less of the animals observed have a body condition score of 1 (56f ? 1%)?' )
  , ( 57, 'Animal Observations', 'Have these pigs observed with a Body Condition Score of 1 been identified and are receiving attention? NA if zero pigs observed with BCS of 1.' )
  , ( 58, 'Animal Observations', 'Do 2% or less of the pigs observed show signs of severe lameness (58f ? 2%)?' )
  , ( 59, 'Animal Observations', 'Have these pigs observed to be severely lame been identified by caretakers and are receiving attention? NA if zero pigs observed with severe lameness.' )
  , ( 60, 'Animal Observations', 'Do 5% or less of the pigs observed have abscesses (60f ? 5%)?' )
  , ( 61, 'Animal Observations', 'Have these pigs observed with abscesses been identified by caretakers and receiving attention? NA if zero pigs observed with abscesses.' )
  , ( 62, 'Animal Observations', 'Do 1% or less of the pigs observed have deep wounds (62f ? 1%)?' )
  , ( 63, 'Animal Observations', 'Have these pigs observed with deep wounds been identified by caretakers and receiving attention? NA if zero pigs observed with deep wounds.' )
  , ( 64, 'Animal Observations', 'Do 10% or less of the pigs observed have scratches longer than 12 inches (64f ? 10%)?' )
  , ( 65, 'Animal Observations', 'Have these pigs observed with scratches longer than 12 inches been identified by caretakers and receiving attention? NA if zero pigs observed with scratches.' )
  , ( 66, 'Animal Observations', 'Do 5% or less of the breeding herd observed have shoulder sores (66b ? 5%)? NA if no breeding pigs on site.' )
  , ( 67, 'Animal Observations', 'Have these pigs observed with shoulder sores been identified by caretakers and receiving attention? NA if no breeding pigs on the site or zero observed with shoulder sores.' )
  , ( 68, 'Animal Observations', 'Do 5% or less of the pigs observed show evidence of tail biting in the herd (68f ? 5%)?' )
  , ( 69, 'Animal Observations', 'Have these pigs observed with evidence of tail biting been identified by caretakers and receiving attention? NA if zero pigs observed with tail biting lesions.' )
  , ( 70, 'Animal Observations', 'Do 5% or less of the non-breeding herd observed have hernias (70b ? 5%)? NA if no non-breeding pigs on site.' )
  , ( 71, 'Animal Observations', 'Have these pigs observed with hernias been identified by caretakers and receiving attention? NA if no non-breeding pigs on the site or zero observed with hernias.' )
  , ( 72, 'Animal Observations', 'Do 1% or less of the pigs observed have prolapses (72f ? 1%)?' )
  , ( 73, 'Animal Observations', 'Have these pigs observed with prolapses been identified by caretakers and receiving attention? NA if zero pigs observed with prolapses.' )
  , ( 74, 'Animal Observations', 'Do 5% or less of the breeding herd observed have vulva injuries (74b ? 5%)? NA if no breeding or only male breeding pigs on site.' )
  , ( 75, 'Animal Observations', 'Have these pigs observed with vulva injuries been identified by caretakers and receiving attention? NA if no breeding or only male breeding pigs on the site or zero observed with vulva injuries.' )
  , ( 76, 'Indoor Facilities', 'Is the penning appropriate for the phase of production and in a good state of repair and not causing or posing an imminent threat of injury to the animal?' )
  , ( 77, 'Indoor Facilities', 'Is the flooring appropriate for the phase of production and in a good state of repair and not causing or posing an imminent threat of injury to the animal?' )
  , ( 78, 'Indoor Facilities', 'Are the chutes in a good state of repair and not causing or posing an imminent threat of injury to the animal? NA if chute is not located at the site.' )
  , ( 79, 'Indoor Facilities', 'Are the alleyways in in a good state of repair and not causing or posing an imminent threat of injury to the animal?' )
  , ( 80, 'Indoor Facilities', 'Are the feeders in a good state of repair to allow for unobstructed feed delivery and not causing or posing an imminent threat of injury to the pigs?' )
  , ( 81, 'Indoor Facilities', 'Are the waterers in a good state of repair and positioned to allow for unobstructed water delivery and not causing or posing an imminent threat of injury to the pigs?' )
  , ( 82, 'Indoor Facilities', 'Do pigs have a dry space to lie down?' )
  , ( 83, 'Indoor Facilities', 'Is there evidence that the site’s rodent control SOP is being followed?' )
  , ( 84, 'Transportation', 'Are any pigs that are unable to walk or significantly injured being loaded for transport?' )
  , ( 85, 'Transportation', 'Are electric prods used as the primary tool for animal movement?' )
  , ( 86, 'Transportation', 'If electric prods are used, are they being applied correctly? NA if site does not use electric prods.' )
  , ( 87, 'Transportation', 'Do pigs loaded on the trailer show signs of overcrowding?' )
  , ( 88, 'Transportation', 'Do 1% or less of pigs fall during loading or unloading?' )
  , ( 89, 'Transportation', 'Do 25% or less of the pigs being moved receive an electric shock?' )
  , ( 90, 'Transportation', 'Is the trailer in a good state of repair?' )
  , ( 91, 'Transportation', 'Is the trailer properly aligned with the loading/unloading area?' )
  , ( 92, 'Transportation', 'Is the trailer appropriately equipped for weather conditions and phase of production during transport?' ) ;

/*
	Load questions into cft_Form_Ques
*/

WHILE EXISTS( SELECT 1 FROM @PQAQuestions )
BEGIN
	SELECT TOP 1
		@QuestionNbr	= QuestionNbr
	  , @Area			= Area
	  , @Definition		= [Definition]
	FROM
		@PQAQuestions
	ORDER BY 
		QuestionNbr

	INSERT INTO
		dbo.cft_Form_Ques(
			FormID, QuestionNbr, [status], Area, [Definition], Method )
	SELECT 
		FormID			= @FormID
	  , QuestionNbr		= @QuestionNbr
	  , [status]		= @Status
	  , Area			= @Area
	  , [Definition]	= @Definition ;

	DELETE @PQAQuestions WHERE QuestionNbr = @QuestionNbr ;

END


/*
	Add two new questions for additional questions for 
*/

EXECUTE 
	CFFDB.Utility.cfp_Eval_AddNewQuestionToForm
		@pFormName		= 'Site Yearly Audit'
	  , @pQuestionNbr	= 4
      , @pArea			= 'DOCUMENTATION'
	  , @pDefinition	= 'Does the site have signage or other methods around the facility to control and restrict access for biosecurity compliance?'
	  , @pMethod		= 'OBSERVE' ;

EXECUTE 
	CFFDB.Utility.cfp_Eval_AddNewQuestionToForm
		@pFormName		= 'Random Welfare Audit'
	  , @pQuestionNbr	= 4
      , @pArea			= 'DOCUMENTATION'
	  , @pDefinition	= 'Does the site have signage or other methods around the facility to control and restrict access for biosecurity compliance?'
	  , @pMethod		= 'OBSERVE' ;



	

