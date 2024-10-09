set pages 999
set lines 400
def sep='\'
column auto_ext format a9
column filename format a30
SELECT 
 SUBSTR (df.file_name, 
   INSTR (df.file_name, '&sep', -1)+1) filename,
 df.tablespace_name tablespace_name,
 df.autoextensible auto_ext,
 round(df.maxbytes / (1024 * 1024), 2) max_ts_size,
 round((df.bytes - sum(fs.bytes)) / (df.maxbytes) * 100, 2) max_ts_pct_used,
 round(df.bytes / (1024 * 1024), 2) curr_ts_size,
 round((df.bytes - sum(fs.bytes)) / (1024 * 1024), 2) used_ts_size,
 round((df.bytes-sum(fs.bytes)) * 100 / df.bytes, 2) ts_pct_used,
 nvl(round(sum(fs.bytes) / (1024 * 1024), 2), 0) free_ts_size,
 nvl(round(sum(fs.bytes) * 100 / df.bytes, 2), 0) ts_pct_free
FROM dba_free_space fs,
 (select
 file_id,
 file_name,
 tablespace_name,
 bytes,
 decode(maxbytes, 0, bytes, maxbytes) maxbytes,
 autoextensible
 from dba_data_files
 ) df
WHERE fs.file_id (+) = df.file_id
GROUP BY df.file_id, df.file_name, df.tablespace_name, df.bytes, df.maxbytes, df.autoextensible
UNION ALL
SELECT 
 SUBSTR (df.file_name, 
   INSTR (df.file_name, '&sep', -1)+1) filename,
 df.tablespace_name tablespace_name,
 autoextensible auto_ext,
 round(df.maxbytes / (1024 * 1024), 2) max_ts_size,
 round((df.bytes - sum(fs.bytes)) / (df.maxbytes) * 100, 2) max_ts_pct_used,
 round(df.bytes / (1024 * 1024), 2) curr_ts_size,
 round((df.bytes - sum(fs.bytes)) / (1024 * 1024), 2) used_ts_size,
 round((df.bytes-sum(fs.bytes)) * 100 / df.bytes, 2) ts_pct_used,
 round(sum(fs.bytes) / (1024 * 1024), 2) free_ts_size,
 nvl(round(sum(fs.bytes) * 100 / df.bytes), 2) ts_pct_free
FROM (select 
 file_id, tablespace_name, bytes_used bytes
 from V$temp_space_header
 group by file_id, tablespace_name, bytes_free, bytes_used) fs,
 (select
 file_id,  
 file_name,
 tablespace_name,
 bytes,
 decode(maxbytes, 0, bytes, maxbytes) maxbytes,
 autoextensible
 from dba_temp_files
 ) df
WHERE fs.file_id (+) = df.file_id
GROUP BY df.file_id, df.file_name, df.tablespace_name, df.bytes, df.maxbytes, df.autoextensible
ORDER BY 1,2;