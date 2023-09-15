---------------------------------------------- Query to update single select to multiselect -----------------------------------------------

set role sncu;

select * from program_encounter pe ;

select * from encounter_type et where name in ('Child Followup','Child PNC'); -- id = 594, 595

select * from concept where name = 'Reason of death'; -- uuid = '7c88aea6-dfed-451e-a086-881e2dcfd85f'

select * from users where username = 'taqi@sncu'; -- id = 9158

-- Actual script to convert the single select coded concept to multi select coded concept for the question "Reason of death"

update program_encounter 
set cancel_observations  = cancel_observations || json_build_object('7c88aea6-dfed-451e-a086-881e2dcfd85f',
                                                     array [cancel_observations  ->> '7c88aea6-dfed-451e-a086-881e2dcfd85f'])::jsonb,
    last_modified_by_id = 9158,
    last_modified_date_time = current_timestamp + ((id % 4000) * interval '1 millisecond')
where cancel_date_time is not null
and cancel_observations  ->> '7c88aea6-dfed-451e-a086-881e2dcfd85f' is not null
and (cancel_observations  ->> '7c88aea6-dfed-451e-a086-881e2dcfd85f')::text not like '[%'
and encounter_type_id in (594, 595);


select * from program_encounter pe 
where encounter_type_id in (594, 595)
and cancel_date_time is not null
and cancel_observations  ->> '7c88aea6-dfed-451e-a086-881e2dcfd85f' is not null
and (cancel_observations  ->> '7c88aea6-dfed-451e-a086-881e2dcfd85f')::text not like '[%'
;
