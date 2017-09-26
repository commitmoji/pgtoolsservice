{#
 # pgAdmin 4 - PostgreSQL Tools
 #
 # Copyright (C) 2013 - 2017, The pgAdmin Development Team
 # This software is released under the PostgreSQL Licence
 #}
SELECT  rel.oid,
        nsp.nspname ||'.'|| rel.relname AS name,
        (SELECT count(*) FROM pg_trigger WHERE tgrelid=rel.oid) AS triggercount,
        (SELECT count(*) FROM pg_trigger WHERE tgrelid=rel.oid AND tgenabled = 'O') AS has_enable_triggers,
        nsp.nspname AS schema,
        nsp.oid AS schemaoid,
        rel.relname AS objectname
FROM pg_class rel
INNER JOIN pg_namespace nsp ON rel.relnamespace= nsp.oid
    WHERE rel.relkind IN ('r','t','f') 
    AND  nsp.nspname NOT LIKE E'pg\_%'
     {% if tid %} AND rel.oid = {{tid}}::OID {% endif %}
    ORDER BY nsp.nspname, rel.relname;