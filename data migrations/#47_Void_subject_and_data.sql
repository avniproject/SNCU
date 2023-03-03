set role sncu;
---Void individual and their entities
select id
from individual
where uuid in (
               'd809ea7f-45e4-44c8-8bc2-366f57bfab4b',
               'b101e145-a6a2-421d-9c51-af3a9d14ad1c',
               'c6cc049f-2d30-478e-99c0-bc8295e2e0c3',
               'b48da7ec-1940-4f18-bd06-58c36dd51617',
               '48a03c6c-0c3c-4fef-bad4-9b3f84f409ad',
               '6b5643a5-a48f-49f0-9cd4-98935d2e39db',
               '843124f0-db0f-4965-b8d2-f7d5bfb29d88',
               'd8d4531c-bf96-4272-b419-017623ed5f3d',
               '04683a15-f098-4b24-893e-660d12088a44',
               '482fa380-68e4-4669-8eef-03e933efaf3f',
               'e0757cdb-b271-4e95-9b77-6a19576f359f',
               '00851348-83d1-4c7b-b852-56978ab73519',
               'adcb072f-3ce1-46f0-81f8-c92ecd8260dd',
               'cf4d6db0-140b-4d21-b042-9845b6726c84',
               '769f5c6a-2601-4abc-8c25-8a76e883a697',
               '8a61c4dc-3fe4-4c10-85dc-e4c62afd8624',
               '5cb09816-b01b-408e-ba3c-45deb79a1a67',
               '19a4f1ed-0dd9-4a0c-8ad3-b026792cf399',
               '65668893-6012-4577-bf64-8f726df220ee',
               '6c9c72f5-617a-4fa1-ae37-22aa795b7090',
               '18f06172-2594-4dfd-8bbd-af38dfe21ed2',
               'ba1ef0d4-de49-44ca-a46e-b2cb5b0fb002',
               'bacd6f53-30ed-4612-8b24-dd6734058c52',
               '3bf3b0e4-ef4e-4486-93e5-1c086efe41c3'
    );
-----24 rows affected


update individual
set is_voided= true,
    last_modified_date_time=current_timestamp + ((id % 4000) * interval '1 millisecond'),
    last_modified_by_id = (select id from users where username = 'sachink@sncu')
where uuid in (
               'd809ea7f-45e4-44c8-8bc2-366f57bfab4b',
               'b101e145-a6a2-421d-9c51-af3a9d14ad1c',
               'c6cc049f-2d30-478e-99c0-bc8295e2e0c3',
               'b48da7ec-1940-4f18-bd06-58c36dd51617',
               '48a03c6c-0c3c-4fef-bad4-9b3f84f409ad',
               '6b5643a5-a48f-49f0-9cd4-98935d2e39db',
               '843124f0-db0f-4965-b8d2-f7d5bfb29d88',
               'd8d4531c-bf96-4272-b419-017623ed5f3d',
               '04683a15-f098-4b24-893e-660d12088a44',
               '482fa380-68e4-4669-8eef-03e933efaf3f',
               'e0757cdb-b271-4e95-9b77-6a19576f359f',
               '00851348-83d1-4c7b-b852-56978ab73519',
               'adcb072f-3ce1-46f0-81f8-c92ecd8260dd',
               'cf4d6db0-140b-4d21-b042-9845b6726c84',
               '769f5c6a-2601-4abc-8c25-8a76e883a697',
               '8a61c4dc-3fe4-4c10-85dc-e4c62afd8624',
               '5cb09816-b01b-408e-ba3c-45deb79a1a67',
               '19a4f1ed-0dd9-4a0c-8ad3-b026792cf399',
               '65668893-6012-4577-bf64-8f726df220ee',
               '6c9c72f5-617a-4fa1-ae37-22aa795b7090',
               '18f06172-2594-4dfd-8bbd-af38dfe21ed2',
               'ba1ef0d4-de49-44ca-a46e-b2cb5b0fb002',
               'bacd6f53-30ed-4612-8b24-dd6734058c52',
               '3bf3b0e4-ef4e-4486-93e5-1c086efe41c3'
    )
;
----- 21 rows affected---


update program_enrolment
set is_voided= true,
    last_modified_date_time=current_timestamp + ((id % 4000) * interval '1 millisecond'),
    last_modified_by_id = (select id from users where username = 'sachink@sncu')
where individual_id in (select id
                        from individual
                        where uuid in (
                                       'd809ea7f-45e4-44c8-8bc2-366f57bfab4b',
                                       'b101e145-a6a2-421d-9c51-af3a9d14ad1c',
                                       'c6cc049f-2d30-478e-99c0-bc8295e2e0c3',
                                       'b48da7ec-1940-4f18-bd06-58c36dd51617',
                                       '48a03c6c-0c3c-4fef-bad4-9b3f84f409ad',
                                       '6b5643a5-a48f-49f0-9cd4-98935d2e39db',
                                       '843124f0-db0f-4965-b8d2-f7d5bfb29d88',
                                       'd8d4531c-bf96-4272-b419-017623ed5f3d',
                                       '04683a15-f098-4b24-893e-660d12088a44',
                                       '482fa380-68e4-4669-8eef-03e933efaf3f',
                                       'e0757cdb-b271-4e95-9b77-6a19576f359f',
                                       '00851348-83d1-4c7b-b852-56978ab73519',
                                       'adcb072f-3ce1-46f0-81f8-c92ecd8260dd',
                                       'cf4d6db0-140b-4d21-b042-9845b6726c84',
                                       '769f5c6a-2601-4abc-8c25-8a76e883a697',
                                       '8a61c4dc-3fe4-4c10-85dc-e4c62afd8624',
                                       '5cb09816-b01b-408e-ba3c-45deb79a1a67',
                                       '19a4f1ed-0dd9-4a0c-8ad3-b026792cf399',
                                       '65668893-6012-4577-bf64-8f726df220ee',
                                       '6c9c72f5-617a-4fa1-ae37-22aa795b7090',
                                       '18f06172-2594-4dfd-8bbd-af38dfe21ed2',
                                       'ba1ef0d4-de49-44ca-a46e-b2cb5b0fb002',
                                       'bacd6f53-30ed-4612-8b24-dd6734058c52',
                                       '3bf3b0e4-ef4e-4486-93e5-1c086efe41c3')
)
;


update program_encounter
set is_voided= true,
    last_modified_date_time=current_timestamp + ((id % 4000) * interval '1 millisecond'),
    last_modified_by_id = (select id from users where username = 'sachink@sncu')
where individual_id in (select id
                        from individual
                        where uuid in (
                                       'd809ea7f-45e4-44c8-8bc2-366f57bfab4b',
                                       'b101e145-a6a2-421d-9c51-af3a9d14ad1c',
                                       'c6cc049f-2d30-478e-99c0-bc8295e2e0c3',
                                       'b48da7ec-1940-4f18-bd06-58c36dd51617',
                                       '48a03c6c-0c3c-4fef-bad4-9b3f84f409ad',
                                       '6b5643a5-a48f-49f0-9cd4-98935d2e39db',
                                       '843124f0-db0f-4965-b8d2-f7d5bfb29d88',
                                       'd8d4531c-bf96-4272-b419-017623ed5f3d',
                                       '04683a15-f098-4b24-893e-660d12088a44',
                                       '482fa380-68e4-4669-8eef-03e933efaf3f',
                                       'e0757cdb-b271-4e95-9b77-6a19576f359f',
                                       '00851348-83d1-4c7b-b852-56978ab73519',
                                       'adcb072f-3ce1-46f0-81f8-c92ecd8260dd',
                                       'cf4d6db0-140b-4d21-b042-9845b6726c84',
                                       '769f5c6a-2601-4abc-8c25-8a76e883a697',
                                       '8a61c4dc-3fe4-4c10-85dc-e4c62afd8624',
                                       '5cb09816-b01b-408e-ba3c-45deb79a1a67',
                                       '19a4f1ed-0dd9-4a0c-8ad3-b026792cf399',
                                       '65668893-6012-4577-bf64-8f726df220ee',
                                       '6c9c72f5-617a-4fa1-ae37-22aa795b7090',
                                       '18f06172-2594-4dfd-8bbd-af38dfe21ed2',
                                       'ba1ef0d4-de49-44ca-a46e-b2cb5b0fb002',
                                       'bacd6f53-30ed-4612-8b24-dd6734058c52',
                                       '3bf3b0e4-ef4e-4486-93e5-1c086efe41c3')
)


----133 rows affected