USE vaccine_rnd_db;

DROP TRIGGER IF EXISTS trg_validate_adverse_event_date;

DELIMITER $$

CREATE TRIGGER trg_validate_adverse_event_date
BEFORE INSERT ON adverse_event
FOR EACH ROW
BEGIN
    DECLARE enrollment_dt DATE;

    SELECT MIN(enrollment_date)
    INTO enrollment_dt
    FROM clinical_enrollment
    WHERE participant_id = NEW.participant_id
      AND clinical_study_id = NEW.clinical_study_id;

    IF enrollment_dt IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Participant must be enrolled in the clinical study before an adverse event can be recorded.';
    ELSEIF NEW.event_date < enrollment_dt THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Adverse event date cannot be earlier than participant enrollment date.';
    END IF;
END$$

DELIMITER ;
