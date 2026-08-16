USE vaccine_rnd_db;

-- 1. Basic SELECT
SELECT * FROM vaccine_candidate;

-- 2. Filtering
SELECT candidate_code, candidate_name, development_status
FROM vaccine_candidate
WHERE development_status IN ('Phase I','Phase II','Phase III');

-- 3. JOIN: candidates and formulations
SELECT vc.candidate_code, vc.candidate_name, f.formulation_code, f.dose_amount, f.dose_unit
FROM vaccine_candidate vc
JOIN formulation f ON vc.candidate_id = f.candidate_id;

-- 4. Multi-table JOIN: study summary
SELECT cs.study_code, vc.candidate_name, cp.phase_name, cs.study_status
FROM clinical_study cs
JOIN vaccine_candidate vc ON cs.candidate_id = vc.candidate_id
JOIN clinical_phase cp ON cs.phase_id = cp.phase_id;

-- 5. Aggregation: formulations per candidate
SELECT vc.candidate_code, COUNT(f.formulation_id) AS formulation_count
FROM vaccine_candidate vc
LEFT JOIN formulation f ON vc.candidate_id = f.candidate_id
GROUP BY vc.candidate_id, vc.candidate_code;

-- 6. Aggregation: adverse events by study
SELECT cs.study_code, COUNT(ae.adverse_event_id) AS adverse_event_count
FROM clinical_study cs
LEFT JOIN adverse_event ae ON cs.clinical_study_id = ae.clinical_study_id
GROUP BY cs.clinical_study_id, cs.study_code;

-- 7. HAVING
SELECT clinical_study_id, COUNT(*) AS participant_count
FROM clinical_enrollment
GROUP BY clinical_study_id
HAVING COUNT(*) >= 2;

-- 8. Subquery: candidates with more formulations than average
SELECT candidate_code, candidate_name
FROM vaccine_candidate
WHERE candidate_id IN (
    SELECT candidate_id
    FROM formulation
    GROUP BY candidate_id
    HAVING COUNT(*) > (SELECT AVG(formulation_count)
                       FROM (SELECT COUNT(*) AS formulation_count
                             FROM formulation
                             GROUP BY candidate_id) x)
);

-- 9. Participants with adverse events
SELECT DISTINCT p.participant_code
FROM participant p
JOIN adverse_event ae ON p.participant_id = ae.participant_id;

-- 10. Lab results with participant and test
SELECT p.participant_code, lt.test_name, plr.test_date, plr.result_value, plr.result_status
FROM participant_lab_result plr
JOIN participant p ON plr.participant_id = p.participant_id
JOIN laboratory_test lt ON plr.test_id = lt.test_id;

-- 11. INSERT demonstration
INSERT INTO antigen
(antigen_code, antigen_name, pathogen, antigen_type, target_protein, description)
VALUES ('AG011','Demo Antigen','Demo Pathogen','Protein','Demo Protein','Temporary demonstration record.');

-- 12. UPDATE demonstration
UPDATE antigen
SET description = 'Updated demonstration record.'
WHERE antigen_code = 'AG011';

-- 13. DELETE demonstration
DELETE FROM antigen
WHERE antigen_code = 'AG011';
