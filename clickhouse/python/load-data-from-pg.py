import psycopg2
from clickhouse_driver import Client

pg_conn = psycopg2.connect(
    dbname="asuse",
    user="asuse",
    password="kl0pik",
    host="asuse-ai-dev.infoenergo.loc",
    port="5432",
)
pg_cursor = pg_conn.cursor()

ch_client = Client("localhost")
ch_client.execute("TRUNCATE TABLE msr_fin")
pg_cursor.execute('SELECT * FROM report_dm.msr_фин')

chunk_size = 1000
portion = 0
while True:
    pg_data = pg_cursor.fetchmany(chunk_size)
    if not pg_data:
        break
    portion += 1
    print(pg_data)
    print("portion:", portion)
    ch_client.execute("INSERT INTO msr_fin FORMAT TabSeparated", pg_data, types_check=True)
