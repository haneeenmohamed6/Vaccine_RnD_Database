USE vaccine_rnd_db;

INSERT INTO clinical_phase (phase_name, description) VALUES
('Phase I','Initial safety and dose evaluation'),
('Phase II','Expanded safety and immunogenicity evaluation'),
('Phase III','Large-scale efficacy and safety evaluation'),
('Phase IV','Post-marketing surveillance');

INSERT INTO vaccine_candidate
(candidate_code,candidate_name,vaccine_type,target_disease,target_pathogen,development_status,development_start_date,description) VALUES
('VAC001','VaxNova-1','mRNA','COVID-19','SARS-CoV-2','Phase II','2025-01-10','Fictional mRNA vaccine candidate targeting a viral surface protein.'),
('VAC002','FluShield-2','Protein subunit','Influenza','Influenza A','Preclinical','2025-03-15','Fictional recombinant protein vaccine candidate.'),
('VAC003','CoronaVector-3','Viral vector','COVID-19','SARS-CoV-2','Phase I','2025-05-01','Fictional viral-vector candidate.'),
('VAC004','HepB-Next','Protein subunit','Hepatitis B','HBV','Phase III','2024-11-20','Fictional next-generation hepatitis B candidate.'),
('VAC005','RSV-Protect','Protein subunit','RSV disease','RSV','Preclinical','2026-01-12','Fictional RSV candidate.'),
('VAC006','DengueSafe','Live attenuated','Dengue','Dengue virus','Phase II','2025-07-05','Fictional dengue vaccine candidate.'),
('VAC007','MenoVax-7','mRNA','Measles','Measles virus','Discovery','2026-02-01','Fictional early-stage candidate.'),
('VAC008','TB-Prime','DNA','Tuberculosis','Mycobacterium tuberculosis','Preclinical','2025-09-10','Fictional DNA vaccine candidate.'),
('VAC009','ChikVax-9','Viral vector','Chikungunya','Chikungunya virus','Phase I','2025-10-22','Fictional viral-vector candidate.'),
('VAC010','NipahGuard','Protein subunit','Nipah virus disease','Nipah virus','Discovery','2026-03-18','Fictional early discovery candidate.');

INSERT INTO antigen
(antigen_code,antigen_name,pathogen,antigen_type,target_protein,description) VALUES
('AG001','Spike-RBD','SARS-CoV-2','Recombinant protein','Spike RBD','Fictional recombinant receptor-binding domain antigen.'),
('AG002','Influenza-HA','Influenza A','Recombinant protein','Hemagglutinin','Fictional hemagglutinin antigen.'),
('AG003','HBV-HBsAg','HBV','Surface antigen','HBsAg','Fictional hepatitis B surface antigen.'),
('AG004','RSV-F','RSV','Fusion protein','F protein','Fictional RSV fusion antigen.'),
('AG005','Dengue-E','Dengue virus','Envelope protein','E protein','Fictional dengue envelope antigen.'),
('AG006','Measles-H','Measles virus','Viral protein','H protein','Fictional measles antigen.'),
('AG007','TB-Ag85','Mycobacterium tuberculosis','Protein antigen','Ag85 complex','Fictional TB antigen.'),
('AG008','Chik-E2','Chikungunya virus','Envelope protein','E2 protein','Fictional chikungunya antigen.'),
('AG009','Nipah-G','Nipah virus','Glycoprotein','G protein','Fictional Nipah antigen.'),
('AG010','SARS-N','SARS-CoV-2','Nucleocapsid protein','N protein','Fictional nucleocapsid antigen.');

INSERT INTO candidate_antigen VALUES
(1,1,'Primary antigen',50,'ug'),(1,10,'Secondary antigen',20,'ug'),
(2,2,'Primary antigen',40,'ug'),(3,1,'Primary antigen',35,'ug'),
(4,3,'Primary antigen',20,'ug'),(5,4,'Primary antigen',45,'ug'),
(6,5,'Primary antigen',30,'ug'),(7,6,'Primary antigen',25,'ug'),
(8,7,'Primary antigen',40,'ug'),(9,8,'Primary antigen',35,'ug');

INSERT INTO formulation
(candidate_id,formulation_code,formulation_version,adjuvant,dosage_form,route_of_administration,dose_amount,dose_unit,storage_temperature,formulation_status) VALUES
(1,'FOR001','v1.0','Lipid nanoparticle','Injection','IM',50,'ug','2-8 C','Validated'),
(1,'FOR002','v2.0','Lipid nanoparticle','Injection','IM',100,'ug','-20 C','Development'),
(2,'FOR003','v1.0','Aluminum hydroxide','Injection','IM',40,'ug','2-8 C','Validated'),
(3,'FOR004','v1.0','None','Injection','IM',35,'ug','2-8 C','Development'),
(4,'FOR005','v1.0','Aluminum hydroxide','Injection','IM',20,'ug','2-8 C','Released'),
(5,'FOR006','v1.0','Matrix-M','Injection','IM',45,'ug','2-8 C','Validated'),
(6,'FOR007','v1.0','AS01-like','Injection','IM',30,'ug','2-8 C','Development'),
(7,'FOR008','v1.0','Lipid nanoparticle','Injection','IM',25,'ug','-20 C','Development'),
(8,'FOR009','v1.0','CpG adjuvant','Injection','IM',40,'ug','2-8 C','Validated'),
(9,'FOR010','v1.0','None','Injection','IM',35,'ug','2-8 C','Development');

INSERT INTO batch
(formulation_id,batch_number,manufacturing_date,expiry_date,batch_size,batch_size_unit,manufacturing_status,quality_status) VALUES
(1,'B001','2026-01-10','2027-01-10',10000,'doses','Completed','Released'),
(1,'B002','2026-02-15','2027-02-15',12000,'doses','Completed','Passed'),
(2,'B003','2026-03-05','2027-03-05',8000,'doses','Manufactured','Pending'),
(3,'B004','2026-03-20','2027-03-20',9000,'doses','Completed','Released'),
(4,'B005','2026-04-01','2027-04-01',7000,'doses','Manufactured','Passed'),
(5,'B006','2026-04-18','2027-04-18',15000,'doses','Completed','Released'),
(6,'B007','2026-05-02','2027-05-02',6000,'doses','Manufactured','Pending'),
(7,'B008','2026-05-20','2027-05-20',11000,'doses','Completed','Passed'),
(8,'B009','2026-06-01','2027-06-01',5000,'doses','Manufactured','Pending'),
(9,'B010','2026-06-15','2027-06-15',7500,'doses','Completed','Released');

INSERT INTO preclinical_study
(candidate_id,study_code,study_type,animal_model,start_date,end_date,study_status,objective,conclusion) VALUES
(1,'PC001','Immunogenicity','Mouse','2025-02-01','2025-03-15','Completed','Assess antibody response.','Strong response observed.'),
(2,'PC002','Toxicology','Rat','2025-05-01','2025-06-10','Completed','Assess repeat-dose safety.','No major toxicity observed.'),
(3,'PC003','Efficacy','Mouse','2025-06-15','2025-08-01','Completed','Evaluate protective efficacy.','Protective response observed.'),
(4,'PC004','Immunogenicity','Mouse','2025-01-15','2025-03-01','Completed','Assess immunogenicity.','Adequate response observed.'),
(5,'PC005','Toxicology','Rat','2026-02-01',NULL,'Ongoing','Assess safety.','Pending.'),
(6,'PC006','Efficacy','Mouse','2025-08-01','2025-10-01','Completed','Evaluate efficacy.','Reduced viral burden observed.'),
(7,'PC007','Immunogenicity','Mouse','2026-03-01',NULL,'Ongoing','Assess early immune response.','Pending.'),
(8,'PC008','Toxicology','Rat','2025-10-01','2025-12-01','Completed','Assess systemic toxicity.','No major toxicity observed.'),
(9,'PC009','Efficacy','Mouse','2026-01-10','2026-03-10','Completed','Evaluate protection.','Protective response observed.'),
(10,'PC010','Immunogenicity','Mouse','2026-04-01',NULL,'Planned','Assess immune response.','Pending.');

INSERT INTO preclinical_result
(preclinical_study_id,parameter_name,parameter_value,unit,result_status,observation) VALUES
(1,'Antibody titer',820,'AU/mL','Positive','Strong response'),
(2,'ALT',38,'U/L','Normal','Within expected range'),
(3,'Protection rate',82,'%','Positive','Protective effect'),
(4,'Antibody titer',760,'AU/mL','Positive','Good response'),
(5,'Body weight change',2.5,'%','Normal','Stable'),
(6,'Protection rate',79,'%','Positive','Protective effect'),
(7,'Antibody titer',610,'AU/mL','Positive','Early response'),
(8,'ALT',41,'U/L','Normal','Within expected range'),
(9,'Protection rate',75,'%','Positive','Protective effect'),
(10,'Antibody titer',NULL,'AU/mL','Inconclusive','Study not started.');

INSERT INTO clinical_study
(candidate_id,phase_id,study_code,study_title,protocol_version,start_date,end_date,study_status,primary_objective) VALUES
(1,2,'CS001','VaxNova-1 Phase II Immunogenicity Study','1.0','2026-01-15',NULL,'Ongoing','Evaluate immunogenicity and safety.'),
(4,3,'CS002','HepB-Next Phase III Efficacy Study','2.1','2025-10-01',NULL,'Ongoing','Evaluate efficacy and safety.'),
(6,2,'CS003','DengueSafe Phase II Study','1.2','2026-02-10',NULL,'Recruiting','Evaluate immune response.'),
(3,1,'CS004','CoronaVector-3 Phase I Safety Study','1.0','2026-03-01','2026-06-30','Completed','Evaluate initial safety and dose.'),
(9,1,'CS005','ChikVax-9 Phase I Study','1.0','2026-04-01',NULL,'Ongoing','Evaluate safety.'),
(1,2,'CS006','VaxNova-1 Booster Study','1.1','2026-05-01',NULL,'Recruiting','Evaluate booster response.'),
(4,3,'CS007','HepB-Next Long-term Study','1.0','2026-01-01',NULL,'Ongoing','Evaluate long-term safety.'),
(6,2,'CS008','DengueSafe Dose Study','1.0','2026-06-01',NULL,'Planned','Compare dose groups.'),
(3,1,'CS009','CoronaVector-3 Extended Safety','1.0','2026-07-01',NULL,'Planned','Evaluate extended safety.'),
(9,1,'CS010','ChikVax-9 Dose Escalation','1.0','2026-07-15',NULL,'Recruiting','Evaluate dose escalation.');

INSERT INTO study_site
(site_code,site_name,country,city,site_type,activation_date,site_status) VALUES
('SITE001','Central Vaccine Research Center','Egypt','Cairo','Research Hospital','2026-01-01','Active'),
('SITE002','Alexandria Clinical Unit','Egypt','Alexandria','Clinical Center','2026-01-05','Active'),
('SITE003','Giza Medical Research Site','Egypt','Giza','Research Hospital','2026-02-01','Active'),
('SITE004','Delta Trial Center','Egypt','Mansoura','Clinical Center','2026-02-15','Active'),
('SITE005','Upper Egypt Research Unit','Egypt','Luxor','Clinical Center','2026-03-01','Active'),
('SITE006','Mediterranean Trial Site','Egypt','Port Said','Clinical Center','2026-03-10','Active'),
('SITE007','National Immunology Center','Egypt','Cairo','Research Institute','2026-04-01','Active'),
('SITE008','West Nile Clinical Unit','Egypt','Giza','Clinical Center','2026-04-15','Active'),
('SITE009','Nile Valley Research Hospital','Egypt','Aswan','Research Hospital','2026-05-01','Active'),
('SITE010','Eastern Clinical Research Center','Egypt','Ismailia','Clinical Center','2026-05-15','Active');

INSERT INTO clinical_study_site
(clinical_study_id,site_id,site_role,activation_date,enrollment_target,site_status) VALUES
(1,1,'Lead site','2026-01-10',50,'Active'),
(1,2,'Recruitment site','2026-01-20',40,'Active'),
(2,3,'Lead site','2025-09-15',80,'Active'),
(2,4,'Recruitment site','2025-10-01',60,'Active'),
(3,5,'Lead site','2026-02-01',50,'Active'),
(4,6,'Lead site','2026-02-20',30,'Closed'),
(5,7,'Lead site','2026-03-20',35,'Active'),
(6,8,'Recruitment site','2026-04-20',40,'Active'),
(7,9,'Lead site','2026-01-10',70,'Active'),
(8,10,'Lead site','2026-05-20',45,'Active');

INSERT INTO participant
(participant_code,age_group,sex,eligibility_status,enrollment_date,withdrawal_date,withdrawal_reason) VALUES
('PT001','18-25','Female','Eligible','2026-01-25',NULL,NULL),
('PT002','26-35','Male','Eligible','2026-01-27',NULL,NULL),
('PT003','36-45','Female','Eligible','2026-02-02',NULL,NULL),
('PT004','46-60','Male','Eligible','2026-02-05',NULL,NULL),
('PT005','18-25','Male','Eligible','2026-02-12',NULL,NULL),
('PT006','26-35','Female','Eligible','2026-02-20','2026-04-05','Personal decision'),
('PT007','36-45','Male','Eligible','2026-03-01',NULL,NULL),
('PT008','46-60','Female','Eligible','2026-03-10',NULL,NULL),
('PT009','18-25','Female','Eligible','2026-03-18',NULL,NULL),
('PT010','26-35','Male','Pending','2026-04-01',NULL,NULL);

INSERT INTO clinical_enrollment
(participant_id,clinical_study_id,site_id,enrollment_date,treatment_group,dose_group,enrollment_status,completion_date) VALUES
(1,1,1,'2026-01-25','Vaccine','50 ug','Enrolled',NULL),
(2,1,1,'2026-01-27','Placebo','Placebo','Enrolled',NULL),
(3,1,2,'2026-02-02','Vaccine','100 ug','Enrolled',NULL),
(4,2,3,'2026-02-05','Vaccine','20 ug','Enrolled',NULL),
(5,2,3,'2026-02-12','Placebo','Placebo','Enrolled',NULL),
(6,3,5,'2026-02-20','Vaccine','30 ug','Withdrawn','2026-04-05'),
(7,4,6,'2026-03-01','Vaccine','35 ug','Completed','2026-06-30'),
(8,5,7,'2026-03-10','Vaccine','35 ug','Enrolled',NULL),
(9,6,8,'2026-03-18','Vaccine','100 ug','Enrolled',NULL),
(10,7,9,'2026-04-01','Vaccine','20 ug','Screened',NULL);

INSERT INTO laboratory_test
(test_code,test_name,test_type,specimen_type,unit,reference_range_low,reference_range_high) VALUES
('LT001','Antibody Titer','Immunology','Serum','AU/mL',0,1000),
('LT002','Neutralization Assay','Immunology','Serum','% inhibition',0,100),
('LT003','PCR Viral Load','Molecular','Nasopharyngeal swab','copies/mL',0,1000000),
('LT004','ALT','Clinical chemistry','Serum','U/L',7,56),
('LT005','AST','Clinical chemistry','Serum','U/L',10,40),
('LT006','Hemoglobin','Hematology','Blood','g/dL',12,18),
('LT007','White Blood Cell Count','Hematology','Blood','10^9/L',4,11),
('LT008','Cytokine IL-6','Immunology','Serum','pg/mL',0,50),
('LT009','IgG','Immunology','Serum','mg/dL',700,1600),
('LT010','CRP','Clinical chemistry','Serum','mg/L',0,10);

INSERT INTO participant_lab_result
(participant_id,clinical_study_id,test_id,test_date,result_value,result_text,result_status) VALUES
(1,1,1,'2026-02-01',820,'Strong antibody response','Positive'),
(1,1,4,'2026-02-01',32,'Normal','Normal'),
(2,1,1,'2026-02-01',120,'Low response','Positive'),
(3,1,2,'2026-02-10',78,'Good neutralization','Positive'),
(4,2,1,'2026-02-15',760,'Strong response','Positive'),
(5,2,4,'2026-02-15',40,'Normal','Normal'),
(6,3,8,'2026-02-25',22,'Within expected range','Normal'),
(7,4,3,'2026-03-15',1200,'Low viral load','Positive'),
(8,5,1,'2026-03-20',650,'Positive response','Positive'),
(9,6,2,'2026-04-01',82,'Good neutralization','Positive');

INSERT INTO adverse_event
(participant_id,clinical_study_id,event_date,event_type,severity,seriousness,related_to_vaccine,outcome,action_taken,resolution_date,description) VALUES
(1,1,'2026-02-02','Injection-site pain','Mild','Non-serious','Probable','Recovered','Observation','2026-02-04','Localized discomfort after vaccination.'),
(2,1,'2026-02-03','Headache','Mild','Non-serious','Possible','Recovered','Observation','2026-02-05','Transient headache.'),
(3,1,'2026-02-11','Fatigue','Moderate','Non-serious','Probable','Recovered','Rest and observation','2026-02-14','Temporary fatigue.'),
(4,2,'2026-02-16','Fever','Mild','Non-serious','Possible','Recovered','Antipyretic recommendation','2026-02-18','Low-grade fever.'),
(5,2,'2026-02-17','Injection-site redness','Mild','Non-serious','Probable','Recovered','Observation','2026-02-19','Localized redness.'),
(6,3,'2026-02-25','Headache','Moderate','Non-serious','Possible','Recovered','Observation','2026-02-28','Moderate headache.'),
(7,4,'2026-03-20','Fever','Mild','Non-serious','Possible','Recovered','Observation','2026-03-22','Short fever episode.'),
(8,5,'2026-03-22','Fatigue','Mild','Non-serious','Possible','Recovered','Rest','2026-03-24','Temporary fatigue.'),
(9,6,'2026-04-02','Muscle pain','Mild','Non-serious','Probable','Recovered','Observation','2026-04-04','Transient muscle pain.'),
(1,1,'2026-04-10','Nausea','Mild','Non-serious','Unlikely','Recovered','Observation','2026-04-11','Mild nausea.');
