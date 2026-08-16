CREATE DATABASE IF NOT EXISTS vaccine_rnd_db;
USE vaccine_rnd_db;

CREATE TABLE vaccine_candidate (
    candidate_id INT AUTO_INCREMENT PRIMARY KEY,
    candidate_code VARCHAR(20) NOT NULL UNIQUE,
    candidate_name VARCHAR(150) NOT NULL,
    vaccine_type VARCHAR(50) NOT NULL,
    target_disease VARCHAR(150) NOT NULL,
    target_pathogen VARCHAR(150) NOT NULL,
    development_status VARCHAR(30) NOT NULL,
    development_start_date DATE,
    description VARCHAR(500),
    CHECK (development_status IN ('Discovery','Preclinical','Phase I','Phase II','Phase III','Approved','Discontinued'))
);

CREATE TABLE antigen (
    antigen_id INT AUTO_INCREMENT PRIMARY KEY,
    antigen_code VARCHAR(20) NOT NULL UNIQUE,
    antigen_name VARCHAR(150) NOT NULL,
    pathogen VARCHAR(150) NOT NULL,
    antigen_type VARCHAR(80) NOT NULL,
    target_protein VARCHAR(150),
    description VARCHAR(500)
);

CREATE TABLE candidate_antigen (
    candidate_id INT NOT NULL,
    antigen_id INT NOT NULL,
    antigen_role VARCHAR(80) NOT NULL,
    antigen_amount DECIMAL(10,2),
    amount_unit VARCHAR(20),
    PRIMARY KEY (candidate_id, antigen_id),
    FOREIGN KEY (candidate_id) REFERENCES vaccine_candidate(candidate_id),
    FOREIGN KEY (antigen_id) REFERENCES antigen(antigen_id),
    CHECK (antigen_amount IS NULL OR antigen_amount > 0)
);

CREATE TABLE formulation (
    formulation_id INT AUTO_INCREMENT PRIMARY KEY,
    candidate_id INT NOT NULL,
    formulation_code VARCHAR(20) NOT NULL UNIQUE,
    formulation_version VARCHAR(20) NOT NULL,
    adjuvant VARCHAR(100),
    dosage_form VARCHAR(60) NOT NULL,
    route_of_administration VARCHAR(30) NOT NULL,
    dose_amount DECIMAL(10,2) NOT NULL,
    dose_unit VARCHAR(20) NOT NULL,
    storage_temperature VARCHAR(30),
    formulation_status VARCHAR(30) NOT NULL,
    FOREIGN KEY (candidate_id) REFERENCES vaccine_candidate(candidate_id),
    CHECK (dose_amount > 0),
    CHECK (formulation_status IN ('Development','Validated','Released','Discontinued'))
);

CREATE TABLE batch (
    batch_id INT AUTO_INCREMENT PRIMARY KEY,
    formulation_id INT NOT NULL,
    batch_number VARCHAR(30) NOT NULL UNIQUE,
    manufacturing_date DATE NOT NULL,
    expiry_date DATE NOT NULL,
    batch_size INT NOT NULL,
    batch_size_unit VARCHAR(20) NOT NULL,
    manufacturing_status VARCHAR(30) NOT NULL,
    quality_status VARCHAR(30) NOT NULL,
    FOREIGN KEY (formulation_id) REFERENCES formulation(formulation_id),
    CHECK (expiry_date > manufacturing_date),
    CHECK (batch_size > 0),
    CHECK (manufacturing_status IN ('Planned','Manufactured','Completed','Cancelled')),
    CHECK (quality_status IN ('Pending','Passed','Failed','Released','Rejected'))
);

CREATE TABLE preclinical_study (
    preclinical_study_id INT AUTO_INCREMENT PRIMARY KEY,
    candidate_id INT NOT NULL,
    study_code VARCHAR(30) NOT NULL UNIQUE,
    study_type VARCHAR(50) NOT NULL,
    animal_model VARCHAR(100),
    start_date DATE NOT NULL,
    end_date DATE,
    study_status VARCHAR(30) NOT NULL,
    objective VARCHAR(500),
    conclusion VARCHAR(500),
    FOREIGN KEY (candidate_id) REFERENCES vaccine_candidate(candidate_id),
    CHECK (end_date IS NULL OR end_date >= start_date),
    CHECK (study_status IN ('Planned','Ongoing','Completed','Terminated'))
);

CREATE TABLE preclinical_result (
    result_id INT AUTO_INCREMENT PRIMARY KEY,
    preclinical_study_id INT NOT NULL,
    parameter_name VARCHAR(100) NOT NULL,
    parameter_value DECIMAL(12,3),
    unit VARCHAR(30),
    result_status VARCHAR(30),
    observation VARCHAR(500),
    FOREIGN KEY (preclinical_study_id) REFERENCES preclinical_study(preclinical_study_id)
);

CREATE TABLE clinical_phase (
    phase_id INT AUTO_INCREMENT PRIMARY KEY,
    phase_name VARCHAR(30) NOT NULL UNIQUE,
    description VARCHAR(300)
);

CREATE TABLE clinical_study (
    clinical_study_id INT AUTO_INCREMENT PRIMARY KEY,
    candidate_id INT NOT NULL,
    phase_id INT NOT NULL,
    study_code VARCHAR(30) NOT NULL UNIQUE,
    study_title VARCHAR(250) NOT NULL,
    protocol_version VARCHAR(30) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE,
    study_status VARCHAR(30) NOT NULL,
    primary_objective VARCHAR(500),
    FOREIGN KEY (candidate_id) REFERENCES vaccine_candidate(candidate_id),
    FOREIGN KEY (phase_id) REFERENCES clinical_phase(phase_id),
    CHECK (end_date IS NULL OR end_date >= start_date),
    CHECK (study_status IN ('Planned','Recruiting','Ongoing','Completed','Terminated'))
);

CREATE TABLE study_site (
    site_id INT AUTO_INCREMENT PRIMARY KEY,
    site_code VARCHAR(30) NOT NULL UNIQUE,
    site_name VARCHAR(150) NOT NULL,
    country VARCHAR(80) NOT NULL,
    city VARCHAR(80) NOT NULL,
    site_type VARCHAR(50),
    activation_date DATE,
    site_status VARCHAR(30) NOT NULL,
    CHECK (site_status IN ('Planned','Active','Inactive','Closed'))
);

CREATE TABLE clinical_study_site (
    clinical_study_id INT NOT NULL,
    site_id INT NOT NULL,
    site_role VARCHAR(60),
    activation_date DATE,
    enrollment_target INT,
    site_status VARCHAR(30) NOT NULL,
    PRIMARY KEY (clinical_study_id, site_id),
    FOREIGN KEY (clinical_study_id) REFERENCES clinical_study(clinical_study_id),
    FOREIGN KEY (site_id) REFERENCES study_site(site_id),
    CHECK (enrollment_target IS NULL OR enrollment_target >= 0),
    CHECK (site_status IN ('Planned','Active','Closed'))
);

CREATE TABLE participant (
    participant_id INT AUTO_INCREMENT PRIMARY KEY,
    participant_code VARCHAR(30) NOT NULL UNIQUE,
    age_group VARCHAR(20) NOT NULL,
    sex VARCHAR(20) NOT NULL,
    eligibility_status VARCHAR(30) NOT NULL,
    enrollment_date DATE NOT NULL,
    withdrawal_date DATE,
    withdrawal_reason VARCHAR(250),
    CHECK (age_group IN ('18-25','26-35','36-45','46-60','>60')),
    CHECK (sex IN ('Female','Male','Other','Not disclosed')),
    CHECK (eligibility_status IN ('Eligible','Ineligible','Pending')),
    CHECK (withdrawal_date IS NULL OR withdrawal_date >= enrollment_date)
);

CREATE TABLE clinical_enrollment (
    enrollment_id INT AUTO_INCREMENT PRIMARY KEY,
    participant_id INT NOT NULL,
    clinical_study_id INT NOT NULL,
    site_id INT NOT NULL,
    enrollment_date DATE NOT NULL,
    treatment_group VARCHAR(60) NOT NULL,
    dose_group VARCHAR(60),
    enrollment_status VARCHAR(30) NOT NULL,
    completion_date DATE,
    FOREIGN KEY (participant_id) REFERENCES participant(participant_id),
    FOREIGN KEY (clinical_study_id, site_id) REFERENCES clinical_study_site(clinical_study_id, site_id),
    UNIQUE (participant_id, clinical_study_id),
    CHECK (completion_date IS NULL OR completion_date >= enrollment_date),
    CHECK (enrollment_status IN ('Screened','Enrolled','Completed','Withdrawn','Screen Failure'))
);

CREATE TABLE laboratory_test (
    test_id INT AUTO_INCREMENT PRIMARY KEY,
    test_code VARCHAR(30) NOT NULL UNIQUE,
    test_name VARCHAR(150) NOT NULL,
    test_type VARCHAR(80) NOT NULL,
    specimen_type VARCHAR(80) NOT NULL,
    unit VARCHAR(30),
    reference_range_low DECIMAL(12,3),
    reference_range_high DECIMAL(12,3)
);

CREATE TABLE participant_lab_result (
    lab_result_id INT AUTO_INCREMENT PRIMARY KEY,
    participant_id INT NOT NULL,
    clinical_study_id INT NOT NULL,
    test_id INT NOT NULL,
    test_date DATE NOT NULL,
    result_value DECIMAL(12,3),
    result_text VARCHAR(250),
    result_status VARCHAR(30) NOT NULL,
    FOREIGN KEY (participant_id) REFERENCES participant(participant_id),
    FOREIGN KEY (clinical_study_id) REFERENCES clinical_study(clinical_study_id),
    FOREIGN KEY (test_id) REFERENCES laboratory_test(test_id),
    CHECK (result_status IN ('Normal','Abnormal','Positive','Negative','Inconclusive'))
);

CREATE TABLE adverse_event (
    adverse_event_id INT AUTO_INCREMENT PRIMARY KEY,
    participant_id INT NOT NULL,
    clinical_study_id INT NOT NULL,
    event_date DATE NOT NULL,
    event_type VARCHAR(120) NOT NULL,
    severity VARCHAR(20) NOT NULL,
    seriousness VARCHAR(20) NOT NULL,
    related_to_vaccine VARCHAR(20) NOT NULL,
    outcome VARCHAR(30) NOT NULL,
    action_taken VARCHAR(250),
    resolution_date DATE,
    description VARCHAR(500),
    FOREIGN KEY (participant_id) REFERENCES participant(participant_id),
    FOREIGN KEY (clinical_study_id) REFERENCES clinical_study(clinical_study_id),
    CHECK (severity IN ('Mild','Moderate','Severe')),
    CHECK (seriousness IN ('Non-serious','Serious')),
    CHECK (related_to_vaccine IN ('Unrelated','Unlikely','Possible','Probable','Definite')),
    CHECK (outcome IN ('Recovered','Recovering','Ongoing','Fatal','Unknown')),
    CHECK (resolution_date IS NULL OR resolution_date >= event_date)
);

CREATE INDEX idx_candidate_status ON vaccine_candidate(development_status);
CREATE INDEX idx_batch_formulation ON batch(formulation_id);
CREATE INDEX idx_study_candidate ON clinical_study(candidate_id);
CREATE INDEX idx_enrollment_study ON clinical_enrollment(clinical_study_id);
CREATE INDEX idx_lab_participant_date ON participant_lab_result(participant_id, test_date);
CREATE INDEX idx_event_participant_date ON adverse_event(participant_id, event_date);
