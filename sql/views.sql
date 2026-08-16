USE vaccine_rnd_db;

CREATE OR REPLACE VIEW vw_clinical_study_summary AS
SELECT
    cs.study_code,
    vc.candidate_name,
    cp.phase_name,
    cs.study_status,
    COUNT(DISTINCT ce.participant_id) AS enrolled_participants,
    COUNT(DISTINCT css.site_id) AS participating_sites
FROM clinical_study cs
JOIN vaccine_candidate vc ON cs.candidate_id = vc.candidate_id
JOIN clinical_phase cp ON cs.phase_id = cp.phase_id
LEFT JOIN clinical_enrollment ce ON cs.clinical_study_id = ce.clinical_study_id
LEFT JOIN clinical_study_site css ON cs.clinical_study_id = css.clinical_study_id
GROUP BY cs.clinical_study_id, cs.study_code, vc.candidate_name, cp.phase_name, cs.study_status;

CREATE OR REPLACE VIEW vw_adverse_event_summary AS
SELECT
    vc.candidate_name,
    cs.study_code,
    ae.severity,
    ae.seriousness,
    ae.related_to_vaccine,
    COUNT(*) AS event_count
FROM adverse_event ae
JOIN clinical_study cs ON ae.clinical_study_id = cs.clinical_study_id
JOIN vaccine_candidate vc ON cs.candidate_id = vc.candidate_id
GROUP BY vc.candidate_name, cs.study_code, ae.severity, ae.seriousness, ae.related_to_vaccine;
