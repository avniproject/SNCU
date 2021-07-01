-- Update audits for the two rows that are in translations
set role sncu;
update audit
set last_modified_date_time = now()
where id in (select audit_id from translation);