-- Week 1 Task - Yuva Intern - Medical Coding Strategic Plan
-- By Aasha Makavana - File 2

-- Rule 1: Auto POS 10 vs 02 - CMS 2025
UPDATE virtual_claims
SET POS_Code = CASE
    WHEN patient_address_type = 'home' THEN '10'
    ELSE '02'
END
WHERE encounter_type IN ('video', 'audio', 'chat');

-- Rule 2: Auto Modifier 95/GT/GQ
UPDATE virtual_claims
SET Modifier = CASE
    WHEN encounter_type = 'video' THEN '95'
    WHEN encounter_type = 'chat' THEN 'GQ'
    ELSE Modifier
END
WHERE encounter_type IN ('video','chat');

-- Rule 3: Time-based CPT 99421-99423
UPDATE virtual_claims
SET CPT_Code = CASE
    WHEN duration_minutes BETWEEN 5 AND 10 THEN '99421'
    WHEN duration_minutes BETWEEN 11 AND 20 THEN '99422'
    WHEN duration_minutes >= 21 THEN '99423'
    ELSE CPT_Code
END
WHERE encounter_type = 'chat';

-- Rule 4: NDC Bundle G9001
CREATE TABLE IF NOT EXISTS hcpcs_bundle (
    bundle_code VARCHAR(20) PRIMARY KEY,
    bundle_name VARCHAR(100),
    price INT
);
INSERT INTO hcpcs_bundle VALUES ('G9001', 'Diabetes Care Kit - Retail', 1200);

-- Rule 5: Scrubber Check
SELECT ClaimID FROM virtual_claims
WHERE encounter_type IN ('video','chat') AND Modifier = '';

-- Rule 6: Denial Risk Flag
UPDATE virtual_claims SET denial_risk='HIGH'
WHERE POS_Code IS NULL OR Modifier IS NULL;