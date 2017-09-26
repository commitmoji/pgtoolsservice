{#
 # pgAdmin 4 - PostgreSQL Tools
 #
 # Copyright (C) 2013 - 2017, The pgAdmin Development Team
 # This software is released under the PostgreSQL Licence
 #}
SELECT
    rel.oid,
    nsp.nspname || '.' || rel.relname AS name
FROM pg_class rel
INNER JOIN pg_namespace nsp ON rel.relnamespace= nsp.oid
WHERE
  rel.relkind = 'v'
  {% if (vid and datlastsysoid) %}
        AND c.oid = {{vid}}::oid
    {% endif %}
ORDER BY nsp.nspname, rel.relname