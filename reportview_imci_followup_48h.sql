CREATE OR REPLACE VIEW public.reportview_imci_followup_48h
AS SELECT reports.doc ->> '_id'::text AS report_uuid,
    to_timestamp((((reports.doc ->> 'reported_date'::text)::bigint) / 1000)::double precision) AS report_date,
    reports.doc ->> 'form'::text AS which_report,
    reports.doc #>> '{contact,parent,_id}'::text[] AS hh_uuid,
    reports.doc #>> '{fields,patient_uuid}'::text[] AS hhmem_uuid,
    reports.doc #>> '{contact,_id}'::text[] AS chc_uuid,
    reports.doc #>> '{fields,patient_id}'::text[] AS patient_id,
    reports.doc #>> '{fields,patient_age_in_months}'::text[] AS patient_age_months,
    reports.doc #>> '{fields,patient_age_in_years}'::text[] AS patient_age_years,
    reports.doc #>> '{fields,g_visit,visit_rhu}'::text[] AS rhu_visit,
    reports.doc #>> '{fields,g_input,diagnosis}'::text[] AS rhuvisit_yes_diagnosis,
    reports.doc #>> '{fields,g_input,treatment}'::text[] AS rhuvisit_yes_treatment,
    reports.doc #>> '{fields,g_input,appointment_required}'::text[] AS appointment_req,
    reports.doc #>> '{fields,g_input,appointment_date}'::text[] AS appt_req_date,
    reports.doc #>> '{fields,g_input,symptom_state}'::text[] AS appt_symptom_state,
    reports.doc #>> '{fields,g_input,treatment_state}'::text[] AS appt_treatment_state,
    reports.doc #>> '{fields,g_imci,imci_signs}'::text[] AS imci_signs,
    reports.doc #>> '{fields,g_imci,cough_signs}'::text[] AS cough_signs_status,
    reports.doc #>> '{fields,g_imci,diarrhoea_signs}'::text[] AS diarrhea_signs_status,
    reports.doc #>> '{fields,g_imci,fever_signs}'::text[] AS fever_signs_status,
    reports.doc #>> '{fields,g_imci,ear_signs}'::text[] AS ear_signs_status,
    reports.doc #>> '{fields,g_imci,imci_danger_signs}'::text[] AS imci_danger_signs,
    reports.doc #>> '{fields,g_imci,g_referral_2,imci_referral_given}'::text[] AS imci_referral
   FROM raw_reports reports
  WHERE (reports.doc ->> 'form'::text) = 'imci_followup_48h'::text
  ORDER BY (to_timestamp((((reports.doc ->> 'reported_date'::text)::bigint) / 1000)::double precision)) DESC;