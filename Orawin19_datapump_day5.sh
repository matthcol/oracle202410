# Import/Export avec Data Pump
# Doc: https://docs.oracle.com/en/database/oracle/oracle-database/19/sutil/oracle-data-pump.html

# avec user system
expdp DUMPFILE=backup_full.dump FULL=YES

# avec user system ou autre (privilege sur le DIRECTORY)
# NB: en étant dans le répertoire du fichier de paramétrage
expdp PARFILE=export_schema_movie.param

# 2e fois: échec
expdp PARFILE=export_schema_movie.param

# avec param REUSE_DUMPFILES
expdp PARFILE=export_schema_movie_w.param

# reprendre la main sur 1 job en cours
# NB: si on n'a pas le nom du job, en SQL: select * from dba_datapump_jobs
# * commandes possibles: help, continue_client, kill_job, ...
expdp ATTACH=export_schema_movie_etc

# NB: pour garantir la consistence du backup, utiliser l'option FLASHBACK_SCN=scn_value (ou DLASHBACK_TIME)


# Restore avec dump
# on a perdu la table play
impdp PARFILE=imp_table_play.param
