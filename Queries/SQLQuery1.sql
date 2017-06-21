use springfieldprod
go

SELECT 
	TableName	=	object_name( idx.object_id )
  , IndexName	=	idx.name
  , ColumnName	=	col.name 
  , ixc.is_included_column 
FROM 
	sys.indexes AS idx
INNER JOIN
	sys.index_columns AS ixc
		ON ixc.object_id = idx.object_id 
			AND ixc.index_id = idx.index_id
INNER JOIN 
	sys.columns AS col 
		ON col.column_id = ixc.column_id	
			and col.object_id = ixc.object_id
WHERE 
	idx.object_id > 100
Order by 
	1, 2, ixc.index_column_id 