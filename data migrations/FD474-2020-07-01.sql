-- Update audits for the two rows that are in translations
set role sncu;
select * from audit where id in (select audit_id from translation);