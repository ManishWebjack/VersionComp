Create function compare_version(_version1 character varying,_version2 character varying)
language plpgsql
as $$
DECLARE
  _result int := 0;
BEGIN

SELECT CASE WHEN (ver1::int) < (ver2::int) then 1 else -1 END
into _result
FROM
(
  SELECT
    UNNSET(string_to_array(_version1, ',')::int) var1,
    UNNSET(string_to_array(_version2, ',')::int) var2
) AS a
WHERE
  a.ver1 <> a.ver2 LIMIT 1;

RETURN COALESCE(nullif(_result,null),0);

END $$;
